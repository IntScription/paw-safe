import SwiftUI
import PhotosUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @StateObject private var themeManager = ThemeManager()
    @State private var showingImagePicker = false
    @State private var showingEditProfile = false
    @State private var selectedItem: PhotosPickerItem?
    @State private var profileImage: Image?
    @State private var showingDeleteConfirmation = false
    @StateObject private var authManager = AuthenticationManager.shared
    @State private var showingLogoutAlert = false
    
    var body: some View {
        NavigationView {
            List {
                profileHeaderSection
                preferencesSection
                accountSection
                supportSection
                aboutSection
                signOutSection
            }
            .navigationTitle("Profile")
            .sheet(isPresented: $showingEditProfile) {
                EditProfileView(viewModel: viewModel)
            }
            .photosPicker(isPresented: $showingImagePicker, selection: $selectedItem, matching: .images)
            .onChange(of: selectedItem) { oldValue, newValue in
                Task {
                    if let data = try? await newValue?.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        profileImage = Image(uiImage: uiImage)
                    }
                }
            }
            .alert("Delete Account", isPresented: $showingDeleteConfirmation) {
                Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive) {
                    // TODO: Implement account deletion
                }
            } message: {
                Text("Are you sure you want to delete your account? This action cannot be undone.")
            }
            .alert("Sign Out", isPresented: $showingLogoutAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Sign Out", role: .destructive) {
                    authManager.signOut()
                }
            } message: {
                Text("Are you sure you want to sign out?")
            }
        }
    }
    
    private var profileHeaderSection: some View {
        Section {
            HStack {
                ZStack {
                    if let profileImage = profileImage {
                        profileImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.blue)
                    }
                    
                    Button(action: { showingImagePicker = true }) {
                        Image(systemName: "pencil.circle.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.blue)
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                    .offset(x: 20, y: 20)
                }
                
                VStack(alignment: .leading) {
                    Text(authManager.currentUser?.name ?? "Guest User")
                        .font(.headline)
                    Text(authManager.currentUser?.email ?? "Guest Account")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .padding(.vertical, 8)
        }
    }
    
    private var preferencesSection: some View {
        Section("Preferences") {
            Picker("Appearance", selection: $themeManager.appearanceMode) {
                ForEach(AppearanceMode.allCases, id: \.self) { mode in
                    HStack {
                        Image(systemName: mode.icon)
                            .foregroundColor(mode.color)
                        Text(mode.rawValue)
                    }
                    .tag(mode)
                }
            }
        }
    }
    
    private var accountSection: some View {
        Section("Account") {
            Button(action: { showingEditProfile = true }) {
                Label("Edit Profile", systemImage: "pencil")
            }
            
            Button(action: {}) {
                Label("Change Password", systemImage: "lock")
            }
            
            Button(action: {}) {
                Label("Privacy Settings", systemImage: "hand.raised")
            }
        }
    }
    
    private var supportSection: some View {
        Section(header: Text("Support")) {
            NavigationLink(destination: FAQView()) {
                Label("FAQ", systemImage: "questionmark.circle")
            }
            
            NavigationLink(destination: PrivacyPolicyView()) {
                Label("Privacy Policy", systemImage: "lock.shield")
            }
            
            NavigationLink(destination: TermsOfServiceView()) {
                Label("Terms of Service", systemImage: "doc.text")
            }
        }
    }
    
    private var aboutSection: some View {
        Section {
            NavigationLink(destination: AboutView()) {
                HStack {
                    Spacer()
                    Text("About")
                        .foregroundColor(.blue)
                    Spacer()
                }
            }
        }
    }
    
    private var signOutSection: some View {
        Section {
            Button(action: {
                showingLogoutAlert = true
            }) {
                HStack {
                    Spacer()
                    Text("Sign Out")
                        .foregroundColor(.red)
                    Spacer()
                }
            }
        }
    }
}

struct StatBox: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(value)
                .font(.title3)
                .fontWeight(.bold)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

struct ActivityRow: View {
    let activity: Activity
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: activity.icon)
                .font(.title2)
                .foregroundColor(activity.color)
                .frame(width: 40, height: 40)
                .background(activity.color.opacity(0.1))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(activity.title)
                    .font(.headline)
                
                Text(activity.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(activity.timeAgo)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ProfileViewModel
    @State private var name: String
    @State private var email: String
    @State private var phone: String
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        _name = State(initialValue: viewModel.name)
        _email = State(initialValue: viewModel.email)
        _phone = State(initialValue: viewModel.phone)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("Name", text: $name)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    TextField("Phone", text: $phone)
                        .keyboardType(.phonePad)
                }
                
                Section {
                    Button("Save Changes") {
                        viewModel.updateProfile(name: name, email: email, phone: phone)
                        dismiss()
                    }
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarItems(trailing: Button("Cancel") {
                dismiss()
            })
        }
    }
}

struct DogProfileRow: View {
    var body: some View {
        HStack {
            Image(systemName: "pawprint.circle.fill")
                .font(.title)
                .foregroundColor(.blue)
            
            VStack(alignment: .leading) {
                Text("Max")
                    .font(.headline)
                Text("Golden Retriever • DEA 1.1+")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
    }
}

struct DonationHistoryRow: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Blood Donation")
                    .font(.headline)
                Text("Vet Hospital SF")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("March 15, 2024")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text("500ml")
                    .font(.caption)
                    .padding(4)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(4)
            }
        }
    }
}

struct AddDogView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var breed = ""
    @State private var age = ""
    @State private var bloodType = ""
    @State private var weight = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Dog Information")) {
                    TextField("Name", text: $name)
                    TextField("Breed", text: $breed)
                    TextField("Age (years)", text: $age)
                        .keyboardType(.decimalPad)
                    TextField("Blood Type", text: $bloodType)
                    TextField("Weight (lbs)", text: $weight)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Add New Dog")
            .navigationBarItems(
                leading: Button("Cancel") { dismiss() },
                trailing: Button("Save") { dismiss() }
            )
        }
    }
}

#Preview {
    ProfileView()
} 