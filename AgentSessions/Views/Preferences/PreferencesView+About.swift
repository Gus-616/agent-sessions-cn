import SwiftUI
import AppKit

extension PreferencesView {

    var aboutTab: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("About")
                .font(.title2)
                .fontWeight(.semibold)

            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    if let appIcon = NSImage(named: NSImage.applicationIconName) {
                        Image(nsImage: appIcon)
                            .resizable()
                            .frame(width: 16, height: 16)
                            .cornerRadius(3)
                    }
                    Text("Agent Sessions")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                Text("This edition is based on jazzyalex's original Agent Sessions project and has been adapted with Chinese localization by Gus616.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                Divider()
            }
            VStack(alignment: .leading, spacing: 12) {
                labeledRow("Version:") {
                    if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                        Text(version)
                            .font(.system(.body, design: .monospaced))
                    } else {
                        Text("Unknown")
                            .foregroundStyle(.secondary)
                    }
                }

                labeledRow("Security & Privacy:") {
                    Button("Security & Privacy") {
                        openAboutURL("https://github.com/jazzyalex/agent-sessions/blob/main/docs/security.md")
                    }
                    .buttonStyle(.link)
                }

                labeledRow("License:") {
                    Button("MIT License") {
                        openAboutURL("https://github.com/jazzyalex/agent-sessions/blob/main/LICENSE")
                    }
                    .buttonStyle(.link)
                }

                labeledRow("Original Website:") {
                    Button("jazzyalex.github.io/agent-sessions") {
                        openAboutURL("https://jazzyalex.github.io/agent-sessions/")
                    }
                    .buttonStyle(.link)
                }

                labeledRow("Original GitHub:") {
                    Button("github.com/jazzyalex/agent-sessions") {
                        openAboutURL("https://github.com/jazzyalex/agent-sessions")
                    }
                    .buttonStyle(.link)
                }

                labeledRow("Original Author:") {
                    Button("jazzyalex (@jazzyalex)") {
                        openAboutURL("https://x.com/jazzyalex")
                    }
                    .buttonStyle(.link)
                }
            }

            sectionHeader("Diagnostics")
            VStack(alignment: .leading, spacing: 12) {
                Text("Crash reports are collected locally. Use the email link below to open a pre-filled report email.")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                labeledRow("Email:") {
                    Button("jazzyalex@gmail.com") {
                        sendPendingCrashReports()
                    }
                    .buttonStyle(.link)
                    .help("Open a pre-filled email draft with the latest crash report in the message body.")
                }

                labeledRow("Pending reports:") {
                    Text("\(crashPendingCount)")
                        .font(.system(.body, design: .monospaced))
                }

                labeledRow("Last detected:") {
                    if let date = crashLastDetectedAt {
                        Text(AppDateFormatting.dateTimeMedium(date))
                            .font(.system(.body, design: .monospaced))
                    } else {
                        Text("None")
                            .foregroundStyle(.secondary)
                    }
                }

                labeledRow("Last email draft:") {
                    if let date = crashLastSendAt {
                        Text(AppDateFormatting.dateTimeMedium(date))
                            .font(.system(.body, design: .monospaced))
                    } else {
                        Text("Never")
                            .foregroundStyle(.secondary)
                    }
                }

                if let sendError = crashLastSendError, !sendError.isEmpty {
                    PreferenceCallout(
                        iconName: "exclamationmark.triangle.fill",
                        tint: .orange
                    ) {
                        Text(sendError)
                            .font(.caption)
                    }
                }

                HStack(spacing: 12) {
                    Button(isCrashSendRunning ? "Preparing..." : "Email Crash Report") {
                        sendPendingCrashReports()
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(isCrashSendRunning || crashPendingCount == 0)
                    .help("Open the default email app with a pre-filled crash report draft.")

                    Button("Export Report") {
                        exportLatestCrashReport()
                    }
                    .buttonStyle(.bordered)
                    .disabled(crashPendingCount == 0)
                    .help("Export the most recent queued crash report as JSON.")

                    Button("Clear Pending") {
                        showCrashClearConfirm = true
                    }
                    .buttonStyle(.bordered)
                    .disabled(crashPendingCount == 0)
                    .help("Delete all queued crash reports from local storage.")
                }

            }

            Spacer()
        }
        .onAppear {
            refreshCrashDiagnosticsState()
        }
        .alert("Crash Reports", isPresented: $showCrashSendResult) {
            Button("Close", role: .cancel) {}
        } message: {
            Text(crashSendResultMessage)
        }
        .alert("Clear Pending Crash Reports?", isPresented: $showCrashClearConfirm) {
            Button("Cancel", role: .cancel) {}
            Button("Clear", role: .destructive) {
                clearPendingCrashReports()
            }
        } message: {
            Text("This removes all queued crash reports from local storage.")
        }
        .alert("Export Failed", isPresented: $showCrashExportError) {
            Button("Close", role: .cancel) {}
        } message: {
            Text(crashExportErrorMessage)
        }
    }

    private func openAboutURL(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        NSWorkspace.shared.open(url)
    }
}
