//
//  DisclosureChevron.swift
//  FlightBriefing-Design
//
//  Created by Johan Bergsee on 2026-10-11.
//
//  The expand/collapse chevron (pointing right when collapsed, down when expanded) and a
//  button that pairs it with a label. Run the toggle in `withAnimation` so the rotation
//  animates together with the rows appearing or disappearing.
//

import SwiftUI

/// A disclosure chevron: points right when collapsed and rotates to point down when expanded.
public struct DisclosureChevron: View {
    let isExpanded: Bool

    public init(isExpanded: Bool) {
        self.isExpanded = isExpanded
    }

    public var body: some View {
        Image(systemName: "chevron.right")
            .rotationEffect(.degrees(isExpanded ? 90 : 0))
            .accessibilityHidden(true)
    }
}

/// A Show/Hide button: a ``DisclosureChevron`` followed by `label`, in the `.fbDefault` style.
///
/// The visible label can stay short (e.g. just a count), since the chevron carries the state.
/// VoiceOver gets "Show \(title)" / "Hide \(title)" as the label and `accessibilityValue` as the value.
public struct DisclosureToggleButton<Label: View>: View {
    let isExpanded: Bool
    let title: String
    let accessibilityValue: String
    let action: () -> Void
    let label: Label

    public init(isExpanded: Bool,
                title: String,
                accessibilityValue: String = "",
                action: @escaping () -> Void,
                @ViewBuilder label: () -> Label) {
        self.isExpanded = isExpanded
        self.title = title
        self.accessibilityValue = accessibilityValue
        self.action = action
        self.label = label()
    }

    public var body: some View {
        Button(action: action) {
            HStack(spacing: .s) {
                DisclosureChevron(isExpanded: isExpanded)
                label
            }
        }
        .buttonStyle(.fbDefault)
        .fixedSize()
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(isExpanded ? "Hide \(title)" : "Show \(title)")
        .accessibilityValue(accessibilityValue)
        .accessibilityAddTraits(.isButton)
    }
}

// MARK: - Previews

#Preview("Chevron") {
    HStack(spacing: .l) {
        DisclosureChevron(isExpanded: false)
        DisclosureChevron(isExpanded: true)
    }
    .imageScale(.large)
    .padding()
}

#Preview("Toggle button") {
    @Previewable @State var isExpanded = false
    DisclosureToggleButton(isExpanded: isExpanded, title: "Waypoints", accessibilityValue: "12") {
        withAnimation {
            isExpanded.toggle()
        }
    } label: {
        Text("Waypoints: 12")
    }
    .padding()
    .appTheme()
}
