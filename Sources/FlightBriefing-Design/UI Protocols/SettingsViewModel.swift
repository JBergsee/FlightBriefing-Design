//
//  SettingsViewModel.swift
//  FlightBriefing-UI
//
//  Created by Johan Bergsee on 2026-04-22.
//  Copyright © 2026 Bergsee Aviation AB. All rights reserved.
//

import SwiftUI

// MARK: - SettingsAlertType

/// Alert cases used by SettingsView.
/// Standalone enum because Swift protocols cannot have nested types.
public enum SettingsAlertType: Identifiable {
    case invalidCompany(name: String)
    case confirmCompanyChange(newCompany: String)
    case confirmRemoveFlights
    case confirmResetDemo
    case noOPCFlights(company: String)
    case pendingSubmission(message: String)
    case mailUnavailable

    public var id: String {
        switch self {
        case .invalidCompany: return "invalidCompany"
        case .confirmCompanyChange: return "confirmCompanyChange"
        case .confirmRemoveFlights: return "confirmRemoveFlights"
        case .confirmResetDemo: return "confirmResetDemo"
        case .noOPCFlights: return "noOPCFlights"
        case .pendingSubmission: return "pendingSubmission"
        case .mailUnavailable: return "mailUnavailable"
        }
    }
}


// MARK: - CompanyPreset

#if DEBUG
/// Debug-only company preset for quick credential filling.
public struct CompanyPreset: Identifiable {
    public let id: String
    public let company: String
    public let user: String
    public let password: String

    public init(_ company: String, _ user: String, _ password: String) {
        self.id = company
        self.company = company
        self.user = user
        self.password = password
    }
}
#endif

// MARK: - SettingsViewModel (Protocol)

/// Abstracts the SettingsView's ViewModel so the view and its concrete
/// implementation can live in separate packages.
///
/// Conforming types must be `@Observable` classes (`AnyObject, Observable`),
/// which enables `@State` storage and `$`-binding projection in the generic
/// `SettingsView<ViewModel>`.
@MainActor
public protocol SettingsViewModel: AnyObject, Observable {

    // MARK: Bindable properties
    var company: String { get set }
    var userName: String { get set }
    var password: String { get set }
    var crewCode: String { get set }

    // MARK: Read-only
    var versionString: String { get }

    // MARK: Alert state
    var activeAlert: SettingsAlertType? { get set }

    // MARK: Debug presets
    var companyPresets: [CompanyPreset] { get }

    // MARK: Actions
    func done(dismiss: DismissAction)
    func cancel(dismiss: DismissAction)
    func confirmCompanyChange()
    func removeAllFlights(dismiss: DismissAction)
    func loadOPC(dismiss: DismissAction)
    func resetDemo()
    func applyTheme(_ theme: Theme)
    func fillCompanyPreset(_ preset: CompanyPreset)
    func showUserManual()
    func sendLogs()
    func resetFieldsFromDefaults()
}
