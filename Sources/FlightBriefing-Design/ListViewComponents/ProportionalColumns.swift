//
//  ProportionalColumns.swift
//  FlightBriefing-Design
//
//  Created by Johan Bergsee on 2026-10-21.
//
//  A one-row layout whose columns each get a fixed share of the offered width. Every
//  List row is offered the same width, so rows using the same weights line up with each
//  other whatever their content — unlike Grid, which only aligns columns within itself
//  and sizes them from the content. The columns grow with the width (larger screen,
//  landscape), and each cell is measured at its final column width, so long values
//  wrap instead of being truncated.
//

import SwiftUI

/// Lays out its cells left to right in columns that each get a fixed share of the width.
///
/// Use the same `weights` (and `spacing`) in every row that should line up, e.g. one
/// `ProportionalColumns` per List row, or several stacked in one row. A cell spans one
/// column unless marked with ``SwiftUI/View/layoutColumnSpan(_:)``.
///
/// ```swift
/// ProportionalColumns(weights: [100, 80, 150]) {
///     CellItem(title: "Number", value: "A0532/23")
///     CellItem(title: "FIR", value: "GOOO")
///     CellItem(title: "Valid from", value: "2023-04-20 08:00")
/// }
/// ```
public struct ProportionalColumns: Layout {
    /// Relative width of each column, e.g. [100, 80, 70, 150, 150].
    public let weights: [CGFloat]
    public let spacing: CGFloat

    public init(weights: [CGFloat], spacing: CGFloat = .m) {
        self.weights = weights
        self.spacing = spacing
    }

    public func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let frames = cellFrames(width: proposal.width ?? weights.reduce(0, +), subviews: subviews)
        let height = frames.map(\.maxY).max() ?? 0
        return CGSize(width: proposal.width ?? frames.map(\.maxX).max() ?? 0, height: height)
    }

    public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let frames = cellFrames(width: bounds.width, subviews: subviews)
        for (subview, frame) in zip(subviews, frames) {
            subview.place(at: CGPoint(x: bounds.minX + frame.minX, y: bounds.minY),
                          anchor: .topLeading,
                          proposal: ProposedViewSize(width: frame.width, height: frame.height))
        }
    }

    /// The frame of each cell: cells fill the columns left to right, each spanning
    /// `layoutColumnSpan` columns (and the spacing between them); heights are measured
    /// at the cell's final width.
    private func cellFrames(width: CGFloat, subviews: Subviews) -> [CGRect] {
        let totalWeight = weights.reduce(0, +)
        guard totalWeight > 0 else {
            return subviews.map { _ in
                .zero
            }
        }
        let available = max(0, width - spacing * CGFloat(weights.count - 1))
        let columnWidths = weights.map { available * $0 / totalWeight }

        var frames: [CGRect] = []
        var column = 0
        for subview in subviews {
            let span = min(max(1, subview[ColumnSpan.self]), weights.count - column)
            guard span > 0 else {
                frames.append(.zero) // More cells than columns
                continue
            }
            let x = columnWidths[..<column].reduce(0, +) + spacing * CGFloat(column)
            let cellWidth = columnWidths[column..<(column + span)].reduce(0, +) + spacing * CGFloat(span - 1)
            let cellHeight = subview.sizeThatFits(ProposedViewSize(width: cellWidth, height: nil)).height
            frames.append(CGRect(x: x, y: 0, width: cellWidth, height: cellHeight))
            column += span
        }
        return frames
    }
}

private struct ColumnSpan: LayoutValueKey {
    static let defaultValue = 1
}

public extension View {
    /// The number of ``ProportionalColumns`` columns this cell spans. Defaults to 1.
    func layoutColumnSpan(_ span: Int) -> some View {
        layoutValue(key: ColumnSpan.self, value: span)
    }
}

// MARK: - Previews

#Preview {
    let weights: [CGFloat] = [100, 80, 150, 150]
    List {
        ForEach(["A0532/23", "Company NOTAM/2023"], id: \.self) { number in
            VStack(alignment: .leading, spacing: .m) {
                ProportionalColumns(weights: weights) {
                    CellItem(title: "Number/year", value: number)
                    CellItem(title: "FIR", value: "GOOO")
                    CellItem(title: "Valid from", value: "2023-04-20 08:00")
                    CellItem(title: "Valid to", value: "Unlimited")
                }
                ProportionalColumns(weights: weights) {
                    CellItem(title: "Subject (spans 2)", value: "Movement area")
                        .layoutColumnSpan(2)
                    CellItem(title: "Schedule (spans 2)", value: "DAILY 0800-1600")
                        .layoutColumnSpan(2)
                }
            }
        }
    }
    .listStyle(.plain)
}
