//
//  SectionWithEnvironmentInsets.swift
//  CompositionalLayoutDSL_Example_iOS
//
//  Created by Alexandre Podlewski on 09/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit
import CompositionalLayoutDSL

struct SectionWithEnvironmentInsets: LayoutSection {

    let insets: NSDirectionalEdgeInsets
    let baseSection: LayoutSection

    init(insets: NSDirectionalEdgeInsets,
         environment: NSCollectionLayoutEnvironment,
         baseSection: (NSCollectionLayoutEnvironment) -> LayoutSection) {
        self.insets = insets
        self.baseSection = baseSection(
            CustomCollectionLayoutEnvironment(
                from: environment,
                withAdditionalInsets: insets
            )
        )
    }

    // MARK: - LayoutSection

    var layoutSection: LayoutSection {
        baseSection.contentInsets(insets)
    }
}

private class CustomCollectionLayoutEnvironment: NSObject, NSCollectionLayoutEnvironment {

    let container: NSCollectionLayoutContainer
    let traitCollection: UITraitCollection

    init(container: NSCollectionLayoutContainer,
         traitCollection: UITraitCollection,
         withAdditionalInsets insets: NSDirectionalEdgeInsets) {
        self.container = CustomCollectionLayoutContainer(from: container, withAdditionalInsets: insets)
        self.traitCollection = traitCollection
    }

    convenience init(from collectionLayoutEnvironment: NSCollectionLayoutEnvironment,
                     withAdditionalInsets insets: NSDirectionalEdgeInsets) {
        self.init(
            container: collectionLayoutEnvironment.container,
            traitCollection: collectionLayoutEnvironment.traitCollection,
            withAdditionalInsets: insets
        )
    }
}

private class CustomCollectionLayoutContainer: NSObject, NSCollectionLayoutContainer {
    let contentSize: CGSize
    let effectiveContentSize: CGSize
    let contentInsets: NSDirectionalEdgeInsets
    let effectiveContentInsets: NSDirectionalEdgeInsets

    init(contentSize: CGSize,
         effectiveContentSize: CGSize,
         contentInsets: NSDirectionalEdgeInsets,
         effectiveContentInsets: NSDirectionalEdgeInsets,
         withAdditionalInsets insets: NSDirectionalEdgeInsets = .zero) {
        self.contentSize = contentSize
        self.effectiveContentSize = effectiveContentSize.inseted(by: insets)
        self.contentInsets = contentInsets.adding(insets)
        self.effectiveContentInsets = effectiveContentInsets.adding(insets)
    }

    convenience init(from collectionLayoutContainer: NSCollectionLayoutContainer,
                     withAdditionalInsets insets: NSDirectionalEdgeInsets) {
        self.init(
            contentSize: collectionLayoutContainer.contentSize,
            effectiveContentSize: collectionLayoutContainer.effectiveContentSize,
            contentInsets: collectionLayoutContainer.contentInsets,
            effectiveContentInsets: collectionLayoutContainer.effectiveContentInsets,
            withAdditionalInsets: insets
        )
    }
}

private extension NSDirectionalEdgeInsets {
    func adding(_ insets: NSDirectionalEdgeInsets) -> NSDirectionalEdgeInsets {
        var copy = self
        copy.trailing += insets.trailing
        copy.leading += insets.leading
        copy.bottom += insets.bottom
        copy.top += insets.top
        return copy
    }
}

private extension CGSize {
    func inseted(by insets: NSDirectionalEdgeInsets) -> CGSize {
        var copy = self
        copy.width = max(0, width - insets.leading - insets.trailing)
        copy.height = max(0, height - insets.top - insets.bottom)
        return copy
    }
}
