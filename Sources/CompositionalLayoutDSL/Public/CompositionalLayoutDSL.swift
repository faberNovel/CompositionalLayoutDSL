//
//  CompositionalLayoutDSL.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 06/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

#if os(macOS)
import AppKit
#else
import UIKit
#endif

// swiftlint:disable identifier_name

/// Converts a layout section into a `NSCollectionLayoutSection`
public func LayoutSectionBuilder(
    closure: () -> LayoutSection
) -> NSCollectionLayoutSection {
    SectionBuilder.make(from: closure())
}

#if os(macOS)
/// Converts a layout configuration and a layout section into an `NSCollectionViewCompositionalLayout`
public func LayoutBuilder(
    configuration: LayoutConfiguration = Configuration(),
    closure: () -> LayoutSection
) -> NSCollectionViewCompositionalLayout {
    return NSCollectionViewCompositionalLayout(
        section: SectionBuilder.make(from: closure()),
        configuration: ConfigurationBuilder.make(from: configuration)
    )
}
#else
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
#endif

#if os(macOS)
/// Converts a compositionalLayout into an `NSCollectionViewCompositionalLayout`
public func CompositionalLayoutBuilder(
    closure: () -> CompositionalLayout
) -> NSCollectionViewCompositionalLayout {
    closure().makeCollectionViewCompositionalLayout()
}
#else
/// Converts a compositionalLayout into a `UICollectionViewCompositionalLayout`
public func CompositionalLayoutBuilder(
    closure: () -> CompositionalLayout
) -> UICollectionViewCompositionalLayout {
    closure().makeCollectionViewCompositionalLayout()
}
#endif

#if os(macOS)
extension NSCollectionView {
    /// Configure a UICollectionView layout with a CompositionalLayout
    public func setCollectionViewLayout(
        _ layout: CompositionalLayout
    ) {
        self.collectionViewLayout = CompositionalLayoutBuilder { layout }
    }
}
#else
extension UICollectionView {
    /// Configure a UICollectionView layout with a CompositionalLayout
    public func setCollectionViewLayout(
        _ layout: CompositionalLayout,
        animated: Bool,
        completion: ((Bool) -> Void)? = nil
    ) {
        self.setCollectionViewLayout(
            CompositionalLayoutBuilder { layout },
            animated: animated,
            completion: completion
        )
    }
}
#endif
