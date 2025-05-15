import SwiftUI

struct WelcomeView: View {
    @StateObject private var authManager = AuthenticationManager.shared
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // Logo and Title
                VStack(spacing: 20) {
                    Image(systemName: "pawprint.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                    
                    Text("Paw Safe")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Connect with pet blood donors and healthcare services")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding(.top, 50)
                
                Spacer()
                
                // Guest Access Button
                Button(action: {
                    authManager.signInAsGuest()
                }) {
                    Text("Continue as Guest")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
        }
    }
}

#Preview {
    WelcomeView()
} 