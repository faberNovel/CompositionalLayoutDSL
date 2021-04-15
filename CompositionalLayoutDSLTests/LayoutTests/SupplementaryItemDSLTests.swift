//
//  SupplementaryItemDSLTests.swift
//  CompositionalLayoutDSLTests
//
//  Created by Alexandre Podlewski on 14/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import XCTest
@testable import CompositionalLayoutDSL
import SnapshotTesting

class SupplementaryItemDSLTests: XCTestCase {
    func testSupplementaryItem() throws {
        let traditionalLayout = TestTraditionalSectionLayout()
        let dslLayout = TestSectionSection()

        assertLayouts(
            layout1: UICollectionViewCompositionalLayout(
                section: traditionalLayout.section
            ),
            layout2: LayoutBuilder { dslLayout.sectionLayout },
            as: .image(on: .iPhoneX, traits: UITraitCollection(userInterfaceStyle: .light)),
            named: "testSupplementaryItem",
            maxTestsCount: 5
        )
    }
}

private struct TestSectionSection: LayoutSection {

    var sectionLayout: LayoutSection {
        Section {
            HGroup(count: 4) {
                Item {
                    SupplementaryItem(elementKind: UICollectionView.elementKindSectionHeader)
                        .height(.absolute(15))
                        .width(.absolute(15))
                        .containerAnchor(
                            edges: [.top, .trailing],
                            offset: .fractional(x: 0.5, y: -0.5)
                        )
                }
                .height(.fractionalWidth(1 / 4))
            }
            .height(.absolute(80))
            .interItemSpacing(.fixed(16))
            .supplementaryItems {
                SupplementaryItem(elementKind: UICollectionView.elementKindSectionFooter)
                    .height(.absolute(60))
                    .width(.absolute(20))
                    .containerAnchor(edges: .trailing, offset: .fractional(x: 1, y: 0))
            }
            .contentInsets(trailing: 20)
        }
        .interGroupSpacing(16)
        .contentInsets(bottom: 16)
    }
}

private struct TestTraditionalSectionLayout {

    var section: NSCollectionLayoutSection {
        let badgeItemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(15),
            heightDimension: .absolute(15)
        )
        let badgeItem = NSCollectionLayoutSupplementaryItem(
            layoutSize: badgeItemSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            containerAnchor: NSCollectionLayoutAnchor(
                edges: [.top, .trailing],
                fractionalOffset: CGPoint(x: 0.5, y: -0.5)
            )
        )

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(1 / 4)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: [badgeItem])
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .absoluteHeight(80),
            subitem: item,
            count: 4
        )
        group.interItemSpacing = .fixed(16)

        let groupTrailingItemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(20),
            heightDimension: .absolute(60)
        )
        let groupTrailingItem = NSCollectionLayoutSupplementaryItem(
            layoutSize: groupTrailingItemSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            containerAnchor: NSCollectionLayoutAnchor(
                edges: [.trailing],
                fractionalOffset: CGPoint(x: 1, y: 0)
            )
        )
        group.supplementaryItems = [groupTrailingItem]
        group.contentInsets.trailing = 20

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets.bottom = 16

        return section
    }
}
