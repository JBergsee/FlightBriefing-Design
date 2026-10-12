//
//  Sizes.swift
//  FlightBriefing-Foundation
//
//  Created by Johan Bergsee on 2025-04-22.
//  
//  https://www.mobilesystemdesign.com/blog/design-system-spacing/


import SwiftUI

// MARK: - Spacing Design Tokens
// Centralized spacing scale for consistent layout across the app.
// Prefer using these tokens instead of hard-coded numbers.
// Example: .padding(.horizontal, Spacing.m)
//          .padding(SpacingInsets.m)

private struct Space {
  static let s4: CGFloat = 4
  static let s8: CGFloat = 8
  static let s12: CGFloat = 12
  static let s16: CGFloat = 16
  static let s24: CGFloat = 24
  static let s32: CGFloat = 32
  static let s40: CGFloat = 40
  static let s48: CGFloat = 48
  static let s64: CGFloat = 64
  static let s80: CGFloat = 80
}

/**
Structured spacing.

 Usage:
 ```
 let staticPadding = Spacing.md.value // Returns Space.s24

 @Environment(\.horizontalSizeClass) var sizeClass
 // Returns either Space.s24 or Space.s24 + Space.s8 (32 total)
 let dynamicPadding = Spacing.md.dynamic(for: sizeClass)
```
This approach keeps your spacing consistent while allowing it to scale naturally with the UI. It also reduces the need to create separate layout logic for every device class.
 */
public struct Spacing: Sendable {

        //  We now store a value and a potential offset
        let value: CGFloat
        let offset: CGFloat

        // Instance method that returns the dynamic spacing.
        func dynamic(for sizeClass: UserInterfaceSizeClass?) -> CGFloat {
            return sizeClass == .regular ? value + offset : value
        }

        // We update the defaults a regular value and a potential offset
    static let xs = Spacing(value: Space.s4,  offset: Space.s4)
    static let s  = Spacing(value: Space.s8,  offset: Space.s8)
        static let m   = Spacing(value: Space.s16, offset: Space.s8)
        static let l   = Spacing(value: Space.s24, offset: Space.s8)
        static let xl   = Spacing(value: Space.s32, offset: Space.s8)
        static let xxl  = Spacing(value: Space.s40, offset: Space.s8)
        static let x3l = Spacing(value: Space.s48, offset: Space.s16)
        static let x4l = Spacing(value: Space.s64, offset: Space.s16)
        static let x5l = Spacing(value: Space.s80, offset: Space.s16)
    }


// MARK: - CGFloat conveniences
public extension CGFloat {
    static var xs:  CGFloat { Spacing.xs.value }
    static var s:   CGFloat { Spacing.s.value }
    static var m:   CGFloat { Spacing.m.value }
    static var l:   CGFloat { Spacing.l.value }
    static var xl:  CGFloat { Spacing.xl.value }
    static var xxl: CGFloat { Spacing.xxl.value }
}

// MARK: - EdgeInsets conveniences
public struct SpacingInsets: Sendable {
    public let insets: EdgeInsets

    public init(_ value: Spacing) {
        self.insets = EdgeInsets(top: value.value, leading: value.value, bottom: value.value, trailing: value.value)
    }

    public init(vertical: Spacing, horizontal: Spacing) {
        self.insets = EdgeInsets(top: vertical.value, leading: horizontal.value, bottom: vertical.value, trailing: horizontal.value)
    }

    public init(top: Spacing, leading: Spacing, bottom: Spacing, trailing: Spacing) {
        self.insets = EdgeInsets(top: top.value, leading: leading.value, bottom: bottom.value, trailing: trailing.value)
    }
}

public extension SpacingInsets {
    static let xs = SpacingInsets(.xs)
    static let s  = SpacingInsets(.s)
    static let m  = SpacingInsets(.m)
    static let l  = SpacingInsets(.l)
    static let xl = SpacingInsets(.xl)
    static let xxl = SpacingInsets(.xxl)
}

// MARK: - View helpers
public extension View {
    func padding(_ spacing: Spacing) -> some View { padding(spacing.value) }
    func padding(_ insets: SpacingInsets) -> some View { padding(insets.insets) }
}

// MARK: - Dynamic Type scaling

extension Spacing {
    /// The spacing scaled the way `@ScaledMetric` would, but for an explicit Dynamic Type size, so it
    /// follows the view's `\.dynamicTypeSize` (including preview and subtree overrides).
    func scaled(for size: DynamicTypeSize, relativeTo textStyle: UIFont.TextStyle) -> CGFloat {
        let traits = UITraitCollection(preferredContentSizeCategory: UIContentSizeCategory(size))
        return UIFontMetrics(forTextStyle: textStyle).scaledValue(for: value, compatibleWith: traits)
    }
}

/**
 Spacing tokens scaled to the view's Dynamic Type size.

 The standard tokens (`.m`, `.padding(.s)`) are fixed. Use these where the spacing or size should
 grow with the text. Name the property `scaledSpacing` so scaled and standard spacing are easy to tell apart:
 ```
 @ScaledSpacings private var scaledSpacing

 HStack(spacing: scaledSpacing.m) { … }   // scales with Dynamic Type
     .padding(.horizontal, .s)            // standard, fixed
 ```
 Scaling stops at `maximumSize` (default `.xxxLarge`), so accessibility sizes don't blow up the layout.
 */
