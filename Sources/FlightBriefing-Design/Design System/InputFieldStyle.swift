//
//  InputFieldStyle.swift
//  Design
//
//  Created by Johan Bergsee on 2025-10-21.
//  
//

import SwiftUI

/// A compact, borderless text field style with a subtle background fill,
/// intended to visually match the original UIKit field (19pt tall).
public struct InputFieldStyle: TextFieldStyle {
    // Trailing text by default, can be overridden at call site
    var alignment: TextAlignment = .trailing

    public func _body(configuration: TextField<_Label>) -> some View {
        configuration
            // .padding(.horizontal, 4) // Maybe when we do the same in labels?
            .background(Color(.secondarySystemFill))
            .textFieldStyle(.plain) // removes the automatic border in some contexts
            .multilineTextAlignment(alignment)
    }
}

/// Style alias so you can write: .textFieldStyle(.input)
public extension TextFieldStyle where Self == InputFieldStyle {
    static var input: InputFieldStyle {
        InputFieldStyle()
    }
    static func input(alignment: TextAlignment) -> InputFieldStyle {
        InputFieldStyle(alignment: alignment)
    }
}

#Preview {
    @Previewable @State var text: String = "Text in TextField"
    VStack(alignment: .leading, spacing: 2) {
        Text("Text in Label Above")
            .padding(.horizontal, 4)
        TextField("Trailing,  standard", text: $text)
            .frame(width: 150)
            .textFieldStyle(.input)
        Text("Text in Label Below")
        TextField("Leading,  overriden", text: $text)
            .frame(width: 150)
            .textFieldStyle(.input(alignment: .leading))
    }
    .frame(width: 300, height: 100)
}
