import SwiftUI
import EventKit

@main
struct CalSyncApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        SwiftUI.Settings {
            SettingsView()
                .environmentObject(appDelegate.syncEngine)
        }
    }
}
