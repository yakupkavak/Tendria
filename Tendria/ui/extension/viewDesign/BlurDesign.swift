//
//  BlurDesign.swift
//  Tendria
//
//  Created by Yakup Kavak on 26.04.2025.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
    
    // Declare a property 'style' of type UIBlurEffect.Style to store the blur effect style.
    let style: UIBlurEffect.Style
    
    // Initializer for the BlurView, taking a UIBlurEffect.Style as a parameter and setting it to the 'style' property.
    init(style: UIBlurEffect.Style) {
        self.style = style
    }
    
    // Required method of UIViewRepresentable protocol. It creates and returns the UIVisualEffectView.
    func makeUIView(context: Context) -> UIVisualEffectView {
        // Create a UIBlurEffect with the specified 'style'.
        let blurEffect = UIBlurEffect(style: style)
        // Initialize a UIVisualEffectView with the blurEffect.
        let blurView = UIVisualEffectView(effect: blurEffect)
        // Return the configured blurView.
        return blurView
    }
    
    // Required method of UIViewRepresentable protocol. Here, it's empty as we don't need to update the view after creation.
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
