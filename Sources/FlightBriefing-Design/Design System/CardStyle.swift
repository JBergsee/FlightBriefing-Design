//
//  CardStyle.swift
//  FlightBriefing-Design
//
//  Created by Johan Bergsee on 2026-06-08.
//  
//

import SwiftUI

// MARK: - Card chrome

public extension View {
    /// Floating-card chrome: regular material background, rounded
    /// corners and a soft drop shadow. Use on any panel that sits above
    /// the surrounding content (overlays, secondary panels, etc.).
    ///
    /// - Parameter cornerRadius: Corner radius of the card. Defaults to 16.
    func cardStyle(cornerRadius: CGFloat = 16) -> some View {
        self
            .background(.regularMaterial, in: .rect(cornerRadius: cornerRadius))
            .clipShape(.rect(cornerRadius: cornerRadius))
            .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 12)
    }
}

// MARK: - Previews

#Preview("Card style") {
    ZStack {
        // Coloured backdrop so the material + shadow read clearly.
        LinearGradient(colors: [.teal, .indigo],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .ignoresSafeArea()

        VStack(spacing: 24) {
            // Default 16pt corner radius
            VStack(alignment: .leading, spacing: 4) {
                Text("Primary card").font(.headline)
                Text("`.cardStyle()` — default 16pt corner radius")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .frame(width: 300)
            .cardStyle()

            // Smaller 12pt corner radius for secondary panels
            VStack(alignment: .leading, spacing: 4) {
                Text("Secondary panel").font(.headline)
                Text("`.cardStyle(cornerRadius: 12)`")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .frame(width: 240)
            .cardStyle(cornerRadius: 12)
        }
    }
}
