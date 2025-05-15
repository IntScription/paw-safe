import Foundation

struct Event: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let date: Date
    let location: String
    let imageURL: String
    let websiteURL: String
    let type: EventType
    
    enum EventType: String {
        case healthCamp = "Health Camp"
        case donation = "Donation"
        case adoption = "Adoption"
    }
}

struct Adoption: Identifiable {
    let id = UUID()
    let name: String
    let breed: String
    let age: String
    let description: String
    let imageURL: String
    let shelterName: String
    let contactNumber: String
}

class EventData {
    static let events = [
        Event(
            title: "Free Pet Health Check-up Camp",
            description: "Annual health check-up camp for pets. Free vaccinations and basic health screening.",
            date: Date().addingTimeInterval(86400 * 7), // 7 days from now
            location: "Central Park, New York",
            imageURL: "health_camp",
            websiteURL: "https://example.com/health-camp",
            type: .healthCamp
        ),
        Event(
            title: "Pet Food Donation Drive",
            description: "Help us collect food for shelter animals. Drop off your donations at any participating location.",
            date: Date().addingTimeInterval(86400 * 14), // 14 days from now
            location: "Multiple Locations",
            imageURL: "donation",
            websiteURL: "https://example.com/donation-drive",
            type: .donation
        ),
        Event(
            title: "Adoption Day",
            description: "Find your perfect companion. Multiple shelters participating with dogs and cats available for adoption.",
            date: Date().addingTimeInterval(86400 * 21), // 21 days from now
            location: "City Shelter, New York",
            imageURL: "adoption",
            websiteURL: "https://example.com/adoption-day",
            type: .adoption
        )
    ]
}

class AdoptionData {
    static let adoptions = [
        Adoption(
            name: "Max",
            breed: "Golden Retriever",
            age: "2 years",
            description: "Friendly and well-trained. Great with children and other pets.",
            imageURL: "max",
            shelterName: "Happy Tails Shelter",
            contactNumber: "+1 (555) 123-4567"
        ),
        Adoption(
            name: "Luna",
            breed: "German Shepherd",
            age: "1 year",
            description: "Energetic and loyal. Needs an active family.",
            imageURL: "luna",
            shelterName: "Paws & Care",
            contactNumber: "+1 (555) 234-5678"
        ),
        Adoption(
            name: "Charlie",
            breed: "Mixed Breed",
            age: "3 years",
            description: "Calm and affectionate. Perfect for first-time pet owners.",
            imageURL: "charlie",
            shelterName: "Furever Home",
            contactNumber: "+1 (555) 345-6789"
        )
    ]
} 