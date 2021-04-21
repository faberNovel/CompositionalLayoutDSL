//
//  CompositionalLayoutWithSupplementaryView.swift
//  CompositionalLayoutDSL_Example_iOS
//
//  Created by Alexandre Podlewski on 12/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit
import CompositionalLayoutDSL

struct CompositionalLayoutWithSupplementaryView {
    func layout() -> UICollectionViewLayout {
        CompositionalLayoutBuilder {
            CompositionalLayout { _, _ in
                Section {
                    VGroup(count: 1) { Item() }
                        .height(.absolute(200))
                        .width(.fractionalWidth(0.85))
                        .interItemSpacing(.fixed(8))
                }
                .interGroupSpacing(8)
                .orthogonalScrollingBehavior(.continuous)
            }
            .interSectionSpacing(20)
            .boundarySupplementaryItems {
                BoundarySupplementaryItem(elementKind: UICollectionView.elementKindSectionHeader)
                    .height(.absolute(150))
                    .alignment(.top)
                    .absoluteOffset(CGPoint(x: 0, y: -8))
                BoundarySupplementaryItem(elementKind: UICollectionView.elementKindSectionFooter)
                    .height(.absolute(50))
                    .alignment(.bottom)
                    .absoluteOffset(CGPoint(x: 0, y: 8))
            }
        }
    }
}

// Same layout with only UIKit APIs

struct TraditionalCompositionalLayoutWithSupplementaryView {
    func layout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout(section: section, configuration: configuration)
    }

    // MARK: - Private

    private var section: NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.85),
            heightDimension: .absolute(200)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        return NSCollectionLayoutSection(group: group)
    }

    private var configuration: UICollectionViewCompositionalLayoutConfiguration {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 20
        configuration.boundarySupplementaryItems = [globalHeader, globalFooter]
        return configuration
    }

    private var globalHeader: NSCollectionLayoutBoundarySupplementaryItem {
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(200)
        )
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: size,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top,
            absoluteOffset: CGPoint(x: 0, y: -8)
        )
    }

    private var globalFooter: NSCollectionLayoutBoundarySupplementaryItem {
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(50)
        )
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: size,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .top,
            absoluteOffset: CGPoint(x: 0, y: 8)
        )
    }
}
