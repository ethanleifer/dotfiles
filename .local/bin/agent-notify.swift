// Build: swiftc ~/.local/bin/agent-notify.swift -o ~/.local/bin/agent-notify -framework Cocoa
// Usage: ~/.local/bin/agent-notify "Title" "Message"

import Cocoa

class NotificationWindow: NSWindow {
    init(title: String, message: String) {
        let width: CGFloat = 340
        let height: CGFloat = 90
        let screen = NSScreen.main!
        let x = screen.visibleFrame.maxX - width - 16
        let y = screen.visibleFrame.maxY - height - 16

        super.init(
            contentRect: NSRect(x: x, y: y, width: width, height: height),
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )

        self.level = .floating
        self.isOpaque = false
        self.backgroundColor = .clear
        self.collectionBehavior = [.canJoinAllSpaces, .stationary]

        let visual = NSVisualEffectView(frame: NSRect(x: 0, y: 0, width: width, height: height))
        visual.material = .hudWindow
        visual.state = .active
        visual.wantsLayer = true
        visual.layer?.cornerRadius = 14
        visual.layer?.masksToBounds = true

        let titleLabel = NSTextField(labelWithString: title)
        titleLabel.font = NSFont.boldSystemFont(ofSize: 14)
        titleLabel.textColor = .white
        titleLabel.frame = NSRect(x: 16, y: height - 36, width: width - 32, height: 20)

        let messageLabel = NSTextField(labelWithString: message)
        messageLabel.font = NSFont.systemFont(ofSize: 12)
        messageLabel.textColor = .secondaryLabelColor
        messageLabel.frame = NSRect(x: 16, y: 12, width: width - 32, height: height - 48)
        messageLabel.maximumNumberOfLines = 2
        messageLabel.lineBreakMode = .byTruncatingTail

        visual.addSubview(titleLabel)
        visual.addSubview(messageLabel)
        self.contentView = visual
    }
}

let app = NSApplication.shared
app.setActivationPolicy(.accessory)

let args = CommandLine.arguments
let title = args.count > 1 ? args[1] : "Agent"
let message = args.count > 2 ? args[2] : "Needs attention"

let window = NotificationWindow(title: title, message: message)
window.orderFrontRegardless()

DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
    NSAnimationContext.runAnimationGroup({ context in
        context.duration = 0.3
        window.animator().alphaValue = 0
    }, completionHandler: {
        app.terminate(nil)
    })
}

app.run()
