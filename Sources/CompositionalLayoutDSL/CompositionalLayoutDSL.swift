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

public func LayoutBuilder(configuration: UICollectionViewCompositionalLayoutConfiguration = .init(),
                          closure: () -> LayoutSection) -> UICollectionViewCompositionalLayout {
    let section = closure().collectionLayoutSection
    return UICollectionViewCompositionalLayout(section: section, configuration: configuration)
}

public func SectionBuilder(closure: () -> LayoutSection) -> NSCollectionLayoutSection {
    closure().collectionLayoutSection
}
