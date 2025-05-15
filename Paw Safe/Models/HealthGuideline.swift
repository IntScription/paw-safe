import Foundation

struct HealthGuideline: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let category: Category
    let icon: String
    
    enum Category: String {
        case emergency = "Emergency"
        case nutrition = "Nutrition"
        case exercise = "Exercise"
        case grooming = "Grooming"
        case vaccination = "Vaccination"
        case general = "General Care"
    }
}

class HealthGuidelineData {
    static let guidelines = [
        HealthGuideline(
            title: "Emergency Signs",
            description: "Watch for: difficulty breathing, seizures, collapse, pale gums, severe bleeding, inability to stand, extreme lethargy. Seek immediate veterinary care if you notice these signs.",
            category: .emergency,
            icon: "exclamationmark.triangle.fill"
        ),
        HealthGuideline(
            title: "Proper Nutrition",
            description: "Feed age-appropriate food, maintain regular feeding schedule, provide fresh water, avoid human food, monitor portion sizes, and consult vet for dietary changes.",
            category: .nutrition,
            icon: "fork.knife"
        ),
        HealthGuideline(
            title: "Exercise Requirements",
            description: "Daily walks, play sessions, mental stimulation, appropriate exercise for breed/age, avoid overexertion in hot weather, and regular activity schedule.",
            category: .exercise,
            icon: "figure.walk"
        ),
        HealthGuideline(
            title: "Grooming Essentials",
            description: "Regular brushing, nail trimming, ear cleaning, dental care, coat maintenance, and professional grooming when needed.",
            category: .grooming,
            icon: "scissors"
        ),
        HealthGuideline(
            title: "Vaccination Schedule",
            description: "Keep up with core vaccines, maintain vaccination records, follow vet-recommended schedule, and stay current with boosters.",
            category: .vaccination,
            icon: "cross.case.fill"
        ),
        HealthGuideline(
            title: "General Health Care",
            description: "Regular vet check-ups, parasite prevention, dental hygiene, weight management, and monitoring behavior changes.",
            category: .general,
            icon: "heart.fill"
        )
    ]
} 