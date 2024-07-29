//
//  BackgroundView.swift
//  bassWinTrophy
//
//  Created by admin on 7/29/24.
//


import SwiftUI

struct BackgroundView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("bgBlur")
                    .resizable()
                    .scaledToFill()
                    .colorMultiply(.green.opacity(0.7))
                    .blur(radius: 12)
                    .background(Color.black)
                    .ignoresSafeArea()
            }
        }
    }
   
}


#Preview {
    BackgroundView()
}

