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

/// Converts a layout configuration and a layout section into a `UICollectionViewCompositionalLayout`
public func LayoutBuilder(
    configuration: LayoutConfiguration = Configuration(),
    closure: () -> LayoutSection
) -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout(
        section: SectionBuilder.make(from: closure()),
        configuration: ConfigurationBuilder.make(from: configuration)
    )
}

/// Converts a layout section into a `NSCollectionLayoutSection`
public func LayoutSectionBuilder(closure: () -> LayoutSection) -> NSCollectionLayoutSection {
    SectionBuilder.make(from: closure())
}
