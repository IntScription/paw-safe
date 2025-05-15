import SwiftUI

struct Message: Identifiable {
    let id = UUID()
    let content: String
    let isUser: Bool
    let timestamp: Date
}

class ChatbotViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var isTyping = false
    
    private let apiKey = "REPLACE_WITH_YOUR_KEY"
    
    func sendMessage(_ content: String) async throws {
        // Add user message
        await MainActor.run {
            let userMessage = Message(content: content, isUser: true, timestamp: Date())
            messages.append(userMessage)
            isTyping = true
        }
        
        // Call OpenAI API
        let response = try await generateAIResponse(content)
        
        // Add bot response
        await MainActor.run {
            isTyping = false
            let botMessage = Message(content: response, isUser: false, timestamp: Date())
            messages.append(botMessage)
        }
    }
    
    private func generateAIResponse(_ message: String) async throws -> String {
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                ["role": "system", "content": "You are a helpful pet care assistant for the Paw Safe app. The app helps connect pet blood donors with those in need. Provide helpful, accurate, and friendly responses about pet care, blood donation, and general pet health. Keep responses concise but informative."],
                ["role": "user", "content": message]
            ],
            "temperature": 0.7,
            "max_tokens": 150
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NSError(domain: "API Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response from server"])
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(OpenAIResponse.self, from: data)
        return result.choices.first?.message.content ?? "I apologize, but I couldn't generate a response at this time."
    }
}

struct OpenAIResponse: Codable {
    struct Choice: Codable {
        struct Message: Codable {
            let content: String
        }
        let message: Message
    }
    let choices: [Choice]
}

struct ChatbotView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = ChatbotViewModel()
    @State private var newMessage: String = ""
    @State private var scrollToBottom = false
    
    var body: some View {
        NavigationView {
            VStack {
                // Chat messages
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(viewModel.messages) { message in
                                MessageBubble(message: message)
                                    .transition(.asymmetric(
                                        insertion: .scale(scale: 0.8).combined(with: .opacity),
                                        removal: .opacity
                                    ))
                            }
                            if viewModel.isTyping {
                                TypingIndicator()
                                    .transition(.opacity)
                            }
                        }
                        .padding()
                    }
                    .onChange(of: viewModel.messages.count) { oldCount, newCount in
                        if newCount > oldCount {
                            withAnimation(.spring()) {
                                proxy.scrollTo(viewModel.messages.last?.id, anchor: .bottom)
                            }
                        }
                    }
                }
                
                // Message input
                HStack {
                    TextField("Type your message...", text: $newMessage)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Button(action: sendMessage) {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.blue)
                    }
                    .disabled(newMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    .padding(.trailing)
                }
                .padding(.vertical, 8)
                .background(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -5)
            }
            .navigationTitle("Paw Safe Assistant")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                // Add welcome message
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation {
                        viewModel.messages.append(Message(
                            content: "👋 Hi! I'm your Paw Safe Assistant. How can I help you today?",
                            isUser: false,
                            timestamp: Date()
                        ))
                    }
                }
            }
        }
    }
    
    private func sendMessage() {
        let trimmedMessage = newMessage.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedMessage.isEmpty else { return }
        
        newMessage = ""
        
        Task {
            do {
                try await viewModel.sendMessage(trimmedMessage)
            } catch {
                print("Error sending message: \(error)")
            }
        }
    }
}

struct MessageBubble: View {
    let message: Message
    @State private var isAppearing = false
    
    var body: some View {
        HStack {
            if message.isUser { Spacer() }
            
            VStack(alignment: message.isUser ? .trailing : .leading, spacing: 4) {
                Text(message.content)
                    .padding(12)
                    .background(message.isUser ? Color.blue : Color(.systemGray5))
                    .foregroundColor(message.isUser ? .white : .primary)
                    .cornerRadius(16)
                
                Text(message.timestamp, style: .time)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            .opacity(isAppearing ? 1 : 0)
            .offset(y: isAppearing ? 0 : 20)
            
            if !message.isUser { Spacer() }
        }
        .onAppear {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                isAppearing = true
            }
        }
    }
}

struct TypingIndicator: View {
    @State private var animationOffset = 0.0
    @State private var isAppearing = false
    
    var body: some View {
        HStack {
            Circle()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 8, height: 8)
                .offset(y: animationOffset)
            Circle()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 8, height: 8)
                .offset(y: animationOffset)
            Circle()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 8, height: 8)
                .offset(y: animationOffset)
        }
        .padding(12)
        .background(Color(.systemGray5))
        .cornerRadius(16)
        .opacity(isAppearing ? 1 : 0)
        .onAppear {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                isAppearing = true
            }
            withAnimation(Animation.easeInOut(duration: 0.5).repeatForever()) {
                animationOffset = -5
            }
        }
    }
}
