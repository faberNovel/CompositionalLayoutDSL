//
//  DecorationItemDSLTests.swift
//  CompositionalLayoutDSLTests
//
//  Created by Alexandre Podlewski on 14/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import XCTest
@testable import CompositionalLayoutDSL
import SnapshotTesting

class DecorationItemDSLTests: XCTestCase {

    func testDecorationItem() throws {
        let traditionalLayout = TestTraditionalListSectionLayout()
        let dslLayout = TestListSectionSection()

        assertLayouts(
            layout1: UICollectionViewCompositionalLayout(
                section: traditionalLayout.section
            ).registeringDecorationView(),
            layout2: LayoutBuilder { dslLayout.layoutSection }.registeringDecorationView(),
            as: .image(on: .iPhoneX, traits: UITraitCollection(userInterfaceStyle: .light)),
            named: "testDecorationItem",
            maxTestsCount: 5
        )
    }
}

private extension UICollectionViewLayout {
    func registeringDecorationView() -> UICollectionViewLayout {
        self.register(TestingDecorationView.self, forDecorationViewOfKind: TestingDecorationView.kind)
        return self
    }
}

private struct TestListSectionSection: LayoutSection {

    var layoutSection: LayoutSection {
        Section {
            HGroup(count: 4) { Item() }
                .height(.absolute(40))
                .interItemSpacing(.fixed(8))
        }
        .interGroupSpacing(8)
        .orthogonalScrollingBehavior(.continuous)
        .decorationItems {
            DecorationItem(elementKind: TestingDecorationView.kind)
        }
        .contentInsets(value: 16)
    }
}

private struct TestTraditionalListSectionLayout {

    var section: NSCollectionLayoutSection {
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .absoluteHeight(40),
            subitem: NSCollectionLayoutItem(layoutSize: .fractional()),
            count: 4
        )
        group.interItemSpacing = .fixed(8)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        section.decorationItems = [
            .background(elementKind: TestingDecorationView.kind)
        ]
        return section
    }
}