@propertyWrapper
public struct ScaledSpacings: DynamicProperty {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    private let textStyle: UIFont.TextStyle
    private let maximumSize: DynamicTypeSize

    public init(relativeTo textStyle: UIFont.TextStyle = .body, maximumSize: DynamicTypeSize = .xxxLarge) {
        self.textStyle = textStyle
        self.maximumSize = maximumSize
    }

    public var wrappedValue: Tokens {
        Tokens(size: min(dynamicTypeSize, maximumSize), textStyle: textStyle)
    }

    public struct Tokens {
        let size: DynamicTypeSize
        let textStyle: UIFont.TextStyle

        public var xs: CGFloat {
            Spacing.xs.scaled(for: size, relativeTo: textStyle)
        }

        public var s: CGFloat {
            Spacing.s.scaled(for: size, relativeTo: textStyle)
        }

        public var m: CGFloat {
            Spacing.m.scaled(for: size, relativeTo: textStyle)
        }

        public var l: CGFloat {
            Spacing.l.scaled(for: size, relativeTo: textStyle)
        }

        public var xl: CGFloat {
            Spacing.xl.scaled(for: size, relativeTo: textStyle)
        }

        public var xxl: CGFloat {
            Spacing.xxl.scaled(for: size, relativeTo: textStyle)
        }

        public var x3l: CGFloat {
            Spacing.x3l.scaled(for: size, relativeTo: textStyle)
        }

        public var x4l: CGFloat {
            Spacing.x4l.scaled(for: size, relativeTo: textStyle)
        }

        public var x5l: CGFloat {
            Spacing.x5l.scaled(for: size, relativeTo: textStyle)
        }
    }
}


#Preview("Spacing Scale") {
    ScrollView {
        VStack(alignment: .leading, spacing: 16) {
            Text("Spacing Tokens")
                .font(.headline)
            
            spacingRow("xs", spacing: .xs)
            spacingRow("s", spacing: .s)
            spacingRow("m", spacing: .m)
            spacingRow("l", spacing: .l)
            spacingRow("xl", spacing: .xl)
            spacingRow("xxl", spacing: .xxl)
            spacingRow("x3l", spacing: .x3l)
            spacingRow("x4l", spacing: .x4l)
        }
        .padding()
    }
}

@ViewBuilder
private func spacingRow(_ label: String, spacing: Spacing) -> some View {
    HStack(spacing: 8) {
        Text(label)
            .frame(width: 40, alignment: .leading)
            .font(.caption.monospaced())
        
        Rectangle()
            .fill(Color.blue)
            .frame(width: spacing.value, height: 20)
        
        Text("\(Int(spacing.value))pt")
            .font(.caption2)
            .foregroundStyle(.secondary)
    }
}

#Preview("Spacing Insets") {
    VStack(spacing: 20) {
        Text("No Padding")
            .background(Color.red.opacity(0.2))

        Text("Xtra Small Padding")
            .padding(SpacingInsets.xs)
            .background(Color.brown.opacity(0.2))

        Text("Small Padding")
            .padding(SpacingInsets.s)
            .background(Color.blue.opacity(0.2))
        
        Text("Medium Padding")
            .padding(SpacingInsets.m)
            .background(Color.green.opacity(0.2))
        
        Text("Large Padding")
            .padding(SpacingInsets.l)
            .background(Color.orange.opacity(0.2))
        
        Text("Custom Insets")
            .padding(SpacingInsets(vertical: .xs, horizontal: .l))
            .background(Color.purple.opacity(0.2))
    }
    .padding()
}

/// Usage example for `ScaledSpacings`: scaled tokens (blue) next to the standard, fixed ones (gray).
private struct ScaledSpacingExample: View {
    @ScaledSpacings private var scaledSpacing

    var body: some View {
        VStack(alignment: .leading, spacing: scaledSpacing.s) {
            scaledRow("xs", scaled: scaledSpacing.xs, standard: .xs)
            scaledRow("s", scaled: scaledSpacing.s, standard: .s)
            scaledRow("m", scaled: scaledSpacing.m, standard: .m)
            scaledRow("l", scaled: scaledSpacing.l, standard: .l)
            scaledRow("xl", scaled: scaledSpacing.xl, standard: .xl)
            scaledRow("xxl", scaled: scaledSpacing.xxl, standard: .xxl)
        }
        .padding(.horizontal, scaledSpacing.m)
    }

    private func scaledRow(_ label: String, scaled: CGFloat, standard: CGFloat) -> some View {
        HStack(spacing: scaledSpacing.s) {
            Text(label)
                .font(.caption.monospaced())
                .frame(width: scaledSpacing.xxl, alignment: .leading)
            VStack(alignment: .leading, spacing: 2) {
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: scaled, height: 10)
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: standard, height: 10)
            }
            Text("\(Int(scaled.rounded())) / \(Int(standard)) pt")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview("Scaled Spacing") {
    HStack(alignment: .top, spacing: 32) {
        VStack(alignment: .leading) {
            Text("large")
                .font(.headline)
            ScaledSpacingExample()
        }
        .environment(\.dynamicTypeSize, .large)

        VStack(alignment: .leading) {
            Text("xxxLarge")
                .font(.headline)
            ScaledSpacingExample()
        }
        .environment(\.dynamicTypeSize, .xxxLarge)
    }
    .padding()
}

