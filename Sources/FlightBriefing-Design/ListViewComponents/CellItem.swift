//
//  CellItem.swift
//  FlightBriefing-Design
//
//  Created by Johan Bergsee on 2026-09-02.
//
//  A reusable "heading over value" cell.
//

import SwiftUI

/// A reusable "heading over value" cell: a `title` rendered with the dense
/// list-row label role above a `value` rendered with the list-row value role.
/// The value may be a plain `String` or a styled `AttributedString`.
public struct CellItem: View {
    public let title: String
    private let value: AttributedString

    /// Plain-text value.
    public init(title: String, value: String) {
        self.title = title
        self.value = AttributedString(value)
    }

    /// Styled/attributed value (e.g. search-highlighted text).
    public init(title: String, value: AttributedString) {
        self.title = title
        self.value = value
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: .xs) {
            Text(title)
                .listCellLabelStyle()   // .listCellLabel font + secondary foreground
            Text(value)
                .font(.listCellValue)
        }
    }
}

// MARK: - Previews

#Preview("Plain value") {
    CellItem(title: "STD:", value: "261340")
        .padding()
}

#Preview("Attributed value") {
    var attr = AttributedString("Highlighted")
    attr.backgroundColor = .yellow
    return CellItem(title: "Status:", value: attr)
        .padding()
}
