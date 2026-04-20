import Foundation

enum MenuBarScope: String, CaseIterable, Identifiable {
    case fiveHour
    case weekly
    case both
    var id: String { rawValue }
    var title: String {
        switch self {
        case .fiveHour: return String(localized: "5h only")
        case .weekly: return String(localized: "Weekly only")
        case .both: return String(localized: "Both")
        }
    }
}

enum MenuBarStyleKind: String, CaseIterable, Identifiable {
    case bars
    case numbers
    var id: String { rawValue }
    var title: String { self == .bars ? String(localized: "Bars") : String(localized: "Numbers only") }
}

enum MenuBarSource: String, CaseIterable, Identifiable {
    case codex
    case claude
    case both
    var id: String { rawValue }
    var title: String {
        switch self {
        case .codex: return String(localized: "Codex")
        case .claude: return String(localized: "Claude")
        case .both: return String(localized: "Both")
        }
    }
}
