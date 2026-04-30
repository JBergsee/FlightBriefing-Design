


import SwiftUI

// Typography scale
public enum Typography {
    public static let ofpHeader = Font.system(.headline, design: .monospaced)
    public static let smallLabel = Font.system(.caption, design: .monospaced)
    public static let ofpData = Font.system(.body, design: .monospaced)
    // Monospaced matters for your OFP/waypoint data alignment
}
#Preview("Typography Styles") {
    VStack(alignment: .leading, spacing: 20) {
        Text("OFP Header Style")
            .font(Typography.ofpHeader)
        
        Text("Small Label")
            .font(Typography.smallLabel)

        Text("OFP data")
            .font(Typography.ofpData)

        // Show comparison with standard fonts
        Divider()
        
        VStack(alignment: .leading, spacing: 8) {
            Text("Comparison:")
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Text("OFP Header: 123.45 ABC")
                .font(Typography.ofpHeader)
            
            Text("Headline: 123.45 ABC")
                .font(.headline)

            Text("OFP Data: 123.45 ABC")
                .font(Typography.ofpData)

            Text("Body: 123.45 ABC")
                .font(.body)

        }
    }
    .padding()
}

