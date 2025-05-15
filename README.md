# Paw-Safe

Paw Safe is a comprehensive iOS application designed to help pet owners and veterinary professionals manage blood donations for pets. The app facilitates connections between pet blood donors and recipients, making it easier to find and manage blood donations for pets in need.

## Features

### 1. Donor Search
- **Search Functionality**: Users can search for blood donors by location or breed
- **Blood Type Filtering**: Filter donors by specific blood types (DEA 1.1+, DEA 1.1-, DEA 3+, etc.)
- **Distance Filtering**: Find donors within specific distances (5, 10, 25, 50, or 100 miles)
- **Donor Cards**: Each donor is displayed in a card showing:
  - Pet's name and breed
  - Blood type
  - Distance from your location
  - Last donation date
  - Contact button to reach out to the donor

### 2. Donor Management
- **Donor Profiles**: View detailed information about each donor
- **Availability Status**: See if donors are currently available for donation
- **Donation History**: Track past donations and eligibility
- **Location Services**: Find nearby donors using GPS

### 3. Chat System
- **Direct Messaging**: Contact donors directly through the app
- **Real-time Communication**: Instant messaging with other users
- **Notification System**: Get alerts for new messages

### 4. Events
- **Blood Drive Events**: View and participate in local blood donation events
- **Event Calendar**: See upcoming donation events in your area
- **Event Registration**: Sign up for blood donation events

### 5. Adoption Features
- **Pet Adoption**: Browse pets available for adoption
- **Adoption Process**: Streamlined process for adopting pets
- **Pet Profiles**: Detailed information about adoptable pets

## Technical Details

### Code Structure and Implementation

#### 1. UI Components and Styling

**DonorSearchView**
```swift
struct DonorSearchView: View {
    @State private var searchText = ""
    @State private var selectedBloodType = "All"
    @State private var selectedDistance = "Any"
    
    var body: some View {
        NavigationView {
            VStack {
                // Search bar with magnifying glass icon
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search by location or breed", text: $searchText)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // Blood type and distance pickers
                HStack {
                    Picker("Blood Type", selection: $selectedBloodType) {
                        ForEach(bloodTypes, id: \.self) { type in
                            Text(type)
                        }
                    }
                }
            }
        }
    }
}
```
- Uses `@State` for managing local view state
- Implements a custom search bar with SF Symbols icon
- Uses SwiftUI's `Picker` for dropdown selections
- Applies consistent padding and corner radius for visual appeal

**DonorCard Component**
```swift
struct DonorCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Pet information header
            HStack {
                Image(systemName: "pawprint.circle.fill")
                    .font(.title)
                    .foregroundColor(.blue)
                
                VStack(alignment: .leading) {
                    Text("Max")
                        .font(.headline)
                    Text("Golden Retriever • 3 years old")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            
            // Contact button
            Button(action: {}) {
                Text("Contact")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }
}
```
- Uses nested `VStack` and `HStack` for layout
- Implements custom styling for buttons and text
- Uses SF Symbols for icons
- Applies consistent spacing and padding

#### 2. Animations and Transitions

**View Transitions**
```swift
// In DonorSearchView
ForEach(filteredDonors) { donor in
    DonorCard(donor: donor)
        .transition(.scale.combined(with: .opacity))
}
```
- Uses `.transition` modifier for smooth animations
- Combines scale and opacity for a polished effect
- Animates when donors are filtered or added

**Loading Animations**
```swift
// Loading state animation
if isLoading {
    ProgressView()
        .scaleEffect(1.5)
        .transition(.opacity)
}
```
- Uses SwiftUI's built-in `ProgressView`
- Applies scale effect for emphasis
- Smooth opacity transition

#### 3. State Management

**ViewModels**
```swift
class DonorsViewModel: ObservableObject {
    @Published var donors: [Donor] = []
    @Published var isLoading = false
    
    func fetchDonors() {
        isLoading = true
        // API call implementation
        isLoading = false
    }
}
```
- Uses `@Published` for reactive updates
- Implements loading state management
- Handles data fetching and updates

