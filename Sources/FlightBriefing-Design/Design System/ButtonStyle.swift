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
public struct PrimaryButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.body)
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            .foregroundStyle(.tint)
            .background(.tint.opacity(configuration.isPressed ? 0.08 : 0.15))
            .clipShape(Capsule(style: .continuous))
            .scaleEffect(configuration.isPressed ? 0.93 : 1)
            .animation(.smooth, value: configuration.isPressed)
            .tint(SwiftUI.Color(uiColor: AppColor.accentColor))
    }
}

public extension ButtonStyle where Self == PrimaryButtonStyle {
    static var fbDefault: PrimaryButtonStyle { .init() }
}
