//
//  ConfigurationBuilder.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 19/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

#if os(macOS)
import AppKit
#else
import UIKit
#endif

internal protocol BuildableConfiguration {
    func makeConfiguration() -> ConfigurationBuilder.TransformedType
}

internal enum ConfigurationBuilder {

    #if os(macOS)
    typealias TransformedType = NSCollectionViewCompositionalLayoutConfiguration
    #else
    typealias TransformedType = UICollectionViewCompositionalLayoutConfiguration
    #endif

    static func make(
        from layoutConfiguration: LayoutConfiguration
    ) -> ConfigurationBuilder.TransformedType {
        guard let buildableConfiguration = getBuildableConfiguration(from: layoutConfiguration) else {
            // swiftlint:disable:next line_length
            fatalError("Unable to convert the given LayoutConfiguration to UICollectionViewCompositionalLayoutConfiguration")
        }
        return buildableConfiguration.makeConfiguration()
    }

    private static func getBuildableConfiguration(
        from layoutConfiguration: LayoutConfiguration
    ) -> BuildableConfiguration? {
        var currentConfiguration = layoutConfiguration
        while !(currentConfiguration is BuildableConfiguration) {
            currentConfiguration = currentConfiguration.layoutConfiguration
        }
        return currentConfiguration as? BuildableConfiguration
    }
}
