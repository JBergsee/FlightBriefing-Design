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
        Double(self).formatted(.number.precision(.fractionLength(0)))
    }
}

public extension BinaryInteger {
    func fuelValueFormatted() -> String {
        Int(self).formatted(.number.precision(.fractionLength(0)))
    }
}
