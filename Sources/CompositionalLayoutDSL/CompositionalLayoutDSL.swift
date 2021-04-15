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
    configuration: LayoutConfiguration = Configuration(),
    closure: () -> LayoutSection
) -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout(
        section: closure().makeLayoutSection(),
        configuration: configuration.makeConfiguration()
    )
}

public func SectionBuilder(closure: () -> LayoutSection) -> NSCollectionLayoutSection {
    closure().makeLayoutSection()
}
