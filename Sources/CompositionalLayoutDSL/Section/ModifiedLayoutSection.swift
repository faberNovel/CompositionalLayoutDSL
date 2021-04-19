//
//  ModifiedLayoutSection.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 19/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

protocol BuildableLayoutSectionModifier {
    func collectionLayoutSection(layoutSection: LayoutSection) -> NSCollectionLayoutSection
}

struct ModifiedLayoutSection: LayoutSection, BuildableSection {
    let section: LayoutSection
    let modifier: BuildableLayoutSectionModifier

    var layoutSection: LayoutSection { self }

    func makeSection() -> NSCollectionLayoutSection {
        return modifier.collectionLayoutSection(layoutSection: section)
    }
}

extension LayoutSection {
    func modifier(_ modifier: BuildableLayoutSectionModifier) -> LayoutSection {
        ModifiedLayoutSection(section: self, modifier: modifier)
    }
}
