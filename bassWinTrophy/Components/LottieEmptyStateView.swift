//
//  LottieEmptyStateView.swift
//  bassWinTrophy
//
//  Created by admin on 7/29/24.
//



import SwiftUI
import Lottie

struct LottieEmptyStateView: UIViewRepresentable {
  var fileName: String
   
  func makeUIView(context: UIViewRepresentableContext<LottieEmptyStateView>) -> some UIView {
     
    let view = UIView(frame: .zero)
     
    let lottieAnimationView = Lottie.LottieAnimationView()
     
    lottieAnimationView.animation = .named(fileName)
    lottieAnimationView.contentMode = .scaleAspectFit
    lottieAnimationView.loopMode = .loop
    lottieAnimationView.play()
     
    lottieAnimationView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(lottieAnimationView)
     
    NSLayoutConstraint.activate([
      lottieAnimationView.widthAnchor.constraint(equalTo: view.widthAnchor),
      lottieAnimationView.heightAnchor.constraint(equalTo: view.heightAnchor)
    ])
     
    return view
  }
   
  func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<LottieEmptyStateView>) {
     
  }
}
