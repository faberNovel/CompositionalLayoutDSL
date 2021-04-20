//
//  CompositionalLayoutDSL.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 12/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

/// An object that completely represent a compositional layout.
///
/// You can create a fully configured layout like showed in the example below
///
///      let compositionalLayout = CompositionalLayout { (_, _) in
///          Section {
///              VGroup { Item() }
///                  .width(.fractionalWidth(1/3))
///                  .interItemSpacing(.fixed(8))
///          }
///          .interGroupSpacing(8)
///          .contentInsets(horizontal: 20)
///      }
///      .interSectionSpacing(16)
///      .boundarySupplementaryItems {
///          BoundarySupplementaryItem(elementKind: "globalHeader")
///              .alignment(.top)
///      }
///
public struct CompositionalLayout {

    public typealias SectionProvider = (Int, NSCollectionLayoutEnvironment) -> LayoutSection?

    private let sectionBuilder: SectionProvider
    private var configuration: LayoutConfiguration

    // MARK: - Life cycle

    public init(configuration: LayoutConfiguration = Configuration(),
                sectionsBuilder: @escaping SectionProvider) {
        self.sectionBuilder = sectionsBuilder
        self.configuration = configuration
    }

    // MARK: - CompositionalLayout

    /// Configure the axis that the content in the collection view layout scrolls along.
    ///
    /// The default value of this property is `UICollectionView.ScrollDirection.vertical`.
    public func scrollDirection(
        _ scrollDirection: UICollectionView.ScrollDirection
    ) -> Self {
        with(self) { $0.configuration = $0.configuration.scrollDirection(scrollDirection) }
    }

    /// Configure the amount of space between the sections in the layout.
    ///
    /// The default value of this property is `0.0`.
    public func interSectionSpacing(_ interSectionSpacing: CGFloat) -> Self {
        with(self) { $0.configuration = $0.configuration.interSectionSpacing(interSectionSpacing) }
    }

    /// Add an array of the supplementary items that are associated with the boundary edges
    /// of the entire layout, such as global headers and footers.
    public func boundarySupplementaryItems(
        @LayoutBoundarySupplementaryItemBuilder
        _ boundarySupplementaryItems: () -> [LayoutBoundarySupplementaryItem]
    ) -> Self {
        with(self) {
            $0.configuration = $0.configuration.boundarySupplementaryItems(boundarySupplementaryItems)
        }
    }

    /// Configure the boundary to reference when defining content insets.
    ///
    /// The default value of this property is ``UIContentInsetsReference.safeArea``
    @available(iOS 14.0, tvOS 14.0, *)
    public func contentInsetsReference(
        _ contentInsetsReference: UIContentInsetsReference
    ) -> Self {
        with(self) {
            $0.configuration = $0.configuration.contentInsetsReference(contentInsetsReference)
        }
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
