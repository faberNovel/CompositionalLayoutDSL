//
//  CompositionalConfiguration.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 12/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

public struct Configuration: LayoutConfiguration {

    internal var scrollDirection: UICollectionView.ScrollDirection = .vertical
    internal var interSectionSpacing: CGFloat = 0
    internal var boundarySupplementaryItems: [LayoutBoundarySupplementaryItem] = []
//    @available(iOS 14.0, *)
//    internal var contentInsetsReference: UIContentInsetsReference { get set }

    // MARK: - Life cycle

    public init() {}

    // MARK: - CompositionalLayoutConfiguration

    public var layoutConfiguration: LayoutConfiguration {
        return self
    }

    public func _makeConfiguration() -> UICollectionViewCompositionalLayoutConfiguration {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.apply(configurationPropertiesFrom: self)
        return configuration
    }
}
extension Configuration: HasConfigurationProperties {}
