//
//  EmptySearchOverlay.swift
//  FlightBriefing-Design
//
//  Created by Johan Bergsee on 2026-10-11.
//
//  The "nothing here" and "no search results" states of a searchable list, as an overlay.
//

import SwiftUI

public extension View {
    /// Overlays a `ContentUnavailableView` when there is nothing to show.
    ///
    /// - Parameters:
    ///   - isEmpty: There is no data at all; shows `title` and `systemImage`.
    ///   - title: The empty-state title, e.g. "No Sigmets found".
    ///   - systemImage: The empty-state SF Symbol.
    ///   - searchText: The active search text, shown in the no-results state.
    ///   - hasNoSearchResults: There is data, but the search filtered all of it out.
    func emptySearchOverlay(isEmpty: Bool,
                            title: LocalizedStringKey,
                            systemImage: String,
                            searchText: String,
                            hasNoSearchResults: Bool) -> some View {
        overlay {
            if isEmpty {
                ContentUnavailableView(title, systemImage: systemImage)
            } else if hasNoSearchResults {
                ContentUnavailableView.search(text: searchText)
            }
        }
    }
}

// MARK: - Previews

#Preview("Empty") {
    List {
    }
    .emptySearchOverlay(isEmpty: true, title: "No Sigmets found", systemImage: "cloud.bolt",
                        searchText: "", hasNoSearchResults: false)
}

#Preview("No search results") {
    List {
    }
    .emptySearchOverlay(isEmpty: false, title: "No Sigmets found", systemImage: "cloud.bolt",
                        searchText: "turb", hasNoSearchResults: true)
}
