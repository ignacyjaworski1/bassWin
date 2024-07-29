//
//  TrophyCell.swift
//  bassWinTrophy
//
//  Created by admin on 7/29/24.
//



import SwiftUI

struct TrophyCell: View {
    
    var dataImage: Data?
    var name: String
    
    var body: some View {
        Rectangle()
            .fill(Color.black.opacity(0.6))
            .frame(height: 150)
            .cornerRadius(12)
            .padding(.horizontal)
            .shadow(color: .white.opacity(0.25), radius: 2)
            .overlay {
                HStack {
                    if let data = dataImage, let image = UIImage(data: data) {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 110, height: 110)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 2)
                                    .foregroundStyle(.white)
                            }
                    } else {
                        Image("bgBlur")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 110, height: 110)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
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
    TrophyCell(name: "123123123")
}
