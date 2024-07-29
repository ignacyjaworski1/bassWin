//
//  TabMainView.swift
//  bassWinTrophy
//
//  Created by admin on 7/29/24.
//





import SwiftUI

struct TabMainView: View {
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    @State private var current = "Home"
    @State private var isTabBarShown = true
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            Rectangle()
                .foregroundColor(.black)
                .ignoresSafeArea()
            
            TabView(selection: $current) {
                
                MainView() {
                    
                }
                    .tag("Home")
                
                ListView(){
                    isTabBarShown.toggle()
                }
                    .tag("Grades")
                
                TrophyView(){
                    isTabBarShown.toggle()
                }
                    .tag("Trophies")
                
                SettingsView()
                    .tag("Settings")
            }
            
            if isTabBarShown {
                
                HStack(spacing: 0) {
                    TabButton(title: "Home", image: "house", selected: $current)
                    
                    Spacer(minLength: 0)
                    
                    TabButton(title: "Grades", image: "rectangle.stack", selected: $current)
                    
                    Spacer(minLength: 0)
                    
                    TabButton(title: "Trophies", image: "fish", selected: $current)
                    
                    Spacer(minLength: 0)
                    
                    TabButton(title: "Settings", image: "gearshape", selected: $current)
                }
                .padding(.bottom, screenSize().height > 736 ? 0 : 10)
                .padding(.vertical)
                .padding(.horizontal)
                .background {
                    Rectangle()
                        .frame(width: screenSize().width - 25, height: 80)
                        .cornerRadius(20)
                        .foregroundColor(.newDarkGreen)
                }
                .padding(.horizontal, 25)
                
            }
        }
        .tint(.white)
    }
}

#Preview {
    TabMainView()
}


struct TabButton: View {
    var title: String
    var image: String
    
    @Binding var selected: String
    
    var body: some View {
        Button {
            withAnimation(.spring) {
                selected = title
            }
        } label: {
            HStack(spacing: 10) {
                Image(systemName: image)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 25, height: 25)
                
                if selected == title {
                    Text(title)
                    
                }
            }
            .foregroundColor(.white)
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(Color.white.opacity(selected == title ? 0.08 : 0))
            .clipShape(Capsule())
        }
    }
}
