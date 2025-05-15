//
//  ContentView.swift
//  Paw Safe
//
//  Created by Kartik Sanil on 14/05/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var isShowingSplash = true
    @State private var hasCompletedOnboarding = false

    var body: some View {
        ZStack {
            if isShowingSplash {
                SplashScreen()
                    .transition(.opacity)
                    .zIndex(1)
            } else if !hasCompletedOnboarding {
                OnboardingView(hasCompletedOnboarding: $hasCompletedOnboarding)
                    .transition(.opacity)
                    .zIndex(1)
            } else {
                MainTabView()
                    .transition(.opacity)
                    .zIndex(0)
            }
            }
        .onAppear {
            // Simulate splash screen delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    isShowingSplash = false
                }
            }
        }
    }
}

struct SplashScreen: View {
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image(systemName: "pawprint.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.white)
                
                Text("Paw Safe")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("Finding blood donors for dogs")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
        }
    }
}

struct OnboardingView: View {
    @Binding var hasCompletedOnboarding: Bool
    @State private var currentPage = 0
    
    let pages = [
        OnboardingPage(
            title: "Find Blood Donors",
            description: "Quickly locate nearby blood donors for your dog in emergency situations.",
            imageName: "drop.fill"
        ),
        OnboardingPage(
            title: "Emergency Requests",
            description: "Send immediate alerts to nearby donors when your dog needs blood urgently.",
            imageName: "exclamationmark.circle.fill"
        ),
        OnboardingPage(
            title: "Chat Support",
            description: "Get instant answers to your questions about dog blood donation.",
            imageName: "message.fill"
        )
    ]
    
    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(0..<pages.count, id: \.self) { index in
                VStack(spacing: 20) {
                    Image(systemName: pages[index].imageName)
                        .font(.system(size: 80))
                        .foregroundColor(.blue)
                    
                    Text(pages[index].title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(pages[index].description)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    if index == pages.count - 1 {
                        Button(action: {
        withAnimation {
                                hasCompletedOnboarding = true
                            }
                        }) {
                            Text("Get Started")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal, 40)
                        .padding(.top, 20)
                    }
                }
                .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }
        }

struct OnboardingPage {
    let title: String
    let description: String
    let imageName: String
}

#Preview {
    ContentView()
}
