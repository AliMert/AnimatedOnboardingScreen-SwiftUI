//
//  OnboardingItem.swift
//  AnimatedOnBoardingScreen
//
//  Created by Ali Mert Özhayta on 12.03.2023.
//

import SwiftUI
import Lottie

struct OnboardingItem: Identifiable, Equatable {
    let id: UUID = .init()
    let title: String
    let subTitle: String
    let lottieView: LottieAnimationView
}
