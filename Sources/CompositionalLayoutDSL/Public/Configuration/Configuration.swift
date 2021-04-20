//
//  CompositionalConfiguration.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 12/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

/// An object that defines scroll direction, section spacing, and headers or footers for the layout.
public struct Configuration: LayoutConfiguration {

    // MARK: - Life cycle

    public init() {}

    // MARK: - CompositionalLayoutConfiguration

    public var layoutConfiguration: LayoutConfiguration {
        return self
    }
}

extension Configuration: BuildableConfiguration {
    func makeConfiguration() -> UICollectionViewCompositionalLayoutConfiguration {
        return UICollectionViewCompositionalLayoutConfiguration()
    }
}
