//
//  AttributedString+Highlight.swift
//  FlightBriefing-Design
//
//  Created by Johan Bergsee on 2026-09-02.
//
//  Generic, reusable substring highlighting for AttributedString, plus the shared
//  search-match look so every search-highlighted view uses the same color.
//

import SwiftUI

public extension AttributedString {

    /// Applies `style` to every case-insensitive, non-overlapping match of `needle`.
    /// Matches `String.range(of:options:.caseInsensitive)` semantics. No-op if `needle` is empty.
    mutating func highlight(_ needle: String,
                            caseInsensitive: Bool = true,
                            style: (inout AttributedSubstring) -> Void) {
        guard !needle.isEmpty else {
            return
        }
        let haystack = String(characters)
        let options: String.CompareOptions = caseInsensitive ? [.caseInsensitive] : []
        var searchRange = haystack.startIndex..<haystack.endIndex
        while let found = haystack.range(of: needle, options: options, range: searchRange) {
            if let attributedRange = Range(found, in: self) {
                style(&self[attributedRange])
            }
            searchRange = found.upperBound..<haystack.endIndex
        }
    }

    /// Convenience: build an AttributedString from `text` and highlight every match of `needle`.
    static func highlighting(_ needle: String,
                             in text: String,
                             caseInsensitive: Bool = true,
                             style: (inout AttributedSubstring) -> Void) -> AttributedString {
        var attributed = AttributedString(text)
        attributed.highlight(needle, caseInsensitive: caseInsensitive, style: style)
        return attributed
    }

    /// The look of a search-term match (yellow background, like a highlighter pen).
    /// Pass as the `style` of ``highlight(_:caseInsensitive:style:)``.
    static func searchMatch(_ run: inout AttributedSubstring) {
        run.backgroundColor = .yellow
    }

    /// Convenience: build an AttributedString from `text` with every match of `searchTerm`
    /// in the ``searchMatch(_:)`` look.
    static func highlightingSearch(_ searchTerm: String, in text: String) -> AttributedString {
        highlighting(searchTerm, in: text, style: searchMatch)
    }
}

// MARK: - Previews

#Preview {
    VStack(alignment: .leading, spacing: .m) {
        Text(AttributedString.highlightingSearch("rwy", in: "RWY 08/26 CLSD, use rwy 01L/19R"))
        Text(AttributedString.highlighting("CLSD", in: "RWY 08/26 CLSD") { run in
            run.foregroundColor = .red
            run.inlinePresentationIntent = .stronglyEmphasized
        })
    }
    .font(.dataValue)
    .padding()
}
