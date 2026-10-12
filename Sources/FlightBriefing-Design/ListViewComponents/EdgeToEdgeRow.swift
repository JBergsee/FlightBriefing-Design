//
//  EdgeToEdgeRow.swift
//  FlightBriefing-Design
//
//  Created by Johan Bergsee on 2026-10-11.
//
//  A List row whose own padding replaces the default row insets, so a background reaches
//  the display edges. Apply with `.edgeToEdgeRow()`.
//

import SwiftUI

public extension View {
    /// Pads the row, draws `background` behind it, and zeroes the List row insets so the
    /// background fills the whole row, edge to edge.
    ///
    /// The background is drawn as row content rather than with `.listRowBackground`: List
    /// applies its row background to the cell outside SwiftUI's transaction, so when a row
    /// both changes color and moves (e.g. a status change that re-sorts the list), the color
    /// would change only after the move. As content, it animates together with the move.
    ///
    /// - Parameters:
    ///   - horizontal: Leading and trailing padding. Defaults to `.l`, matching ``BlueSectionHeader``.
    ///   - vertical: Top and bottom padding. Defaults to `.m`.
    ///   - background: The row background. Defaults to none.
    func edgeToEdgeRow(horizontal: CGFloat = .l,
                       vertical: CGFloat = .m,
                       background: some ShapeStyle = .clear) -> some View {
        padding(.horizontal, horizontal)
            .padding(.vertical, vertical)
            .background(background)
            .listRowInsets(EdgeInsets())
    }
}

// MARK: - Previews

#Preview {
    List {
        Text("Default padding, no background")
            .frame(maxWidth: .infinity, alignment: .leading)
            .edgeToEdgeRow()
        Text("Default padding, OK background")
            .frame(maxWidth: .infinity, alignment: .leading)
            .edgeToEdgeRow(background: Color.bgOK)
        Text("Small padding, attention background")
            .frame(maxWidth: .infinity, alignment: .leading)
            .edgeToEdgeRow(horizontal: .m, vertical: .s, background: Color.bgAttention)
    }
    .listStyle(.plain)
}
