import SwiftUI

struct FAQView: View {
    var body: some View {
        List {
            Section(header: Text("General Questions")) {
                FAQItem(question: "What is Paw Safe?",
                       answer: "Paw Safe is a platform that connects pet owners with blood donors and emergency veterinary services.")
                
                FAQItem(question: "How does the blood donation process work?",
                       answer: "When a pet needs blood, we match them with compatible donors in the area. The donation process is safe and supervised by veterinary professionals.")
                
                FAQItem(question: "Is my pet eligible to donate blood?",
                       answer: "Generally, dogs should be 1-8 years old, weigh at least 50 pounds, and be in good health. Cats should be 1-7 years old, weigh at least 10 pounds, and be in good health.")
            }
            
            Section(header: Text("Account & Privacy")) {
                FAQItem(question: "How is my data protected?",
                       answer: "We take data privacy seriously. All personal information is encrypted and stored securely. We never share your data with third parties without consent.")
                
                FAQItem(question: "Can I delete my account?",
                       answer: "Yes, you can delete your account at any time from the Profile section. This will permanently remove all your data from our system.")
            }
            
            Section(header: Text("Emergency Services")) {
                FAQItem(question: "How do I find emergency veterinary services?",
                       answer: "Use the Emergency tab to find nearby veterinary clinics and emergency services. The app will show you the closest options with their contact information.")
                
                FAQItem(question: "What should I do in a pet emergency?",
                       answer: "Stay calm, contact the nearest emergency veterinary service through the app, and follow their instructions. If possible, have your pet's medical history ready.")
            }
        }
        .navigationTitle("FAQ")
    }
}

struct FAQItem: View {
    let question: String
    let answer: String
    @State private var isExpanded = false
    
    var body: some View {
        DisclosureGroup(
            isExpanded: $isExpanded,
            content: {
                Text(answer)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.vertical, 8)
            },
            label: {
                Text(question)
                    .font(.headline)
            }
        )
    }
}

#Preview {
    NavigationView {
        FAQView()
    }
} 