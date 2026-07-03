//
//  AppTheme.swift
//  FlightBriefing-Design
//
//  Created by Johan Bergsee on 2026-07-02.
//
//

import SwiftUI

// MARK: - SwiftUI-side global styling
/// Applies common styles on root views, to give a common appearance throughout the app.

struct AppTheme: ViewModifier {
    func body(content: Content) -> some View {
        content
        // General tint color
            .tint(Color(AppColor.accentColor))

        // Toggle switches
            .toggleStyle(SwitchToggleStyle(tint: Color(AppColor.companyColor)))

        // Buttons
            .buttonStyle(.fbDefault)


        // Examples:
//            .font(.system(.body, design: .rounded))
//            .environment(\.defaultMinListRowHeight, 52)
//            .dynamicTypeSize(...(.accessibility2))
    }
}

public extension View {
    /// Apply the app-wide theme. Attach exactly once, at the root.
    /// HOWEVER, this won't pass SwiftUI->UIKit boundary, so won't work appwide until all is descendant of the root.
    /// Meanwhile, apply to all swiftUI roots (UIHostingControllers)
    func appTheme() -> some View {
        modifier(AppTheme())
    }
}

/// Wraps a hosted SwiftUI root and applies the app theme.
/// Use for every `UIHostingController` root, since the theme applied at the
/// app root does not cross the SwiftUI -> UIKit boundary.
/// Exists because `UIHostingController`'s generic parameter requires a
/// concrete type, which `appTheme()`'s `some View` cannot provide.
public struct Themed<Content: View>: View {
    private let content: Content

    public init(_ content: Content) {
        self.content = content
    }

    public var body: some View {
        content.appTheme()
    }
}
