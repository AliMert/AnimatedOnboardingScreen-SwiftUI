//
//  ResizableLottieView.swift
//  AnimatedOnBoardingScreen
//
//  Created by Ali Mert Özhayta on 12.03.2023.
//

import SwiftUI
import Lottie

// MARK: Resizable Lottie View Without Background
struct ResizableLottieView: UIViewRepresentable {
    @Binding var onboardingItem: OnboardingItem
    var loopMode: LottieLoopMode = .playOnce

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        setupLottieView(view)
        return view
    }

    func updateUIView(_ uiview: UIView, context: Context) {}

    func setupLottieView(_ to: UIView) {
        let lottieView = onboardingItem.lottieView
        lottieView.loopMode = loopMode
        lottieView.backgroundColor = .clear
        lottieView.translatesAutoresizingMaskIntoConstraints = false

        // MARK: Applying Constraints
        let constraints = [
            lottieView.widthAnchor.constraint(equalTo:to.widthAnchor),
            lottieView.heightAnchor.constraint(equalTo:to.heightAnchor)
        ]
        to.addSubview(lottieView)
        to.addConstraints(constraints)
    }
}
