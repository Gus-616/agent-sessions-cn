import Foundation

/// Identifies the source/type of a session (Codex CLI vs Claude Code)
public enum SessionSource: String, Codable, CaseIterable, Sendable {
    case codex = "codex"
    case claude = "claude"
    case gemini = "gemini"
    case opencode = "opencode"
    case copilot = "copilot"
    case droid = "droid"
    case openclaw = "openclaw"
    case cursor = "cursor"

    public var displayName: String {
        switch self {
        case .codex: return String(localized: "Codex CLI")
        case .claude: return String(localized: "Claude Code")
        case .gemini: return String(localized: "Gemini")
        case .opencode: return String(localized: "OpenCode")
        case .copilot: return String(localized: "Copilot CLI")
        case .droid: return String(localized: "Droid")
        case .openclaw: return String(localized: "OpenClaw")
        case .cursor: return String(localized: "Cursor")
        }
    }

    public var iconName: String {
        switch self {
        case .codex: return "terminal"
        case .claude: return "command"
        case .gemini: return "sparkles"
        case .opencode: return "chevron.left.slash.chevron.right"
        case .copilot: return "bolt.horizontal.circle"
        case .droid: return "d.circle"
        case .openclaw: return "pawprint"
        case .cursor: return "cursorarrow.rays"
        }
    }

    public var versionIntroduced: String {
        switch self {
        case .codex, .claude:   return "1.0"
        case .gemini:           return "2.5"
        case .opencode:         return "2.8"
        case .copilot:          return "2.11"
        case .droid:            return "3.0"
        case .openclaw:         return "3.1"
        case .cursor:           return "3.2"
        }
    }

    public var featureDescription: String {
        switch self {
        case .codex:    return String(localized: "Track your Codex CLI coding sessions")
        case .claude:   return String(localized: "Browse your Claude Code conversations")
        case .gemini:   return String(localized: "View your Gemini CLI interactions")
        case .opencode: return String(localized: "Review your OpenCode sessions")
        case .copilot:  return String(localized: "Browse your GitHub Copilot chat history")
        case .droid:    return String(localized: "View your Droid agent sessions")
        case .openclaw: return String(localized: "Explore your OpenClaw conversations")
        case .cursor:   return String(localized: "Import and search your Cursor AI sessions")
        }
    }
}
