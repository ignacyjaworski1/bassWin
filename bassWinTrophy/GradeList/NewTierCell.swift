//
//  NewTierCell.swift
//  bassWinTrophy
//
//  Created by admin on 7/29/24.
//



import SwiftUI

struct NewTierCell: View {
    
    var dataImage: Data?
    var name: String
    
    var body: some View {
        Rectangle()
            .fill(Color.black.opacity(0.6))
            .frame(height: 110)
            .cornerRadius(12)
            .padding(.horizontal)
            .shadow(color: .white.opacity(0.25), radius: 2)
            .overlay {
                HStack {
                    if let data = dataImage, let image = UIImage(data: data) {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 90, height: 90)
                            .clipShape(Circle())
                            .overlay {
                                Circle()
                                    .stroke(lineWidth: 2)
                                    .foregroundStyle(.white)
                            }
                    } else {
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 90, height: 90)
                            .clipShape(Circle())
                            .overlay {
                                Circle()
                                    .stroke(lineWidth: 2)
                                    .foregroundStyle(.white)
                            }
                        
                    }
                    
                    Text(name)
                        .foregroundStyle(.white)
                        .bold()
                        .font(.title2)
                        .padding(.leading)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                }
                .padding(.horizontal, 40)
            }
    }
}

#Preview {
    NewTierCell(name: "123123123")
}
