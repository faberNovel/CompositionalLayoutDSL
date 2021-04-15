//
//  CompositionalConfiguration.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 12/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

public struct CompositionalConfiguration: CompositionalLayoutConfiguration {

    internal var scrollDirection: UICollectionView.ScrollDirection = .vertical
    internal var interSectionSpacing: CGFloat = 0
    internal var boundarySupplementaryItems: [LayoutBoundarySupplementaryItem] = []
//    @available(iOS 14.0, *)
//    internal var contentInsetsReference: UIContentInsetsReference { get set }

    // MARK: - Life cycle

    public init() {}

    // MARK: - CompositionalLayoutConfiguration

    public var layoutConfiguration: CompositionalLayoutConfiguration {
        return self
    }

    public func makeConfiguration() -> UICollectionViewCompositionalLayoutConfiguration {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.apply(configurationPropertiesFrom: self)
        return configuration
    }
}
extension CompositionalConfiguration: HasConfigurationProperties {}
