//
//  AppStyler.swift
//  FlightBriefing
//
//  Created by Johan Nyman on 2015-02-11.
//  Copyright (c) 2015 JN Avionics. All rights reserved.
//
//  Rewritten from Objective-C to Swift.
//

import UIKit


// MARK: - AppStyler
/// Styling UIKit's appearance proxies, to give a common appearance throughout the app.

@MainActor
public struct AppStyler {

    // MARK: Public API

    public static func applyCompanyStyles() {

        // Background
        let mainColor = UIColor.systemBackground

        // Company color (ljusblå)
        var companyColor = AppColor.companyColor

        #if DEBUG
        //companyColor = .yellow
        #endif

        // Tint color (mörkblå)
        let accentColor = AppColor.accentColor

        // Title text color (på companycolor bakgrund)
        let titleTextColor = AppColor.titleColor

        // Title text shadow
        let titleTextShadow = NSShadow()
        titleTextShadow.shadowColor = accentColor
        titleTextShadow.shadowOffset = CGSize(width: 1.0, height: 1.0)

        // Title text attributes
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Arial", size: 17.0)!,
            .foregroundColor: titleTextColor,
            .shadow: titleTextShadow
        ]

        applyStyles(
            mainColor: mainColor,
            companyColor: companyColor,
            accentColor: accentColor,
            titleTextAttributes: titleTextAttributes
        )
    }

    public static func configureThemeFromDefaults() {
        let defaults = UserDefaults.standard
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.overrideUserInterfaceStyle = defaults.theme.userInterfaceStyle
    }


    // MARK: Private

    private static func applyStyles(
        mainColor: UIColor,
        companyColor: UIColor,
        accentColor: UIColor,
        titleTextAttributes: [NSAttributedString.Key: Any]
    ) {

        // Common bar appearance
        let barAppearance = UIBarAppearance()
        barAppearance.configureWithOpaqueBackground()
        barAppearance.backgroundColor = companyColor
        barAppearance.shadowColor = accentColor

        let navBarAppearanceClass = UINavigationBarAppearance(barAppearance: barAppearance)
        navBarAppearanceClass.titleTextAttributes = titleTextAttributes

        // NavigationBars
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.standardAppearance = navBarAppearanceClass
        navBarAppearance.compactAppearance = navBarAppearanceClass
        navBarAppearance.scrollEdgeAppearance = navBarAppearanceClass


        // Tool bars
        let toolbarAppearance = UIToolbar.appearance()
        toolbarAppearance.backgroundColor = companyColor
        toolbarAppearance.tintColor = companyColor
        toolbarAppearance.barTintColor = companyColor
        toolbarAppearance.isTranslucent = false


        // Buttons
        let buttonAppearance = UIButton.appearance()
        buttonAppearance.tintColor = accentColor
        buttonAppearance.setTitleColor(accentColor, for: .normal)

        // BarButtons
        let barButtonAppearance = UIBarButtonItem.appearance()
        barButtonAppearance.tintColor = accentColor

        // Text in UIMenuControls
        // Since the background is dark, it should always be the one for dark mode.
        if let calloutBarButtonClass = NSClassFromString("UICalloutBarButton") as? UIButton.Type {
            let calloutAppearance = calloutBarButtonClass.appearance()
            calloutAppearance.setTitleColor(companyColor, for: .normal)
        }


        // SegmentedControl
        let segmentedControlAppearance = UISegmentedControl.appearance()
        segmentedControlAppearance.backgroundColor = companyColor.withAlphaComponent(0.5)
        segmentedControlAppearance.selectedSegmentTintColor = accentColor

        // Normal state text
        segmentedControlAppearance.setTitleTextAttributes(
            [.foregroundColor: accentColor],
            for: .normal
        )
        // Selected state text
        segmentedControlAppearance.setTitleTextAttributes(
            [.foregroundColor: companyColor],
            for: .selected
        )


        // Slider
        let sliderAppearance = UISlider.appearance()
        sliderAppearance.minimumTrackTintColor = companyColor
        // Bug in UIImagePickerController, so both min and max tint color cannot be used.
        // FIXME: Remove comment when bug fixed by Apple
        // sliderAppearance.maximumTrackTintColor = accentColor
        sliderAppearance.thumbTintColor = companyColor


        // Switch
        let switchAppearance = UISwitch.appearance()
        switchAppearance.onTintColor = companyColor
        switchAppearance.thumbTintColor = accentColor


        // Progress bar
        let progressAppearance = UIProgressView.appearance()
        progressAppearance.trackTintColor = accentColor
        progressAppearance.progressTintColor = companyColor


        // PageControl
        let pageControlAppearance = UIPageControl.appearance()
        pageControlAppearance.currentPageIndicatorTintColor = companyColor
        pageControlAppearance.pageIndicatorTintColor = accentColor


        // Refresh control
        let refreshAppearance = UIRefreshControl.appearance()
        refreshAppearance.tintColor = accentColor


        // UITableView
        // Fix for iOS 15 where an extra space is added to the height of each sectionheader
        UITableView.appearance().sectionHeaderTopPadding = 0

        let tableViewAppearance = UITableView.appearance()
        tableViewAppearance.tintColor = companyColor
        tableViewAppearance.separatorColor = companyColor
        tableViewAppearance.separatorStyle = .singleLine

        let cellAppearance = UITableViewCell.appearance()
        cellAppearance.selectionStyle = .none // Default makes the separator disappear...

        // Labels in tableViewHeaders and Footers
        let labelInHeaderAppearance = UILabel.appearance(
            whenContainedInInstancesOf: [UITableViewHeaderFooterView.self]
        )
        labelInHeaderAppearance.textColor = accentColor

        // Images in tableViewHeaders and Footers
        let imageInHeaderAppearance = UIImageView.appearance(
            whenContainedInInstancesOf: [UITableViewHeaderFooterView.self]
        )
        imageInHeaderAppearance.tintColor = accentColor
    }
}
