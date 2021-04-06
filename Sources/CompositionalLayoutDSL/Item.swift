//
//  Item.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 06/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import Foundation
import UIKit

public protocol ContentInsetable {
    var contentInsets: NSDirectionalEdgeInsets { get set }
}

public protocol ItemProperties: ContentInsetable {
    var width: NSCollectionLayoutDimension { get set }
    var height: NSCollectionLayoutDimension { get set }
    var edgeSpacing: NSCollectionLayoutEdgeSpacing? { get set }
}

public extension ContentInsetable {
    func contentInsets(top: CGFloat = 0,
                       leading: CGFloat = 0,
                       bottom: CGFloat = 0,
                       trailing: CGFloat = 0) -> Self {
        return with(self) {
            $0.contentInsets = NSDirectionalEdgeInsets(
                top: top,
                leading: leading,
                bottom: bottom,
                trailing: trailing
            )
        }
    }

    func contentInsets(horizontal: CGFloat = 0,
                       vertical: CGFloat = 0) -> Self {
        return with(self) {
            $0.contentInsets = NSDirectionalEdgeInsets(
                top: vertical,
                leading: horizontal,
                bottom: vertical,
                trailing: horizontal
            )
        }
    }

    func contentInsets(value: CGFloat) -> Self {
        return with(self) {
            $0.contentInsets = NSDirectionalEdgeInsets(
                top: value,
                leading: value,
                bottom: value,
                trailing: value
            )
        }
    }

    func contentInsets(_ insets: NSDirectionalEdgeInsets) -> Self {
        return with(self) {
            $0.contentInsets = insets
        }
    }
}

public extension ItemProperties {

    var computedSize: NSCollectionLayoutSize {
        return NSCollectionLayoutSize(
            widthDimension: width,
            heightDimension: height
        )
    }

    func width(_ dimension: NSCollectionLayoutDimension) -> Self {
        return with(self) { $0.width = dimension }
    }

    func height(_ dimension: NSCollectionLayoutDimension) -> Self {
        return with(self) { $0.height = dimension }
    }

    func size(_ size: NSCollectionLayoutSize) -> Self {
        return width(size.widthDimension)
            .height(size.heightDimension)
    }

    func size(width: NSCollectionLayoutDimension, height: NSCollectionLayoutDimension) -> Self {
        return self.width(width).height(height)
    }

    func edgeSpacing(top: NSCollectionLayoutSpacing? = nil,
                     leading: NSCollectionLayoutSpacing? = nil,
                     bottom: NSCollectionLayoutSpacing? = nil,
                     trailing: NSCollectionLayoutSpacing? = nil) -> Self {
        return with(self) {
            $0.edgeSpacing = NSCollectionLayoutEdgeSpacing(
                leading: leading,
                top: top,
                trailing: trailing,
                bottom: bottom
            )
        }
    }

    func edgeSpacing(horizontal: NSCollectionLayoutSpacing? = nil,
                     vertical: NSCollectionLayoutSpacing? = nil) -> Self {
        return with(self) {
            $0.edgeSpacing = NSCollectionLayoutEdgeSpacing(
                leading: horizontal,
                top: vertical,
                trailing: horizontal,
                bottom: vertical
            )
        }
    }

    func edgeSpacing(value: NSCollectionLayoutSpacing? = nil) -> Self {
        return edgeSpacing(horizontal: value, vertical: value)
    }

    func edgeSpacing(_ spacing: NSCollectionLayoutEdgeSpacing?) -> Self {
        return with(self) {
            $0.edgeSpacing = spacing
        }
    }
}

public protocol LayoutItem: ItemProperties {
    func makeItem() -> NSCollectionLayoutItem
}

public struct Item: LayoutItem {

    public var width: NSCollectionLayoutDimension
    public var height: NSCollectionLayoutDimension
    public var contentInsets: NSDirectionalEdgeInsets = .zero
    public var edgeSpacing: NSCollectionLayoutEdgeSpacing?

    public init(width: NSCollectionLayoutDimension = .fractionalWidth(1.0),
                height: NSCollectionLayoutDimension = .fractionalHeight(1.0)) {
        self.width = width
        self.height = height
    }

    public init(size: NSCollectionLayoutSize) {
        self.width = size.widthDimension
        self.height = size.heightDimension
    }

    public func makeItem() -> NSCollectionLayoutItem {
        let size = NSCollectionLayoutSize(
            widthDimension: width,
            heightDimension: height
        )
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = contentInsets
        item.edgeSpacing = edgeSpacing
        return item
    }
}
