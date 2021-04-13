//
//  CompositionalLayoutDSL.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 06/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import Foundation
import UIKit

// swiftlint:disable identifier_name

public func LayoutBuilder(
    configuration: CollectionLayoutConfigurationConvertible = CompositionalConfiguration(),
    closure: () -> CollectionLayoutSectionConvertible
) -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout(
        section: closure().collectionLayoutSection,
        configuration: configuration.collectionLayoutConfiguration
    )
}

public func SectionBuilder(closure: () -> LayoutSection) -> NSCollectionLayoutSection {
    closure().collectionLayoutSection
}
