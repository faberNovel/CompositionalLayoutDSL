//
//  CompositionalLayoutDSL.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 12/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

public struct CompositionalLayout {

    public typealias SectionProvider = (Int, NSCollectionLayoutEnvironment) -> LayoutSection?

    private let sectionBuilder: SectionProvider
    private let configuration: LayoutConfiguration

    public init(configuration: LayoutConfiguration = Configuration(),
                sectionsBuilder: @escaping SectionProvider) {
        self.sectionBuilder = sectionsBuilder
        self.configuration = configuration
    }

    public var collectionCompositionalLayout: UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout(
            sectionProvider: { section, environment in
                return sectionBuilder(section, environment).map(SectionBuilder.make(from:))
            },
            configuration: ConfigurationBuilder.make(from: configuration)
        )
    }
}

public extension CompositionalLayout {

    init(configuration: LayoutConfiguration = Configuration(),
         repeatingSections sectionsBuilder: [SectionProvider]) {
        self.init(configuration: configuration) { section, environment in
            guard !sectionsBuilder.isEmpty else { return nil }
            let sectionBuilder = sectionsBuilder[section % sectionsBuilder.count]
            return sectionBuilder(section, environment)
        }
    }
}
