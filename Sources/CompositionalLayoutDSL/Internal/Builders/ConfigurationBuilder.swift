//
//  ConfigurationBuilder.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 19/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

internal protocol BuildableConfiguration {
    func makeConfiguration() -> UICollectionViewCompositionalLayoutConfiguration
}

internal enum ConfigurationBuilder {
    static func make(
        from layoutConfiguration: LayoutConfiguration
    ) -> UICollectionViewCompositionalLayoutConfiguration {
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
