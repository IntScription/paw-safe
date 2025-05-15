import SwiftUI
import MapKit
import SafariServices

struct HomeView: View {
    @State private var showingEmergencyRequest = false
    @State private var showingHelplines = false
    @State private var showingHealthGuidelines = false
    @State private var selectedEvent: Event?
    @State private var isAnimating = false
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header Section
                    HStack(alignment: .top) {
                        // Left side - Welcome text
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Welcome to")
                                .font(.title2)
                                .foregroundColor(.secondary)
                                .opacity(isAnimating ? 1 : 0)
                                .offset(y: isAnimating ? 0 : 20)
                            
                            Text("Paw Safe")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(.blue)
                                .opacity(isAnimating ? 1 : 0)
                                .offset(y: isAnimating ? 0 : 20)
                            
                            Text("Where Every Pet's Life Matters")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .opacity(isAnimating ? 1 : 0)
                                .offset(y: isAnimating ? 0 : 20)
                            
                            Text("Your trusted companion in pet care")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .opacity(isAnimating ? 1 : 0)
                                .offset(y: isAnimating ? 0 : 20)
                        }
                        
                        Spacer()
                        
                        // Right side - Stats
                        VStack(alignment: .trailing, spacing: 12) {
                            StatCard(
                                title: "Active Donors",
                                value: "1.2K",
                                icon: "heart.fill",
                                color: .red
                            )
                            .opacity(isAnimating ? 1 : 0)
                            .offset(x: isAnimating ? 0 : 50)
                            
                            StatCard(
                                title: "Events",
                                value: "12",
                                icon: "calendar",
                                color: .blue
                            )
                            .opacity(isAnimating ? 1 : 0)
                            .offset(x: isAnimating ? 0 : 50)
                            
                            StatCard(
                                title: "Adoptions",
                                value: "45",
                                icon: "pawprint.fill",
                                color: .green
                            )
                            .opacity(isAnimating ? 1 : 0)
                            .offset(x: isAnimating ? 0 : 50)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Quick Actions
                    VStack(spacing: 16) {
                        HStack(spacing: 16) {
                            QuickActionButton(
                                title: "Emergency\nRequest",
                                icon: "exclamationmark.triangle.fill",
                                color: .red
                            ) {
                                showingEmergencyRequest = true
                            }
                            .scaleEffect(isAnimating ? 1 : 0.8)
                            
                            QuickActionButton(
                                title: "24/7\nHelplines",
                                icon: "phone.fill",
                                color: .green
                            ) {
                                showingHelplines = true
                            }
                            .scaleEffect(isAnimating ? 1 : 0.8)
                            
                            QuickActionButton(
                                title: "Health\nGuidelines",
                                icon: "heart.text.square.fill",
                                color: .blue
                            ) {
                                showingHealthGuidelines = true
                            }
                            .scaleEffect(isAnimating ? 1 : 0.8)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Map Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Nearby Donors")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        Map {
                            UserAnnotation()
                        }
                        .frame(height: 200)
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .opacity(isAnimating ? 1 : 0)
                        .offset(y: isAnimating ? 0 : 20)
                    }
                    
                    // Events Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Upcoming Events")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(EventData.events) { event in
                                    EventCard(event: event)
                                        .onTapGesture {
                                            selectedEvent = event
                                        }
                                }
                            }
                            .padding(.horizontal)
                        }
                        .opacity(isAnimating ? 1 : 0)
                        .offset(y: isAnimating ? 0 : 20)
                    }
                    
                    // Adoptions Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Available for Adoption")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(AdoptionData.adoptions) { adoption in
                                    AdoptionCard(adoption: adoption)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .opacity(isAnimating ? 1 : 0)
                        .offset(y: isAnimating ? 0 : 20)
                    }
                }
                .padding(.vertical)
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showingEmergencyRequest) {
                EmergencyRequestView()
            }
            .sheet(isPresented: $showingHelplines) {
                HelplinesView()
            }
            .sheet(isPresented: $showingHealthGuidelines) {
                HealthGuidelinesView()
            }
            .sheet(item: $selectedEvent) { event in
                if let url = URL(string: event.websiteURL) {
                    SafariView(url: url)
                }
            }
            .onAppear {
                withAnimation(.easeOut(duration: 0.8)) {
                    isAnimating = true
                }
            }
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .foregroundColor(color)
            VStack(alignment: .trailing) {
                Text(value)
                    .font(.headline)
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(8)
        .background(color.opacity(0.1))
        .cornerRadius(8)
    }
}

