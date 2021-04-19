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

struct ValueModifiedLayoutSection: LayoutSection, BuildableSection {
    let section: LayoutSection
    let valueModifier: (inout NSCollectionLayoutSection) -> Void

    var layoutSection: LayoutSection { self }

    func makeSection() -> NSCollectionLayoutSection {
        var collectionLayoutSection = SectionBuilder.make(from: section)
        valueModifier(&collectionLayoutSection)
        return collectionLayoutSection
    }
}

extension LayoutSection {
    func modifier(_ modifier: BuildableLayoutSectionModifier) -> LayoutSection {
        ModifiedLayoutSection(section: self, modifier: modifier)
    }

    func valueModifier<T>(_ value: T, keyPath: WritableKeyPath<NSCollectionLayoutSection, T>) -> LayoutSection {
        ValueModifiedLayoutSection(section: self) { $0[keyPath: keyPath] = value }
    }

    func valueModifier(
        modifier: @escaping (inout NSCollectionLayoutSection) -> Void
    ) -> LayoutSection {
        ValueModifiedLayoutSection(section: self, valueModifier: modifier)
    }
}