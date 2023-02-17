//
//  Styles.swift
//  DesignPlusCodeSwiftUIiOS15
//
//  Created by Abanoub Ashraf on 25/11/2022.
//

import SwiftUI

///
/// this is how to make a custom modifer in swiftui
///
struct StrokeStyle: ViewModifier {
    ///
    /// to access the current color scheme setted in the app by the user and use it as a condition
    ///
    @Environment(\.colorScheme) var colorScheme
    
    var cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content.overlay {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                ///
                /// this traces the outline of this shape with a color or gradient
                ///
                .stroke(
                    .linearGradient(
                        colors: [
                            .white.opacity(colorScheme == .dark ? 0.1 : 0.4),
                            .black.opacity(colorScheme == .dark ? 0.3 : 0.1)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                ///
                /// to add visual effect to the overlay
                ///
                .blendMode(.overlay)
        }
    }
}

///
/// this is to allow us to call the custom modifier above like any existing modifier
///
extension View {
    func strokeStyle(cornerRadius: CGFloat = 30) -> some View {
        modifier(StrokeStyle(cornerRadius: cornerRadius))
    }
}
