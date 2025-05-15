import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Group {
                    Text("Privacy Policy")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Last updated: March 2024")
                        .foregroundColor(.secondary)
                    
                    Text("1. Information We Collect")
                        .font(.headline)
                    Text("We collect information that you provide directly to us, including:")
                    BulletPoint("Personal information (name, email, phone number)")
                    BulletPoint("Pet information (breed, age, medical history)")
                    BulletPoint("Location data (to find nearby services)")
                }
                
                Group {
                    Text("2. How We Use Your Information")
                        .font(.headline)
                    Text("We use the information we collect to:")
                    BulletPoint("Connect you with blood donors and veterinary services")
                    BulletPoint("Send you important updates about your account")
                    BulletPoint("Improve our services and user experience")
                }
                
                Group {
                    Text("3. Information Sharing")
                        .font(.headline)
                    Text("We do not sell your personal information. We may share your information with:")
                    BulletPoint("Veterinary professionals when necessary")
                    BulletPoint("Emergency services in case of urgent situations")
                    BulletPoint("Service providers who help us operate our platform")
                }
                
                Group {
                    Text("4. Data Security")
                        .font(.headline)
                    Text("We implement appropriate security measures to protect your personal information, including:")
                    BulletPoint("Encryption of sensitive data")
                    BulletPoint("Regular security assessments")
                    BulletPoint("Access controls and authentication")
                }
                
                Group {
                    Text("5. Your Rights")
                        .font(.headline)
                    Text("You have the right to:")
                    BulletPoint("Access your personal information")
                    BulletPoint("Correct inaccurate data")
                    BulletPoint("Request deletion of your data")
                    BulletPoint("Opt-out of marketing communications")
                }
            }
            .padding()
        }
        .navigationTitle("Privacy Policy")
    }
}

struct BulletPoint: View {
    let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        HStack(alignment: .top) {
            Text("•")
                .padding(.trailing, 4)
            Text(text)
            Spacer()
        }
        .padding(.leading)
    }
}

#Preview {
    NavigationView {
        PrivacyPolicyView()
    }
} 