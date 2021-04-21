//
//  SectionBuilder.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 19/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

internal protocol BuildableSection {
    func makeSection() -> NSCollectionLayoutSection
}

internal enum SectionBuilder {
    static func make(from layoutSection: LayoutSection) -> NSCollectionLayoutSection {
        guard let buildableSection = getBuildableSection(from: layoutSection) else {
            fatalError("Unable to convert the given LayoutSection to NSCollectionLayoutSection")
        }
        return buildableSection.makeSection()
    }

    private static func getBuildableSection(from layoutSection: LayoutSection) -> BuildableSection? {
        var currentSection = layoutSection
        while !(currentSection is BuildableSection) {
            currentSection = currentSection.layoutSection
        }
        return currentSection as? BuildableSection
    }
}
