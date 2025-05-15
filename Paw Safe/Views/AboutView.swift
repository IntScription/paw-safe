import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // App Logo
                Image(systemName: "pawprint.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .padding(.top, 30)
                
                // App Name and Version
                Text("Paw Safe")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Version 1.0")
                    .foregroundColor(.secondary)
                
                // App Description
                VStack(alignment: .leading, spacing: 15) {
                    Text("About Paw Safe")
                        .font(.headline)
                    
                    Text("Paw Safe is a comprehensive platform designed to connect pet owners with blood donors and emergency veterinary services. Our mission is to ensure that no pet goes without the care they need in critical situations.")
                        .foregroundColor(.secondary)
                    
                    Text("Key Features")
                        .font(.headline)
                        .padding(.top, 5)
                    
                    BulletPoint("Emergency veterinary service locator")
                    BulletPoint("Blood donor matching system")
                    BulletPoint("Real-time emergency alerts")
                    BulletPoint("Secure pet medical records")
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(10)
                .shadow(radius: 2)
                
                // Contact Information
                VStack(alignment: .leading, spacing: 15) {
                    Text("Contact Us")
                        .font(.headline)
                    
                    BulletPoint("Email: support@pawsafe.com")
                    BulletPoint("Phone: (555) 123-4567")
                    BulletPoint("Hours: 24/7 Emergency Support")
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(10)
                .shadow(radius: 2)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("About")
    }
}

#Preview {
    NavigationView {
        AboutView()
    }
} 