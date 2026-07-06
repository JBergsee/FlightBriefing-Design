//
//  Formatting.swift
//  FlightBriefing-Design
//
//  Created by Johan Bergsee on 2026-06-08.
//  
//


import SwiftUI

// MARK: - Fuel value formatting

public extension BinaryFloatingPoint {
    func fuelValueFormatted() -> String {
        String(format:"%.0f", Double(self))
        // Ideally: Double(self).formatted(.number.precision(.fractionLength(0)))
    }
}

public extension BinaryInteger {
    func fuelValueFormatted() -> String {
        String(format:"%.0f", Double(self))
        // Ideally: Int(self).formatted(.number.precision(.fractionLength(0)))
    }
}
