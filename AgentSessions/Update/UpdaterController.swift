import Cocoa

/// Self-updates are intentionally disabled in this independent localized build.
@MainActor
final class UpdaterController: NSObject, ObservableObject {
    static var shared: UpdaterController?

    @Published var hasGentleReminder: Bool = false

    var updater: Any? { nil }

    var autoUpdateEnabled: Bool {
        get { false }
        set { }
    }

    @objc func checkForUpdates(_ sender: Any?) {
        _ = sender
    }
}
