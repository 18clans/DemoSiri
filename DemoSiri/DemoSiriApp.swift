//
//  DemoSiriApp.swift
//  DemoSiri
//
//  Created by NIIRDS Team on 8/16/21.
//

import SwiftUI
import Intents

@main
struct DemoSiriApp: App {
    @AppStorage("naviassistantstorage", store: UserDefaults(
        suiteName: "group.com.navitus.naviassistant")) var store: Data = Data()
    
    //@StateObject var pharmacies = Pharmacies()
    
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { phase in
                         INPreferences.requestSiriAuthorization({status in
                         // Handle errors here
                     })
                 }
    }
}
