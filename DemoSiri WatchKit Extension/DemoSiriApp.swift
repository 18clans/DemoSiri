//
//  DemoSiriApp.swift
//  DemoSiri WatchKit Extension
//
//  Created by NIIRDS Team on 8/16/21.
//

import SwiftUI

@main
struct DemoSiriApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
