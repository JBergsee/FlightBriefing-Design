//
//  Theme.swift
//  FlightBriefing-Foundation
//
//  Moved from main app target to enable use in UI packages.
//

import UIKit

public enum Theme: Int {
    case device
    case light
    case dark
}

extension Theme {
    public var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .device:
            return .unspecified
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}

extension UserDefaults {
    public var theme: Theme {
        get {
            register(defaults: [#function: Theme.device.rawValue])
            return Theme(rawValue: integer(forKey: #function)) ?? .device
        }
        set {
            set(newValue.rawValue, forKey: #function)
        }
    }
}
