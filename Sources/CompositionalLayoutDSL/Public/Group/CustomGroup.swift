//
//  CustomGroup.swift
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

/// A customizable container for a set of items.
public struct CustomGroup: LayoutGroup, ResizableItem {

    private var widthDimension: NSCollectionLayoutDimension
    private var heightDimension: NSCollectionLayoutDimension
    private let itemProvider: NSCollectionLayoutGroupCustomItemProvider

    // MARK: - Life cycle

    /// Creates a group of the specified size, with an item provider that creates a custom
    /// arrangement for those items.
    public init(width: NSCollectionLayoutDimension = .fractionalWidth(1),
                height: NSCollectionLayoutDimension = .fractionalHeight(1),
                itemProvider: @escaping NSCollectionLayoutGroupCustomItemProvider) {
        self.widthDimension = width
        self.heightDimension = height
        self.itemProvider = itemProvider
    }

    /// Creates a group of the specified size, with an item provider that creates a custom
    /// arrangement for those items.
    public init(size: NSCollectionLayoutSize,
                itemProvider: @escaping NSCollectionLayoutGroupCustomItemProvider) {
        self.widthDimension = size.widthDimension
        self.heightDimension = size.heightDimension
        self.itemProvider = itemProvider
    }

    /// Creates a group with an item provider that creates a custom arrangement for those items.
    public init(itemProvider: @escaping NSCollectionLayoutGroupCustomItemProvider) {
        self.init(width: .fractionalWidth(1), height: .fractionalHeight(1), itemProvider: itemProvider)
    }

    // MARK: - LayoutGroup

    public var layoutGroup: LayoutGroup {
        return self
    }

    // MARK: - ResizableItem

    /// Configure the width of the group
    ///
    /// The default value is `.fractionalWidth(1.0)`
    public func width(_ width: NSCollectionLayoutDimension) -> Self {
        with(self) { $0.widthDimension = width }
    }

    /// Configure the height of the group
    ///
    /// The default value is `.fractionalHeight(1.0)`
    public func height(_ height: NSCollectionLayoutDimension) -> Self {
        with(self) { $0.heightDimension = height }
    }
}

extension CustomGroup: BuildableGroup {
    func makeGroup() -> NSCollectionLayoutGroup {
        let size = NSCollectionLayoutSize(
            widthDimension: widthDimension,
            heightDimension: heightDimension
        )
        let group = NSCollectionLayoutGroup.custom(layoutSize: size, itemProvider: itemProvider)
        return group
    }
}
