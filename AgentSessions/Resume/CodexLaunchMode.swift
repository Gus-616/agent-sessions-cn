import Foundation

enum CodexLaunchMode: String, CaseIterable, Identifiable {
    case embedded
    case terminal
    case iterm

    var id: String { rawValue }

    static func selectedResumeTerminalTitle(defaults: UserDefaults = .standard) -> String {
        if let raw = defaults.string(forKey: CodexResumeSettings.Keys.defaultLaunchMode),
           let mode = CodexLaunchMode(rawValue: raw),
           mode != .embedded {
            return mode.title
        }

        let claudePrefersITerm = defaults.object(forKey: ClaudeResumeSettings.Keys.preferITerm) as? Bool ?? false
        return claudePrefersITerm ? CodexLaunchMode.iterm.title : CodexLaunchMode.terminal.title
    }

    var title: String {
        switch self {
        case .embedded:
            return String(localized: "Embedded")
        case .terminal:
            return String(localized: "Terminal")
        case .iterm:
            return "iTerm2"
        }
    }

    var help: String {
        switch self {
        case .embedded:
            return String(localized: "Run Codex inside Agent Sessions and stream output here.")
        case .terminal:
            return String(localized: "Open Codex in Terminal.app and continue the session there.")
        case .iterm:
            return String(localized: "Open Codex in iTerm2 and continue the session there.")
        }
    }
}
