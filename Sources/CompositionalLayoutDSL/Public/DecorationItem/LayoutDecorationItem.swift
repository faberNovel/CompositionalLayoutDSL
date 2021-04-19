//
//  LayoutDecorationItem.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

public protocol LayoutDecorationItem: LayoutItem {
    var layoutDecorationItem: LayoutDecorationItem { get }
}

public extension LayoutDecorationItem {

    // MARK: - LayoutItem

    var layoutItem: LayoutItem { self }
}

extension LayoutDecorationItem {

    // MARK: - Decoration Item mutable properties

    public func zIndex(zIndex: Int) -> LayoutDecorationItem {
        valueModifier(zIndex, keyPath: \.zIndex)
    }
}

extension LayoutDecorationItem {

    // MARK: - Content Insets

    public func contentInsets(value: CGFloat) -> LayoutDecorationItem {
        return contentInsets(top: value, leading: value, bottom: value, trailing: value)
    }

    public func contentInsets(horizontal: CGFloat = 0, vertical: CGFloat = 0) -> LayoutDecorationItem {
        return contentInsets(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    public func contentInsets(
        top: CGFloat = 0,
        leading: CGFloat = 0,
        bottom: CGFloat = 0,
        trailing: CGFloat = 0
    ) -> LayoutDecorationItem {
        contentInsets(NSDirectionalEdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing))
    }

    public func contentInsets(_ insets: NSDirectionalEdgeInsets) -> LayoutDecorationItem {
        valueModifier(insets, keyPath: \.contentInsets)
    }
}

extension LayoutDecorationItem {

    // MARK: - Edge Spacing

    public func edgeSpacing(value: NSCollectionLayoutSpacing?) -> LayoutDecorationItem {
        return edgeSpacing(top: value, leading: value, bottom: value, trailing: value)
    }

    public func edgeSpacing(
        horizontal: NSCollectionLayoutSpacing? = nil,
        vertical: NSCollectionLayoutSpacing? = nil
    ) -> LayoutDecorationItem {
        return edgeSpacing(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    public func edgeSpacing(
        top: NSCollectionLayoutSpacing? = nil,
        leading: NSCollectionLayoutSpacing? = nil,
        bottom: NSCollectionLayoutSpacing? = nil,
        trailing: NSCollectionLayoutSpacing? = nil
    ) -> LayoutDecorationItem {
        edgeSpacing(
            NSCollectionLayoutEdgeSpacing(leading: leading, top: top, trailing: trailing, bottom: bottom)
        )
    }

    public func edgeSpacing(_ edgeSpacing: NSCollectionLayoutEdgeSpacing) -> LayoutDecorationItem {
        valueModifier(edgeSpacing, keyPath: \.edgeSpacing)
    }
}
