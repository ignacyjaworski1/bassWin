//
//  TrophyDetailView.swift
//  bassWinTrophy
//
//  Created by admin on 7/29/24.
//




import SwiftUI


struct TrophyDetailView: View {
    
    var trophy: Trophy?
    
    @State private var imageToSave = UIImage()
    @State private var showImageSheet = false
    @Environment(\.dismiss) var dismiss
    
    var completion: () -> ()
    
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                
                //MARK: - Title
                HStack(spacing: 10) {
                    Button {
                        dismiss()
                        completion()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Button {
                        showImageSheet.toggle()
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                    
                }
                .padding()
                .overlay {
                    HStack {
                        Spacer()
                        
                        Text("Trophy")
                            .font(.system(size: 28, weight: .black))
                            .foregroundColor(.white)
                            .padding(.top, 10)
                        Spacer()
                    }
                }
                .imageShareSheet(isPresented: $showImageSheet, image: imageToSave)
                
                ScrollView {
                    VStack {
                        VStack {
                            if let imageData = trophy?.imageData, let image = UIImage(data: imageData) {
                                ZoomableView {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: screenSize().width - 40, height: 200)
                                }
                            }
                            Spacer()
                        }
                        .frame(height: 350)
                        
                        if let weight = trophy?.theme, let notion = trophy?.notion {
                            ScrollView {
                                VStack(alignment: .leading) {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            if !weight.isEmpty {
                                                Text("Theme:")
                                                    .foregroundStyle(.gray)
                                                    .opacity(0.9)
                                                    .font(.callout)
                                                Text(weight)
                                                    .foregroundStyle(.white)
                                                    .bold()
                                            }
                                            
                                            if !notion.isEmpty {
                                                Text(notion.isEmpty ? "" : "Note:")
                                                    .foregroundStyle(.gray)
                                                    .opacity(0.9)
                                                    .font(.callout)
                                                    .padding(.top)
                                                Text(notion)
                                                    .foregroundStyle(.white)
                                            }
                                        }
                                        Spacer()
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            if let data = trophy?.imageData, let image = UIImage(data: data) {
                imageToSave = image
            }
        }
    }
    
}

#Preview {
    TrophyDetailView(trophy: StorageManager.shared.getMOCK()){}
}



