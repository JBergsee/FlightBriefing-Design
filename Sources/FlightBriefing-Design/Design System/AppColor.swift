//
//  File.swift
//  
//
//  Created by Johan Nyman on 2022-05-12.
//

import Foundation
import UIKit

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