struct EventCard: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Placeholder for event image
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 120)
                .overlay(
                    Image(systemName: "calendar")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                )
                .cornerRadius(12)
            
            Text(event.title)
                .font(.headline)
                .lineLimit(2)
            
            Text(event.date, style: .date)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(event.location)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(event.type.rawValue)
                .font(.caption)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(typeColor.opacity(0.2))
                .foregroundColor(typeColor)
                .cornerRadius(4)
        }
        .frame(width: 200)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
    
    var typeColor: Color {
        switch event.type {
        case .healthCamp:
            return .blue
        case .donation:
            return .green
        case .adoption:
            return .orange
        }
    }
}

struct AdoptionCard: View {
    let adoption: Adoption
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Placeholder for pet image
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 120)
                .overlay(
                    Image(systemName: "pawprint.fill")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                )
                .cornerRadius(12)
            
            Text(adoption.name)
                .font(.headline)
            
            Text(adoption.breed)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(adoption.age)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(adoption.shelterName)
                .font(.caption)
                .foregroundColor(.blue)
        }
        .frame(width: 200)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .blue
        return safariVC
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        // No update needed
    }
}

struct QuickActionButton: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(color)
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(color.opacity(0.1))
            .cornerRadius(12)
        }
    }
}

struct ActivityCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "drop.fill")
                    .foregroundColor(.red)
                Text("Blood Request")
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
            
            Text("Golden Retriever needs blood")
                .font(.headline)
            
            Text("2 hours ago")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(width: 200)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct HelplinesView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    
    var filteredHelplines: [Helpline] {
        if searchText.isEmpty {
            return HelplineData.helplines
        } else {
            return HelplineData.helplines.filter { helpline in
                helpline.name.localizedCaseInsensitiveContains(searchText) ||
                helpline.country.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredHelplines) { helpline in
                    HelplineRow(helpline: helpline)
                }
            }
            .searchable(text: $searchText, prompt: "Search helplines")
            .navigationTitle("Animal Helplines")
            .navigationBarItems(trailing: Button("Done") {
                dismiss()
            })
        }
    }
}

struct HelplineRow: View {
    let helpline: Helpline
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(helpline.name)
                    .font(.headline)
                if helpline.isEmergency {
                    Text("EMERGENCY")
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(4)
                }
            }
            
            Text(helpline.country)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text(helpline.description)
                .font(.caption)
                .foregroundColor(.gray)
            
            Button(action: {
                if let url = URL(string: "tel:\(helpline.phoneNumber.replacingOccurrences(of: " ", with: ""))") {
                    UIApplication.shared.open(url)
                }
            }) {
                HStack {
                    Image(systemName: "phone.fill")
                    Text(helpline.phoneNumber)
                }
                .foregroundColor(.blue)
            }
        }
        .padding(.vertical, 8)
    }
}

struct EmergencyRequestView: View {
    @Environment(\.dismiss) var dismiss
    @State private var dogName = ""
    @State private var bloodType = ""
    @State private var location = ""
    @State private var urgency = "High"
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Dog Information")) {
                    TextField("Dog's Name", text: $dogName)
                    TextField("Blood Type", text: $bloodType)
                    TextField("Location", text: $location)
                }
                
                Section(header: Text("Urgency Level")) {
                    Picker("Urgency", selection: $urgency) {
                        Text("High").tag("High")
                        Text("Medium").tag("Medium")
                        Text("Low").tag("Low")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    Button(action: submitRequest) {
                        Text("Submit Emergency Request")
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .navigationTitle("Emergency Request")
            .navigationBarItems(trailing: Button("Cancel") {
                dismiss()
            })
        }
    }
    
    private func submitRequest() {
        // TODO: Implement emergency request submission
        dismiss()
    }
} 