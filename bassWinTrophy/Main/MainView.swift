//
//  MainView.swift
//  bassWinTrophy
//
//  Created by admin on 7/29/24.
//


import SwiftUI

struct MainView: View {
    
    @State private var isGradeShown = false
    @State private var isTrophyShown = false

    var completion: () -> ()
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                VStack {
                    LottieEmptyStateView(fileName: "bubbles")
                    LottieEmptyStateView(fileName: "bubbles")
                    LottieEmptyStateView(fileName: "bubbles")
                }
                .blendMode(.softLight)
                
                VStack {
                    Image("logo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: screenSize().width - 60, height: 200)
                    
                    Spacer()
                    
                    ScrollView {
                        VStack {
                            Button {
                                isGradeShown.toggle()
                            } label: {
                                ZStack {
                                    Rectangle()
                                        .fill(Color.newDarkGreen)
                                        .frame(width: screenSize().width - 40, height: 150)
                                        .opacity(0.9)
                                        .cornerRadius(12)
                                    
                                    HStack {
                                        Text("Create Grade List")
                                            .foregroundStyle(.white)
                                            .font(.system(size: 30, weight: .medium))
                                            
                                        
                                        Image("grades")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .colorInvert()
                                    }
                                }
                                .shadow(radius: 10)
                            }
                            
                            Button {
                                isTrophyShown.toggle()
                            } label: {
                                ZStack {
                                    Rectangle()
                                        .fill(Color.newDarkGreen)
                                        .frame(width: screenSize().width - 40, height: 150)
                                        .opacity(0.9)
                                        .cornerRadius(12)
                                    
                                    HStack {
                                        Text("Save the Trophy")
                                            .foregroundStyle(.white)
                                            .font(.system(size: 30, weight: .medium))
                                        
                                        Image("fish")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .colorInvert()
                                    }
                                }
                                .shadow(radius: 10)
                            }
                        }
                    }
                    .padding(.top, 30)
                }
            }
        }
        .fullScreenCover(isPresented: $isGradeShown) {
            GradeMakerView(){
                
            } hidingTab: {
                completion()
            }
        }
        .fullScreenCover(isPresented: $isTrophyShown) {
            NewTrophyView()
        }
    }
}

#Preview {
    MainView(){}
}
import Foundation
