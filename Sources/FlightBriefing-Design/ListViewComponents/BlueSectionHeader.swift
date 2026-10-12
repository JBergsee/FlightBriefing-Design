//
//  BlueSectionHeader.swift
//  FlightBriefing-Design
//
//  Created by Johan Bergsee on 2026-10-09.
//
//  The blue, pinned List section header look: padding, an opaque blue-tinted
//  background, full-contrast text and a bottom drop shadow. Apply with `.blueSectionHeader()`.
//

import SwiftUI

public struct BlueSectionHeader: ViewModifier {
    public init() {}

    public func body(content: Content) -> some View {
        content
            .padding(.vertical, .m)
            .padding(.horizontal, .l) // To offset text from the edge

            // Override the List section-header foreground remap (which renders header
            // content gray). Setting concrete adaptive levels restores true label/
            // secondaryLabel contrast inside the header, so `.primary`/`.secondary` work.
            .foregroundStyle(Color(uiColor: .label), Color(uiColor: .secondaryLabel))
            .background(
                ZStack {
                    Color(uiColor: .systemBackground)   // opaque — blocks scroll-through
                    Color.accentColor.opacity(0.1)      // blue tint, on top
                }
            )

            // Bottom-edge drop shadow so rows read as scrolling *underneath* the pinned
            // section header. compositingGroup() casts the shadow from the flattened
            // opaque header rectangle; the positive y offset + small radius keep it bottom-only,
            // since the opaque header itself hides the upward spill.
            .compositingGroup()
            .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 3)
            .fixedSize(horizontal: false, vertical: true) // hug vertically, expand horizontally
            .listRowInsets(EdgeInsets()) // Let the background go all the way to the display edge
    }
}

public extension View {
    /// Styles the view as a blue, pinned List section header (see BlueSectionHeader).
    func blueSectionHeader() -> some View {
        modifier(BlueSectionHeader())
    }
}

// MARK: - Previews

#Preview {
    List {
        Section {
            ForEach(0..<3, id: \.self) { index in
                Text("Row \(index + 1)")
                    .font(.dataValue)
            }
        } header: {
            Text("Section title")
                .listHeaderStyle()
                .frame(maxWidth: .infinity, alignment: .leading)
                .blueSectionHeader()
        }
    }
    .listStyle(.plain)
}
