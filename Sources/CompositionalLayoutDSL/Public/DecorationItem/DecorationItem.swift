//
//  DecorationItem.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

#if os(macOS)
import AppKit
#else
import UIKit
#endif

/// An object used to add a background to a section of a collection view.
public struct DecorationItem: LayoutDecorationItem {

    private var elementKind: String

    // MARK: - Life cycle

    public init(elementKind: String) {
        self.elementKind = elementKind
    }

    // MARK: - LayoutDecorationItem

    public var layoutDecorationItem: LayoutDecorationItem {
        return self
    }
}

extension DecorationItem: BuildableDecorationItem {
    func makeDecorationItem() -> NSCollectionLayoutDecorationItem {
        let decorationItem = NSCollectionLayoutDecorationItem.background(elementKind: elementKind)
        return decorationItem
    }
}
