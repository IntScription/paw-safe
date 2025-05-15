import SwiftUI

struct MainView: View {
    @StateObject private var authManager = AuthenticationManager.shared
    
    var body: some View {
        Group {
            if authManager.isAuthenticated {
                MainTabView()
            } else {
                WelcomeView()
            }
        }
    }
}

#Preview {
    MainView()
} 