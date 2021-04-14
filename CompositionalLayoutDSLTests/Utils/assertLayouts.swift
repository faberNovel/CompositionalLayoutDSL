//
//  assertLayouts.swift
//  CompositionalLayoutDSLTests
//
//  Created by Alexandre Podlewski on 13/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit
import XCTest
import SnapshotTesting
import ADAssertLayout
import ADLayoutTest

extension XCTestCase {

    func assertLayouts<Format>(
        layout1: UICollectionViewLayout,
        layout2: UICollectionViewLayout,
        as snapshotting: Snapshotting<UIViewController, Format>,
        named name: String,
        maxTestsCount: Int,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        var counter = 0
        runLayoutTests(
            named: name,
            snapshotStrategy: .failureOnly,
            randomStrategy: .consistent,
            maxTestsCount: maxTestsCount,
            file: file,
            line: line,
            run: { (viewModel: TestingCollectionViewModel) -> ViewAssertionResult in
                counter += 1
                return self.compareLayout(
                    viewModel: viewModel,
                    layout1: layout1,
                    layout2: layout2,
                    as: snapshotting,
                    counter: counter,
                    file: file,
                    testName: testName,
                    line: line
                )
            }
        )
    }

    private func compareLayout<Format>(
        viewModel: TestingCollectionViewModel,
        layout1: UICollectionViewLayout,
        layout2: UICollectionViewLayout,
        as snapshotting: Snapshotting<UIViewController, Format>,
        counter: Int,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) -> ViewAssertionResult {
        let controller = TestingCollectionViewController()
        // ???: (Alexandre Podlewski) 13/04/2021 Needed for all cells to be rendered
        controller.view.frame.size.height = 3000
        controller.view.frame.size.width = 3000
        controller.configure(with: viewModel)

        controller.collectionView.collectionViewLayout = layout1
        controller.collectionView.collectionViewLayout.invalidateLayout()
        controller.collectionView.reloadData()

        assertSnapshot(
            matching: controller,
            as: snapshotting,
            named: String(counter),
            file: file,
            testName: testName,
            line: line
        )

        controller.collectionView.collectionViewLayout = layout2
        controller.collectionView.collectionViewLayout.invalidateLayout()
        controller.collectionView.reloadData()

        assertSnapshot(
            matching: controller,
            as: snapshotting,
            named: String(counter),
            file: file,
            testName: testName,
            line: line
        )

        return .success
    }
}