#### 4. Data Models

**Donor Model**
```swift
struct Donor: Identifiable {
    let id: UUID
    let name: String
    let bloodType: String
    let breed: String
    let age: Int
    let isAvailable: Bool
    let lastDonation: Date
}
```
- Conforms to `Identifiable` for list rendering
- Contains all necessary donor information
- Uses appropriate data types for each property

### UI/UX Implementation Details

#### 1. Layout System
- Uses SwiftUI's declarative layout system
- Implements responsive design using:
  - `GeometryReader` for dynamic sizing
  - `Spacer()` for flexible spacing
  - `HStack` and `VStack` for arrangement

#### 2. Styling
- Consistent color scheme using:
  ```swift
  Color.blue.opacity(0.1) // For backgrounds
  Color.gray.opacity(0.05) // For cards
  ```
- Typography hierarchy:
  - Headlines: `.font(.headline)`
  - Subheadlines: `.font(.subheadline)`
  - Body text: `.font(.body)`

#### 3. Interactive Elements
- Buttons with hover effects:
  ```swift
  Button(action: {}) {
      Text("Contact")
          .padding()
          .background(Color.blue)
          .cornerRadius(8)
  }
  .buttonStyle(ScaleButtonStyle())
  ```
- Custom button style:
  ```swift
  struct ScaleButtonStyle: ButtonStyle {
      func makeBody(configuration: Configuration) -> some View {
          configuration.label
              .scaleEffect(configuration.isPressed ? 0.95 : 1)
              .animation(.easeInOut, value: configuration.isPressed)
      }
  }
  ```

#### 4. Accessibility
- VoiceOver support:
  ```swift
  .accessibilityLabel("Donor card for \(donor.name)")
  .accessibilityHint("Double tap to view details")
  ```
- Dynamic type support:
  ```swift
  .font(.body)
  .dynamicTypeSize(...dynamicTypeSize)
  ```

## Views and Components

1. **DonorSearchView**
   - Main search interface for finding blood donors
   - Contains search bar, filters, and donor list
   - Uses `DonorCard` component to display donor information

2. **DonorCard Component**
   - Reusable component for displaying donor information
   - Shows pet details, blood type, and contact options
   - Includes distance information and last donation date

3. **ChatsView**
   - Manages all chat conversations
   - Real-time messaging interface
   - Message history and notifications

4. **EventsView**
   - Displays upcoming blood donation events
   - Event registration and management
   - Calendar integration

5. **AdoptionView**
   - Shows pets available for adoption
   - Adoption process management
   - Pet profile viewing

## ViewModels

1. **DonorsViewModel**
   - Manages donor data and search functionality
   - Handles filtering and sorting of donors
   - Manages donor availability status

2. **ChatsViewModel**
   - Handles chat functionality
   - Manages message history
   - Controls real-time updates

3. **EventsViewModel**
   - Manages event data
   - Handles event registration
   - Controls event notifications

4. **AdoptionViewModel**
   - Manages adoption process
   - Handles pet profiles
   - Controls adoption status

## Models

1. **Donor Model**
   - Stores donor information
   - Manages blood type data
   - Tracks donation history

2. **Activity Model**
   - Tracks user activities
   - Manages notifications
   - Records system events

## UI/UX Features

1. **Modern Design**
   - Clean and intuitive interface
   - Easy navigation
   - Responsive layout

2. **Accessibility**
   - VoiceOver support
   - Dynamic type
   - High contrast options

3. **Animations**
   - Smooth transitions
   - Loading indicators
   - Interactive feedback

## Getting Started

1. Clone the repository
2. Open the project in Xcode
3. Install dependencies
4. Build and run the project

## Requirements

- iOS 15.0+
- Xcode 13.0+
- Swift 5.5+
