import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var name: String = "John Doe"
    @Published var email: String = "john.doe@example.com"
    @Published var phone: String = "+1 (555) 123-4567"
    @Published var profileImage: UIImage?
    
    // Stats
    @Published var donationCount: Int = 5
    @Published var requestCount: Int = 2
    @Published var eventCount: Int = 3
    
    // Recent Activity
    @Published var recentActivity: [Activity] = [
        Activity(
            id: UUID(),
            title: "Blood Donation",
            description: "Donated blood for a Golden Retriever",
            timeAgo: "2 hours ago",
            icon: "drop.fill",
            color: .red
        ),
        Activity(
            id: UUID(),
            title: "Emergency Request",
            description: "Created a blood request for your pet",
            timeAgo: "1 day ago",
            icon: "heart.fill",
            color: .green
        ),
        Activity(
            id: UUID(),
            title: "Event Registration",
            description: "Registered for Pet Health Camp",
            timeAgo: "3 days ago",
            icon: "calendar",
            color: .blue
        )
    ]
    
    func updateProfile(name: String, email: String, phone: String) {
        self.name = name
        self.email = email
        self.phone = phone
        // TODO: Save to backend
    }
    
    func updateProfileImage(_ image: UIImage) {
        self.profileImage = image
        // TODO: Save to backend/storage
    }
    
    func deleteAccount() {
        // TODO: Implement account deletion
    }
}

struct Activity: Identifiable {
    let id: UUID
    let title: String
    let description: String
    let timeAgo: String
    let icon: String
    let color: Color
} 