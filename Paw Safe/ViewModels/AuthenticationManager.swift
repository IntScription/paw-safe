import SwiftUI

class AuthenticationManager: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    
    static let shared = AuthenticationManager()
    
    private init() {
        checkAuthentication()
    }
    
    func checkAuthentication() {
        // For now, we'll just set it to false
        isAuthenticated = false
    }
    
    func signInAsGuest() {
        isAuthenticated = true
        currentUser = User(id: "guest", name: "Guest User", email: nil)
    }
    
    func signOut() {
        isAuthenticated = false
        currentUser = nil
    }
}

struct User {
    let id: String
    let name: String
    let email: String?
} 