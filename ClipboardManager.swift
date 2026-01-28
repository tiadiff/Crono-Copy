import Cocoa
import Foundation

// Configuration
let MAX_HISTORY = 20
let HISTORY_FILE = "history.json"

class AppDelegate: NSObject, NSApplicationDelegate, NSMenuDelegate {
    var statusItem: NSStatusItem!
    var history: [String] = []
    var lastChangeCount: Int = 0
    var timer: Timer?
    
    // File path for history.json (in current directory)
    var historyPath: URL {
        let currentDir = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        return currentDir.appendingPathComponent(HISTORY_FILE)
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Hide dock icon
        NSApp.setActivationPolicy(.accessory)
        
        // Setup Menu Bar
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusItem.button {
            // Use SF Symbol "paperclip" or "doc.on.clipboard"
            if #available(macOS 11.0, *) {
                let image = NSImage(systemSymbolName: "doc.on.clipboard", accessibilityDescription: "Clipboard")
                image?.isTemplate = true // Adapts to dark/light mode
                button.image = image
            } else {
                button.title = "Clip"
            }
        }
        
        // Load History
        loadHistory()
        
        // build initial menu
        updateMenu()
        
        // Start Monitoring
        lastChangeCount = NSPasteboard.general.changeCount
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            self.checkClipboard()
        }
    }
    
    func checkClipboard() {
        let pb = NSPasteboard.general
        if pb.changeCount != lastChangeCount {
            lastChangeCount = pb.changeCount
            
            if let content = pb.string(forType: .string) {
                // Avoid duplicates at the top
                if history.first != content {
                    // Update model
                    history.insert(content, at: 0)
                    if history.count > MAX_HISTORY {
                        history = Array(history.prefix(MAX_HISTORY))
                    }
                    saveHistory()
                    updateMenu()
                }
            }
        }
    }
    
    func updateMenu() {
        let menu = NSMenu()
        menu.delegate = self
        
        // History Items
        for (index, text) in history.enumerated() {
            let truncated = text.prefix(30) + (text.count > 30 ? "..." : "")
            let item = NSMenuItem(title: String(truncated), action: #selector(copyToClipboard(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = text
            menu.addItem(item)
        }
        
        // Separator
        if !history.isEmpty {
            menu.addItem(NSMenuItem.separator())
        }
        
        // Controls
        let resetItem = NSMenuItem(title: "Reset History", action: #selector(resetHistory(_:)), keyEquivalent: "")
        resetItem.target = self
        menu.addItem(resetItem)
        
        menu.addItem(NSMenuItem.separator())
        
        let quitItem = NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")
        menu.addItem(quitItem)
        
        statusItem.menu = menu
    }
    
    @objc func copyToClipboard(_ sender: NSMenuItem) {
        if let text = sender.representedObject as? String {
            let pb = NSPasteboard.general
            pb.clearContents()
            pb.setString(text, forType: .string)
            // Update lastChangeCount so we don't re-capture our own copy immediately (optional, or let it flow)
             lastChangeCount = pb.changeCount
        }
    }
    
    @objc func resetHistory(_ sender: Any) {
        history.removeAll()
        saveHistory()
        updateMenu()
    }
    
    // Persistence
    func loadHistory() {
        do {
            let data = try Data(contentsOf: historyPath)
            history = try JSONDecoder().decode([String].self, from: data)
        } catch {
            print("No history found or error loading: \(error)")
            history = []
        }
    }
    
    func saveHistory() {
        do {
            let data = try JSONEncoder().encode(history)
            try data.write(to: historyPath)
        } catch {
            print("Error saving history: \(error)")
        }
    }
}

// Main Entry Point
let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
