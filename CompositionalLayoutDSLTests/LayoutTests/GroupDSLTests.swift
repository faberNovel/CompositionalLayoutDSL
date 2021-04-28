//
//  GroupDSLTests.swift
//  CompositionalLayoutDSLTests
//
//  Created by Alexandre Podlewski on 13/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import XCTest
@testable import CompositionalLayoutDSL
import SnapshotTesting

class CompositionalLayoutDSLTests: XCTestCase {

    func testInnerGroups() throws {
        let traditionalLayout = TestInnerGroupsTraditionalLayout()
        let dslLayout = testInnerGroupsLayout()
        assertLayouts(
            layout1: UICollectionViewCompositionalLayout(
                section: traditionalLayout.section,
                configuration: traditionalLayout.configuration
            ),
            layout2: LayoutBuilder { dslLayout },
            as: .image(on: .iPhoneX, traits: UITraitCollection(userInterfaceStyle: .light)),
            named: "InnerGroups",
            maxTestsCount: 5
        )
    }
}

func testInnerGroupsLayout() -> CompositionalLayout {
    CompositionalLayout { _, _ in
        Section {
            HGroup {
                Item(width: .fractionalWidth(1 / 3))
                    .contentInsets(trailing: 4)
                VGroup(count: 2) { Item() }
                    .width(.fractionalWidth(1 / 3))
                    .interItemSpacing(.fixed(8))
                    .contentInsets(horizontal: 4)
                VGroup(count: 3) { Item() }
                    .width(.fractionalWidth(1 / 3))
                    .interItemSpacing(.fixed(8))
                    .contentInsets(leading: 4)
            }
            .height(.absolute(100))
            .contentInsets(horizontal: 16)
        }
        .interGroupSpacing(8)
    }
    .interSectionSpacing(8)
}

private struct TestInnerGroupsTraditionalLayout {

    var section: NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .fractional(width: 1 / 3))
        item.contentInsets.trailing = 4

        let innerGroup1 = NSCollectionLayoutGroup.vertical(
            layoutSize: .fractional(width: 1 / 3),
            subitem: NSCollectionLayoutItem(layoutSize: .fractional()),
            count: 2
        )
        innerGroup1.interItemSpacing = .fixed(8)
        innerGroup1.contentInsets.leading = 4
        innerGroup1.contentInsets.trailing = 4

        let innerGroup2 = NSCollectionLayoutGroup.vertical(
            layoutSize: .fractional(width: 1 / 3),
            subitem: NSCollectionLayoutItem(layoutSize: .fractional()),
            count: 3
        )
        innerGroup2.interItemSpacing = .fixed(8)
        innerGroup2.contentInsets.leading = 4

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .absoluteHeight(100),
            subitems: [item, innerGroup1, innerGroup2]
        )
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8

        return section
    }

    var configuration: UICollectionViewCompositionalLayoutConfiguration {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 8
        return configuration
    }
}
