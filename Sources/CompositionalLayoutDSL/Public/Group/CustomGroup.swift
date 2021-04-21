//
//  CustomGroup.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

public struct CustomGroup: LayoutGroup, ResizableItem {

    private var widthDimension: NSCollectionLayoutDimension
    private var heightDimension: NSCollectionLayoutDimension
    private let itemProvider: NSCollectionLayoutGroupCustomItemProvider

    // MARK: - Life cycle

    public init(width: NSCollectionLayoutDimension = .fractionalWidth(1),
                height: NSCollectionLayoutDimension = .fractionalHeight(1),
                itemProvider: @escaping NSCollectionLayoutGroupCustomItemProvider) {
        self.widthDimension = width
        self.heightDimension = height
        self.itemProvider = itemProvider
    }

    public init(size: NSCollectionLayoutSize,
                itemProvider: @escaping NSCollectionLayoutGroupCustomItemProvider) {
        self.widthDimension = size.widthDimension
        self.heightDimension = size.heightDimension
        self.itemProvider = itemProvider
    }

    public init(itemProvider: @escaping NSCollectionLayoutGroupCustomItemProvider) {
        self.init(width: .fractionalWidth(1), height: .fractionalHeight(1), itemProvider: itemProvider)
    }

    // MARK: - LayoutGroup

    public var layoutGroup: LayoutGroup {
        return self
    }

    // MARK: - ResizableItem

    public func width(_ width: NSCollectionLayoutDimension) -> Self {
        with(self) { $0.widthDimension = width }
    }

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
