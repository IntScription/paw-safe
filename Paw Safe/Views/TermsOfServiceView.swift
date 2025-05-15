import SwiftUI

struct TermsOfServiceView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Group {
                    Text("Terms of Service")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Last updated: March 2024")
                        .foregroundColor(.secondary)
                    
                    Text("1. Acceptance of Terms")
                        .font(.headline)
                    Text("By accessing and using Paw Safe, you agree to be bound by these Terms of Service and all applicable laws and regulations.")
                }
                
                Group {
                    Text("2. User Responsibilities")
                        .font(.headline)
                    Text("As a user of Paw Safe, you agree to:")
                    BulletPoint("Provide accurate and complete information")
                    BulletPoint("Maintain the security of your account")
                    BulletPoint("Use the service only for lawful purposes")
                    BulletPoint("Not misuse or abuse the platform")
                }
                
                Group {
                    Text("3. Emergency Services")
                        .font(.headline)
                    Text("Paw Safe is not a substitute for professional veterinary care. In emergency situations:")
                    BulletPoint("Always contact a veterinary professional first")
                    BulletPoint("Use the app as a supplementary tool")
                    BulletPoint("Follow the advice of medical professionals")
                }
                
                Group {
                    Text("4. Blood Donation")
                        .font(.headline)
                    Text("When participating in blood donation:")
                    BulletPoint("Ensure your pet meets all eligibility requirements")
                    BulletPoint("Follow all veterinary guidelines")
                    BulletPoint("Understand the risks and benefits")
                }
                
                Group {
                    Text("5. Limitation of Liability")
                        .font(.headline)
                    Text("Paw Safe is not liable for:")
                    BulletPoint("Any direct or indirect damages")
                    BulletPoint("Loss of data or privacy breaches")
                    BulletPoint("Injuries to pets or people")
                    BulletPoint("Service interruptions or errors")
                }
                
                Group {
                    Text("6. Changes to Terms")
                        .font(.headline)
                    Text("We reserve the right to modify these terms at any time. We will notify users of any material changes.")
                }
            }
            .padding()
        }
        .navigationTitle("Terms of Service")
    }
}

#Preview {
    NavigationView {
        TermsOfServiceView()
    }
} 