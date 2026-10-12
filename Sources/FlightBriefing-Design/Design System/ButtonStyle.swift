//
//  SettingsView+Design.swift
//  FlightBriefing
//
//  Created by Johan Bergsee on 2025-05-13.
//  Copyright © 2025 JN Avionics. All rights reserved.
//

import SwiftUI

// MARK: - Button Style

/// Imitates a bordered button with some extras.
///
/// The button colour follows the ambient `.tint` from the environment, so
/// override it per call site with `.tint(_:)`. The app accent colour is the
/// default because `appTheme()` sets it at the root; if you use this style
/// outside a themed hierarchy, set `.tint(_:)` yourself.
public struct PrimaryButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .multilineTextAlignment(.center)
            .font(.body)
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            .foregroundStyle(.tint)
            .background(.tint.opacity(configuration.isPressed ? 0.08 : 0.15))
            .clipShape(Capsule(style: .continuous))
            .scaleEffect(configuration.isPressed ? 0.93 : 1)
            .animation(.smooth, value: configuration.isPressed)
    }
}

public extension ButtonStyle where Self == PrimaryButtonStyle {
    static var fbDefault: PrimaryButtonStyle { .init() }
}
#Preview("Primary Button Style") {
    VStack(spacing: 20) {

        // Default: no explicit tint — follows the app accent from `appTheme()`.
        Button("Default (accent tint)") {
            print("Tapped")
        }
        .buttonStyle(.fbDefault)

        // Per-call-site override: set the ambient tint and the style picks it up.
        Button("Tinted red") {
            print("Tapped")
        }
        .tint(.red)
        .buttonStyle(.fbDefault)

        // Any colour works, including design-system colours.
        Button("Tinted with AppColor.warning") {
            print("Tapped")
        }
        .tint(Color(AppColor.warning))
        .buttonStyle(.fbDefault)

        Button("Disabled State") {
            print("Tapped")
        }
        .buttonStyle(.fbDefault)
        .disabled(true)
    }
    .padding()
    .appTheme() // supplies the default accent tint, as at a real UIHostingController root
}

