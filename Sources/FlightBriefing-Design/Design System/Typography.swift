


import SwiftUI



// MARK: - Role-based fonts
//
// Reusable text roles for dense data displays and card-style panels.
// They honour Dynamic Type via the underlying system text styles, so
// users who scale text larger get proportionally larger labels too.
//
// `dataValue` is monospaced so columns of numbers (and the contents of
// input fields backed by `.input`) line up under labels rendered with
// `dataLabel`. Switch the underlying `.system(...)` to
// `.custom("Some-Font", size:)` later if the design system grows a
// typeface of its own — call sites don't change.

public extension Font {
    /// Label text in form-style data displays — the "Planned:", "ATO:",
    /// "MORA:" side of "Label: value" pairs. Proportional spacing.
    static let dataLabel = Font.system(.subheadline)

    /// Value text in form-style data displays — the right-hand side of
    /// "Label: value" pairs and the contents of input fields.
    /// Monospaced so columns of numbers align under each other.
    static let dataValue = Font.dataLabel.monospaced()

    /// Header above a section or column of data ("Time", "Fuel", etc.).
    /// Slightly bolder and larger than ``dataLabel``.
    static let sectionTitle = Font.system(.title3).bold()

    /// Prominent title at the top of a card-style panel (e.g. the
    /// large waypoint ident on the leg view).
    static let viewTitle = Font.system(.title2).bold()
}

#Preview("Typography Styles") {
    VStack(alignment: .leading, spacing: 20) {

        Text("ViewTitle font")
            .font(.viewTitle)

        Text("SectionTitle font")
            .font(.sectionTitle)

        Text("Datalabel font")
            .font(.dataLabel)

        Text("Datavalue font")
            .font(.dataValue)


        // Show comparison with standard fonts
        Divider()
        
        VStack(alignment: .leading, spacing: 8) {
            Text("Comparison:")
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Text("Headline")
                .font(.headline)

            Text("Helvetica 15")
                .font(Font.custom("Helvetica", size: 15))

            Text("Helvetica Light 15 monospaced")
                .font(Font.custom("Helvetica-Light", size: 15)).monospaced()


        }
    }
    .padding()
}

// MARK: - Role-based font previews

#Preview("Role-based Fonts") {
    VStack(alignment: .leading, spacing: 20) {

        // Card-style title + section header above a small data grid.
        VStack(alignment: .leading, spacing: 8) {
            Text("WILLO: 114.3").font(.viewTitle)
            Text("Fuel").font(.sectionTitle)

            Grid(alignment: .leading, horizontalSpacing: 8, verticalSpacing: 4) {
                GridRow {
                    Text("Planned:").font(.dataLabel)
                    Text("10000").font(.dataValue)
                        .gridColumnAlignment(.trailing)
                }
                GridRow {
                    Text("Actual:").font(.dataLabel)
                    Text("9876").font(.dataValue)
                }
                GridRow {
                    Text("Min Req:").font(.dataLabel)
                    Text("8500").font(.dataValue)
                }
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.1), in: .rect(cornerRadius: 12))

        Divider()

        // Monospaced alignment proof — numbers line up under each other.
        VStack(alignment: .leading, spacing: 4) {
            Text("Monospaced left aligned with spaces (dataValue):")
                .font(.caption)
                .foregroundStyle(.secondary)
            Text("10000").font(.dataValue)
            Text("  876").font(.dataValue)
            Text("   42").font(.dataValue)
        }
    }
    .padding()
}

