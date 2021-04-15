//
//  DecorationItem.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

public struct DecorationItem: LayoutDecorationItem {

    internal var widthDimension: NSCollectionLayoutDimension = .fractionalWidth(1)
    internal var heightDimension: NSCollectionLayoutDimension = .fractionalHeight(1)
    internal var contentInsets: NSDirectionalEdgeInsets = .zero
    internal var edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: nil, trailing: nil, bottom: nil)
    internal var zIndex: Int = 0
    private var elementKind: String

    // MARK: - Life cycle

    public init(elementKind: String) {
        self.elementKind = elementKind
    }

    // MARK: - LayoutDecorationItem

    public var layoutDecorationItem: LayoutDecorationItem {
        return self
    }

    public func _makeDecorationItem() -> NSCollectionLayoutDecorationItem {
        let decorationItem = NSCollectionLayoutDecorationItem.background(elementKind: elementKind)
        decorationItem.apply(decorationPropertiesFrom: self)
        return decorationItem
    }
}

extension DecorationItem: HasDecorationItemProperties {}
