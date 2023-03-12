//
//  OnboardingView.swift
//  AnimatedOnBoardingScreen
//
//  Created by Ali Mert Özhayta on 12.03.2023.
//

import SwiftUI
import Lottie

struct OnboardingView: View {

    @State var currentIndex: Int = 0

    // MARK: OnboardingView Slides Model Data
    @State var onboardingItems: [OnboardingItem] = [
        .init(
            title: "Request Pickup",
            subTitle: "Tell us who you're sending it to, what you're sending and when it's best to pickup the package and we will pick it up at the most convenient time",
            lottieView: .init(name: "pickup", bundle: .main)
        ),
        .init(
            title: "Track Delivery",
            subTitle: "The best part starts when our courier is on the way to your location, as you will get real time notifications as to the exact location of the courier",
            lottieView: .init(name: "transfer", bundle: .main)
        ),
        .init(
            title: "Receive Package",
            subTitle: "The journey ends when your package get to it's location. Get notified immediately your package is received at its intended location",
            lottieView: .init (name: "delivery", bundle: .main)
        )
    ]
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size

            HStack(spacing: .zero) {
                ForEach($onboardingItems) { $item in
                    let isLastItem = currentIndex == onboardingItems.count - 1

                    VStack {
                        // MARK: Top Nav
                        HStack {
                            Button("Back") {
                                if currentIndex > 0 {
                                    currentIndex -= 1
                                }
                            }
                            .opacity(currentIndex > 0 ? 1 : 0)
                            .animation(currentIndex > 0 ? .easeIn : .none, value: currentIndex)

                            Spacer()

                            Button("Skip") {
                                currentIndex = onboardingItems.count - 1
                            }
                            .opacity(isLastItem ? 0 : 1)
                            .animation(.easeInOut, value: currentIndex)

                        }
                        .tint(Color("Green"))
                        .bold()


                        // MARK: Movable Slides
                        VStack(spacing: 15) {
                            let offset = -CGFloat(currentIndex) * size.width

                            // MARK: Resizable LottieView
                            ResizableLottieView(onboardingItem: $item, loopMode: .loop)
                                .frame(height: size.width)
                                .onAppear {
                                    if currentIndex == indexOf(item) {
                                        item.lottieView.play()
                                    }
                                }
                                .onChange(of: currentIndex) { currentIndex in
                                    if currentIndex == indexOf(item) {
                                        item.lottieView.play()
                                    } else {
                                        item.lottieView.stop()
                                    }
                                }
                                .offset(x: offset)
                                .animation(.easeOut(duration: 0.5), value: currentIndex)

                            Text(item.title)
                                .font(.title.bold())
                                .offset(x: offset)
                                .animation(.easeOut(duration: 0.5).delay(0.1), value: currentIndex)

                            Text(item.subTitle)
                                .font(.system(size: 14))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 16)
                                .foregroundColor(.secondary)
                                .offset(x: offset)
                                .animation(.easeOut(duration: 0.5).delay(0.2), value: currentIndex)
                        }

                        Spacer()

                        // MARK: Next / Login Button
                        VStack(spacing: 15) {
                            Button {
                                if currentIndex < onboardingItems.count - 1 {
                                    currentIndex += 1
                                }
                            } label: {
                                Text(isLastItem ? "Login" : "Next")
                                    .bold()
                                    .padding(.vertical, 4)
                                    .frame(maxWidth: .infinity)
                            }
                            .tint(Color("Green"))
                            .buttonStyle(.borderedProminent)
                            .clipShape(Capsule())
                            .padding(.horizontal, isLastItem ? 30 : 100)
                            .animation(.easeInOut(duration: 0.5), value: isLastItem)

                            HStack {
                                Button {} label: {
                                    Text("Terms of Service")
                                        .underline(color: .primary)
                                }

                                Button {} label: {
                                    Text("Privacy Policy")
                                        .underline(color: .primary)
                                }
                            }
                            .font(.caption2)
                            .tint(.primary)
                        }
                    }
                    .padding(15)
                    .frame(width: size.width, height: size.height)
                }
            }
            .frame(width: size.width * CGFloat(onboardingItems.count), alignment: .leading)
        }
    }

    func indexOf(_ item: OnboardingItem) -> Int {
        if let index = onboardingItems.firstIndex(of: item) {
            return index
        }

        return 0
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
