import SwiftUI

struct HealthGuidelinesView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedCategory: HealthGuideline.Category?
    
    var filteredGuidelines: [HealthGuideline] {
        if let category = selectedCategory {
            return HealthGuidelineData.guidelines.filter { $0.category == category }
        }
        return HealthGuidelineData.guidelines
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Category Picker
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(HealthGuideline.Category.allCases, id: \.self) { category in
                                CategoryButton(
                                    category: category,
                                    isSelected: selectedCategory == category,
                                    action: {
                                        if selectedCategory == category {
                                            selectedCategory = nil
                                        } else {
                                            selectedCategory = category
                                        }
                                    }
                                )
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Guidelines List
                    LazyVStack(spacing: 16) {
                        ForEach(filteredGuidelines) { guideline in
                            GuidelineCard(guideline: guideline)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("Health Guidelines")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct CategoryButton: View {
    let category: HealthGuideline.Category
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(category.rawValue)
                .font(.subheadline)
                .fontWeight(.medium)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color.gray.opacity(0.2))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(20)
        }
    }
}

struct GuidelineCard: View {
    let guideline: HealthGuideline
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: guideline.icon)
                    .font(.title2)
                    .foregroundColor(.blue)
                    .frame(width: 40, height: 40)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(Circle())
                
                Text(guideline.title)
                    .font(.headline)
                
                Spacer()
                
                Text(guideline.category.rawValue)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(categoryColor.opacity(0.2))
                    .foregroundColor(categoryColor)
                    .cornerRadius(8)
            }
            
            Text(guideline.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
    
    var categoryColor: Color {
        switch guideline.category {
        case .emergency:
            return .red
        case .nutrition:
            return .green
        case .exercise:
            return .orange
        case .grooming:
            return .purple
        case .vaccination:
            return .blue
        case .general:
            return .gray
        }
    }
}

extension HealthGuideline.Category: CaseIterable {
    static var allCases: [HealthGuideline.Category] {
        [.emergency, .nutrition, .exercise, .grooming, .vaccination, .general]
    }
} 