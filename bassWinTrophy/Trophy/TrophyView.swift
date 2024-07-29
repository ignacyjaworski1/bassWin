//
//  TrophyView.swift
//  bassWinTrophy
//
//  Created by admin on 7/29/24.
//




import SwiftUI
import AVFoundation

class TrophyViewModel: ObservableObject {
    func updateView() {
        objectWillChange.send()
    }
}

struct TrophyView: View {
    
    @StateObject private var viewModel = TrophyViewModel()
    @State var trophies: [Trophy] = []
    var completion: () -> ()
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                
                VStack {
                    HStack {
                        Text("Trophies")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .bold()
                            .padding(.top)
                            .padding(.leading)
                        
                        Spacer()
                    }

                    if StorageManager.shared.prizes.isEmpty {
                        
                        VStack(spacing: 60) {
                            Text("Whoops, no Angler's Prizes yet")
                                .font(.system(size: 25))
                            
                            Image(systemName: "figure.fishing")
                                .font(.system(size: 150))
                            
                            Text("It's time to add one on the main screen.")
                                .font(.system(size: 25))
                        }
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray.opacity(0.5))
                        .padding(.horizontal, 30)
                    } else {
                        ScrollView {
                            VStack {
                                ForEach(trophies, id: \.id) { prize in
                                    NavigationLink {
                                        TrophyDetailView(trophy: prize) {
                                            self.trophies = Array(StorageManager.shared.prizes)
                                            completion()
                                        }
                                        .onAppear {
                                            completion()
                                        }
                                            .navigationBarBackButtonHidden()
                                            .navigationBarHidden(true)
                                            .toolbar(.hidden, for: .tabBar)
                                    } label: {
                                        TrophyCell(dataImage: prize.imageData, name: prize.theme ?? "")
                                            .padding(.vertical, 2)
                                    }
                                }
                            }
                        }
                        .padding(.top, -20)
                        .hideScrollIndicator()
                    }
                    
                    Spacer()
                }
                
                
            }
            .onAppear {
                trophies = Array(StorageManager.shared.prizes)
                viewModel.updateView()
            }

        }
    }
}

struct TrophyView_Previews: PreviewProvider {
    static var previews: some View {
        TrophyView(){}
    }
}
