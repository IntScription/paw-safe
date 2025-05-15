//
//  Paw_SafeApp.swift
//  Paw Safe
//
//  Created by Kartik Sanil on 14/05/25.
//

import SwiftUI

@main
struct Paw_SafeApp: App {
    @StateObject private var themeManager = ThemeManager()
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(themeManager)
        }
    }
}

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            DonorSearchView()
                .tabItem {
                    Label("Find Donors", systemImage: "drop.fill")
                }
            
            ChatbotView()
                .tabItem {
                    Label("Chat", systemImage: "message.fill")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}
