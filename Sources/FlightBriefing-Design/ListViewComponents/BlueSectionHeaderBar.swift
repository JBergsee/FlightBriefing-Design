//
//  BlueSectionHeaderBar.swift
//  FlightBriefing-Design
//
//  Created by Johan Bergsee on 2026-10-11.
//
//  A blue, pinned List section header with a one-line title on the left and optional
//  controls on the right (e.g. a Show/Hide button). Use as a Section's `header:`.
//

import SwiftUI

public struct BlueSectionHeaderBar<Trailing: View>: View {
    let title: AttributedString
    let trailing: Trailing

    /// Styled/attributed title (e.g. search-highlighted text) with trailing controls.
    public init(title: AttributedString, @ViewBuilder trailing: () -> Trailing) {
        self.title = title
        self.trailing = trailing()
    }

    public var body: some View {
        HStack(alignment: .center, spacing: .l) {
            Text(title)
                .listHeaderStyle()
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .layoutPriority(1) // The title gets the width; the controls keep their size
                .accessibilityAddTraits(.isHeader)

            trailing
        }
        .blueSectionHeader()
    }
}

public extension BlueSectionHeaderBar where Trailing == EmptyView {
    /// Styled/attributed title only.
    init(title: AttributedString) {
        self.init(title: title) {
            EmptyView()
        }
    }

    /// Plain-text title only.
    init(title: String) {
        self.init(title: AttributedString(title))
    }
}

public extension BlueSectionHeaderBar {
    /// Plain-text title with trailing controls.
    init(title: String, @ViewBuilder trailing: () -> Trailing) {
        self.init(title: AttributedString(title), trailing: trailing)
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
            BlueSectionHeaderBar(title: "ESAA SWEDEN")
        }

        Section {
            ForEach(0..<3, id: \.self) { index in
                Text("Row \(index + 1)")
                    .font(.dataValue)
            }
        } header: {
            BlueSectionHeaderBar(title: AttributedString.highlightingSearch("swe", in: "ESAA SWEDEN")) {
                DisclosureToggleButton(isExpanded: true, title: "NOTAMs") {
                } label: {
                    Text("NOTAMs: 3")
                }
            }
        }
    }
    .listStyle(.plain)
    .appTheme()
}
