//
//  ShowcaseViewController.swift
//  CompositionalLayoutDSL_Example_iOS
//
//  Created by Alexandre Podlewski on 08/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit
import CompositionalLayoutDSL

class ShowcaseViewController: DemoCollectionViewController {

    private var currentLayoutIndex = 0 {
        didSet {
            title = "\(currentLayoutIndex + 1) / \(showCaseLayouts.count)"
        }
    }

    private let nextLayoutButton = UIBarButtonItem()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        currentLayoutIndex = 0
        nextLayoutButton.target = self
        nextLayoutButton.action = #selector(nextLayout)
        nextLayoutButton.title = "Next layout"
        navigationItem.rightBarButtonItem = nextLayoutButton

        collectionView.collectionViewLayout = showCaseLayouts[currentLayoutIndex]
    }

    // MARK: - Private

    @objc private func nextLayout() {
        let nextLayoutIndex = (currentLayoutIndex + 1) % showCaseLayouts.count
        currentLayoutIndex = nextLayoutIndex
        collectionView.setCollectionViewLayout(showCaseLayouts[currentLayoutIndex], animated: false)
        collectionView.reloadData()
        collectionView.contentOffset = CGPoint(x: 0, y: -collectionView.adjustedContentInset.top)
    }
}

extension ShowcaseViewController {

    // MARK: - Layouts

    private var showCaseLayouts: [UICollectionViewLayout] {
        [
            GettingStartedCompositionalLayout().layout(),
            LayoutBuilder { ListSection() },
//            LayoutBuilder { TraditionalListSection() },
            LayoutBuilder {
                Section {
                    FractalGroup(ratio: 0.5, depth: 2)
                        .height(.fractionalWidth(0.5))
                }
            },
//            LayoutBuilder {
//                Section {
//                    TraditionalFractalGroup(ratio: 0.5, depth: 2, heightDimension: .fractionalWidth(0.5))
//                }
//            },
            LayoutBuilder {
                SectionWithHeader {
                    Section {
                        FractalGroup(ratio: 0.5, depth: 2)
                            .height(.fractionalWidth(0.45))
                            .width(.fractionalWidth(0.9))
                    }
                    .orthogonalScrollingBehavior(.continuous)
                }
            },
            LayoutBuilder(closure: {
                CompositionalLayout(repeatingSections: [
                    // swiftlint:disable opening_brace
                    { AppStoreNewContentSection(environment: $1) },
                    { AppStoreTrendingContentSection(environment: $1) },
                    { AppStoreTopContentSection(environment: $1) },
                    { AppStoreTrendingContentSection(environment: $1) },
                    { AppStoreTrendingContentSection(environment: $1) }
                    // swiftlint:enable opening_brace
                ])
            }),
            CompositionalLayoutWithSupplementaryView().layout()
//            TraditionalCompositionalLayoutWithSupplementaryView().layout()
        ]
    }
}
