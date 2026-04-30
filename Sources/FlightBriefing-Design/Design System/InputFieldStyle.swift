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
struct InputFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            // .padding(.horizontal, 4) // Maybe when we do the same in labels?
            .background(Color(.secondarySystemFill))
            .textFieldStyle(.plain) // removes the automatic border in some contexts
            .multilineTextAlignment(.trailing)
    }
}

/// Style alias so you can write: .textFieldStyle(.input)
extension TextFieldStyle where Self == InputFieldStyle {
    static var input: InputFieldStyle {
        InputFieldStyle()
    }
}

#Preview {
    @Previewable @State var text: String = "Text in TextField"
    VStack(alignment: .leading, spacing: 2) {
        Text("Text in Label Above")
            .padding(.horizontal, 4)
        TextField("Label Text", text: $text)
            .frame(width: 150)
            .textFieldStyle(.input)
        Text("Text in Label Below")
    }
    .frame(width: 300, height: 100)
}
