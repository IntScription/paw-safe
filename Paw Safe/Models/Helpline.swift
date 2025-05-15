import Foundation

struct Helpline: Identifiable {
    let id = UUID()
    let name: String
    let phoneNumber: String
    let country: String
    let description: String
    let isEmergency: Bool
}

class HelplineData {
    static let helplines = [
        Helpline(
            name: "ASPCA Animal Poison Control",
            phoneNumber: "+1 (888) 426-4435",
            country: "United States",
            description: "24/7 emergency hotline for animal poison control",
            isEmergency: true
        ),
        Helpline(
            name: "RSPCA Emergency",
            phoneNumber: "0300 1234 999",
            country: "United Kingdom",
            description: "24/7 emergency animal rescue and welfare",
            isEmergency: true
        ),
        Helpline(
            name: "Animal Emergency Service",
            phoneNumber: "1300 367 386",
            country: "Australia",
            description: "24/7 emergency veterinary care",
            isEmergency: true
        ),
        Helpline(
            name: "SPCA International",
            phoneNumber: "+1 (202) 452-1100",
            country: "International",
            description: "Global animal welfare organization",
            isEmergency: false
        ),
        Helpline(
            name: "World Animal Protection",
            phoneNumber: "+44 (0) 20 7239 0500",
            country: "International",
            description: "Global animal welfare organization",
            isEmergency: false
        ),
        Helpline(
            name: "PETA Emergency",
            phoneNumber: "+1 (757) 622-7382",
            country: "United States",
            description: "24/7 animal emergency hotline",
            isEmergency: true
        ),
        Helpline(
            name: "Animal Welfare Board of India",
            phoneNumber: "1800 11 7000",
            country: "India",
            description: "National animal welfare organization",
            isEmergency: false
        ),
        Helpline(
            name: "Canadian Federation of Humane Societies",
            phoneNumber: "+1 (613) 224-8072",
            country: "Canada",
            description: "National animal welfare organization",
            isEmergency: false
        )
    ]
} 