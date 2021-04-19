//
//  FractalGroup.swift
//  CompositionalLayoutDSL_Example_iOS
//
//  Created by Alexandre Podlewski on 09/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit
import CompositionalLayoutDSL

struct FractalGroup: LayoutGroup, ResizableItem {

    var ratio: CGFloat
    var depth: Int
    var insets: CGFloat

    var heightDimension: NSCollectionLayoutDimension = .fractionalHeight(1)
    var widthDimension: NSCollectionLayoutDimension = .fractionalWidth(1)

    internal init(ratio: CGFloat, depth: Int, insets: CGFloat = 8) {
        self.ratio = ratio
        self.depth = depth
        self.insets = insets
    }

    // MARK: - LayoutGroup

    var layoutGroup: LayoutGroup {
        let otherRatio = 1 - ratio

        guard depth > 0 else {
            return HGroup { Item().contentInsets(value: insets) }
                .height(heightDimension)
                .width(widthDimension)
        }
        return HGroup(width: widthDimension, height: heightDimension) {
            Item(width: .fractionalWidth(ratio)).contentInsets(value: insets)
            VGroup(width: .fractionalWidth(otherRatio)) {
                Item(height: .fractionalHeight(ratio)).contentInsets(value: insets)
                HGroup(height: .fractionalHeight(otherRatio)) {
                    VGroup(width: .fractionalWidth(otherRatio)) {
                        FractalGroup(ratio: ratio, depth: depth - 1, insets: insets)
                            .height(.fractionalHeight(otherRatio))
                        Item(height: .fractionalHeight(ratio))
                            .contentInsets(value: insets)
                    }
                    Item(width: .fractionalWidth(ratio)).contentInsets(value: insets)
                }
            }
        }
    }

    func width(_ width: NSCollectionLayoutDimension) -> Self {
        var copy = self
        copy.widthDimension = width
        return copy
    }

    func height(_ height: NSCollectionLayoutDimension) -> Self {
        var copy = self
        copy.heightDimension = height
        return copy
    }
}

// Same layout with only UIKit APIs

struct TraditionalFractalGroup {

    var ratio: CGFloat
    var depth: Int
    var insets: CGFloat = 8
    var heightDimension: NSCollectionLayoutDimension = .fractionalHeight(1)
    var widthDimension: NSCollectionLayoutDimension = .fractionalWidth(1)

    // MARK: - TraditionalFractalGroup

    var layoutGroup: NSCollectionLayoutGroup {
        return fractalLayoutGroup(depth: depth, height: heightDimension)
    }

    // MARK: - Private

    // swiftlint:disable:next function_body_length
    private func fractalLayoutGroup(depth: Int, height: NSCollectionLayoutDimension) -> NSCollectionLayoutGroup {
        let otherRatio = 1 - ratio
        let contentInsets = NSDirectionalEdgeInsets(top: insets, leading: insets, bottom: insets, trailing: insets)
        let groupSize = NSCollectionLayoutSize(widthDimension: widthDimension, heightDimension: height)

        guard depth > 0 else {
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = contentInsets
            return .horizontal(layoutSize: groupSize, subitems: [item])
        }

        let horizontalItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(ratio),
            heightDimension: .fractionalHeight(1)
        )
        let verticalItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(ratio)
        )
        let horizontalGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(otherRatio)
        )
        let verticalGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(otherRatio),
            heightDimension: .fractionalHeight(1)
        )
        let horizontalItem = NSCollectionLayoutItem(layoutSize: horizontalItemSize)
        horizontalItem.contentInsets = contentInsets
        let verticalItem = NSCollectionLayoutItem(layoutSize: verticalItemSize)
        verticalItem.contentInsets = contentInsets

        let reccursiveGroup = fractalLayoutGroup(depth: depth - 1, height: .fractionalHeight(otherRatio))

        let innerVGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: verticalGroupSize,
            subitems: [reccursiveGroup, verticalItem]
        )

        let innerHGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: horizontalGroupSize,
            subitems: [innerVGroup, horizontalItem]
        )

        let outerVGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: verticalGroupSize,
            subitems: [verticalItem, innerHGroup]
        )

        return NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [horizontalItem, outerVGroup]
        )
    }
}
