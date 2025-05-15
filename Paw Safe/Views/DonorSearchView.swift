import SwiftUI

struct DonorSearchView: View {
    @State private var searchText = ""
    @State private var selectedBloodType = "All"
    @State private var selectedDistance = "Any"
    
    let bloodTypes = ["All", "DEA 1.1+", "DEA 1.1-", "DEA 3+", "DEA 3-", "DEA 4+", "DEA 4-", "DEA 5+", "DEA 5-", "DEA 7+", "DEA 7-"]
    let distances = ["Any", "5 miles", "10 miles", "25 miles", "50 miles", "100 miles"]
    
    var body: some View {
        NavigationView {
            VStack {
                // Search Filters
                VStack(spacing: 15) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search by location or breed", text: $searchText)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    
                    HStack {
                        Picker("Blood Type", selection: $selectedBloodType) {
                            ForEach(bloodTypes, id: \.self) { type in
                                Text(type).tag(type)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        
                        Picker("Distance", selection: $selectedDistance) {
                            ForEach(distances, id: \.self) { distance in
                                Text(distance).tag(distance)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                }
                .padding()
                
                // Donor List
                ScrollView {
                    LazyVStack(spacing: 15) {
                        ForEach(0..<10) { _ in
                            DonorCard()
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Find Donors")
        }
    }
}

struct DonorCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
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
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("DEA 1.1+")
                        .font(.caption)
                        .padding(5)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    Text("2 miles away")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            Divider()
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Last Donation")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("3 months ago")
                        .font(.subheadline)
                }
                
                Spacer()
                
                Button(action: {}) {
                    Text("Contact")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }
} 