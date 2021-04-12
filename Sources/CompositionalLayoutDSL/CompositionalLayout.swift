//
//  CompositionalLayoutDSL.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 12/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

public struct CompositionalLayout {

    public typealias SectionBuilder = (Int, NSCollectionLayoutEnvironment) -> LayoutSection?

    private let sectionBuilder: SectionBuilder
    private let configuration: CompositionalLayoutConfiguration

    public init(configuration: CompositionalLayoutConfiguration = CompositionalConfiguration(),
                sectionsBuilder: @escaping SectionBuilder) {
        self.sectionBuilder = sectionsBuilder
        self.configuration = configuration
    }

    public var collectionCompositionalLayout: UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout(
            sectionProvider: { section, environment in
                return sectionBuilder(section, environment)?.collectionLayoutSection
            },
            configuration: configuration.collectionLayoutConfiguration
        )
    }
}

public extension CompositionalLayout {

    init(configuration: CompositionalLayoutConfiguration = CompositionalConfiguration(),
         repeatingSections sectionsBuilder: [SectionBuilder]) {
        self.init(configuration: configuration) { section, environment in
            guard !sectionsBuilder.isEmpty else { return nil }
            let sectionBuilder = sectionsBuilder[section % sectionsBuilder.count]
            return sectionBuilder(section, environment)
        }
    }
}
