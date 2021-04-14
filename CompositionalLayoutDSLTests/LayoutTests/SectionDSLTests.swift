//
//  SectionDSLTests.swift
//  CompositionalLayoutDSLTests
//
//  Created by Alexandre Podlewski on 13/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import XCTest
@testable import CompositionalLayoutDSL
import SnapshotTesting
import ADLayoutTest

class SectionDSLTests: XCTestCase {
    func testListSection() throws {
        let traditionalLayout = TestTraditionalListSectionLayout()
        let dslLayout = TestListSectionSection()

        assertLayouts(
            layout1: UICollectionViewCompositionalLayout(
                section: traditionalLayout.section
            ),
            layout2: LayoutBuilder { dslLayout.sectionLayout },
            as: .image(on: .iPhoneX, traits: UITraitCollection(userInterfaceStyle: .light)),
            named: "ListSection",
            maxTestsCount: 5
        )
    }
}

private struct TestListSectionSection: LayoutSection {

    var sectionLayout: CollectionLayoutSectionConvertible {
        Section {
            HGroup(count: 1) { Item() }
                .height(.absolute(40))
        }
        .interGroupSpacing(2)
        .boundarySupplementaryItems {
            BoundarySupplementaryItem(elementKind: UICollectionView.elementKindSectionHeader)
                .height(.absolute(24))
                .alignment(.top)
                .pinToVisibleBounds(true)
            BoundarySupplementaryItem(elementKind: UICollectionView.elementKindSectionFooter)
                .height(.absolute(24))
                .alignment(.bottom)
                .pinToVisibleBounds(true)
        }
    }
}

private struct TestTraditionalListSectionLayout {

    var section: NSCollectionLayoutSection {
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .absoluteHeight(40),
            subitem: NSCollectionLayoutItem(layoutSize: .fractional()),
            count: 1
        )

        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .absoluteHeight(24),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        header.pinToVisibleBounds = true
        let footer = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .absoluteHeight(24),
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom
        )
        footer.pinToVisibleBounds = true

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 2
        section.boundarySupplementaryItems = [header, footer]

        return section
    }
}
