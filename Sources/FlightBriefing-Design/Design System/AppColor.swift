//
//  File.swift
//  
//
//  Created by Johan Nyman on 2022-05-12.
//

import Foundation
import UIKit
import SwiftUI

public struct AppColor {
    
    //Company colors
    public static var companyColor: UIColor { UIColor(named: "MainColor") ?? .systemBlue }
    public static var accentColor: UIColor { UIColor(named: "AccentColor") ?? .systemRed }
    public static var titleColor: UIColor { UIColor(named: "TitleColor") ?? .systemGreen }

    //Common colors
    private static func bundleColor(_ name: String) -> UIColor {
        UIColor(named: name, in: Bundle.module, compatibleWith: nil) ?? UIColor.systemRed
    }
    
    public static var moduleBG: UIColor { bundleColor("ModuleBGColor") }
    public static var moduleText: UIColor { bundleColor("ModuleTextColor") }
    public static var nightModeMask: UIColor { bundleColor("Nightmodemask") }
    public static var bgOK: UIColor { bundleColor("BGOK") }
    public static var bgWarning: UIColor { bundleColor("BGWarning") }
    public static var bgAttention: UIColor { bundleColor("BGAttention") }
    public static var bgDiscard: UIColor { bundleColor("BGDiscard") }
    public static var ok: UIColor { bundleColor("OK") }
    public static var warning: UIColor { bundleColor("Warning") }
    public static var attention: UIColor { bundleColor("Attention") }
    public static var fuelCheckPerformed: UIColor { bundleColor("FuelCheckPerformed") }
}

#Preview("Company Colors") {
    VStack(spacing: 16) {
        colorSwatch("Company Color", color: AppColor.companyColor)
        colorSwatch("Accent Color", color: AppColor.accentColor)
        colorSwatch("Title Color", color: AppColor.titleColor)
    }
    .padding()
}

#Preview("Module Colors") {
    VStack(spacing: 16) {
        colorSwatch("Module BG", color: AppColor.moduleBG)
        colorSwatch("Module Text", color: AppColor.moduleText)
        colorSwatch("Night Mode Mask", color: AppColor.nightModeMask)
    }
    .padding()
}

#Preview("Status Colors") {
    VStack(spacing: 16) {
        Text("Background Colors")
            .font(.headline)
        
        colorSwatch("BG OK", color: AppColor.bgOK)
        colorSwatch("BG Warning", color: AppColor.bgWarning)
        colorSwatch("BG Attention", color: AppColor.bgAttention)
        colorSwatch("BG Discard", color: AppColor.bgDiscard)
        
        Divider()
        
        Text("Foreground Colors")
            .font(.headline)
        
        colorSwatch("OK", color: AppColor.ok)
        colorSwatch("Warning", color: AppColor.warning)
        colorSwatch("Attention", color: AppColor.attention)
        colorSwatch("Fuel Check Performed", color: AppColor.fuelCheckPerformed)
    }
    .padding()
}

@ViewBuilder
private func colorSwatch(_ name: String, color: UIColor) -> some View {
    HStack {
        Text(name)
            .frame(maxWidth: .infinity, alignment: .leading)
        
        RoundedRectangle(cornerRadius: 8)
            .fill(Color(uiColor: color))
            .frame(width: 60, height: 40)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.primary.opacity(0.2), lineWidth: 1)
            }
    }
}

