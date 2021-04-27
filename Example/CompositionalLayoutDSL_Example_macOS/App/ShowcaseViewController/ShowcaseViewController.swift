//
//  ShowcaseViewController.swift
//  CompositionalLayoutDSL_Example_macOS
//
//  Created by Alexandre Podlewski on 21/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import Cocoa
import CompositionalLayoutDSL

class ShowcaseViewController: DemoCollectionViewController {

    private var currentLayoutIndex = 0 {
        didSet {
            currentLayoutText.string = "\(currentLayoutIndex + 1) / \(showCaseLayouts.count)"
        }
    }

    private let currentLayoutText = NSTextView()
    private let nextLayoutButton = NSButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControls()

        currentLayoutIndex = 0
        nextLayoutButton.target = self
        nextLayoutButton.action = #selector(nextLayout)
        nextLayoutButton.title = "Next layout"
        nextLayoutButton.bezelStyle = .roundRect

        collectionView.collectionViewLayout = showCaseLayouts[currentLayoutIndex]
        collectionView.collectionViewLayout?.invalidateLayout()
    }

    // MARK: - Private

    @objc private func nextLayout() {
        let nextLayoutIndex = (currentLayoutIndex + 1) % showCaseLayouts.count
        currentLayoutIndex = nextLayoutIndex
        collectionView.collectionViewLayout = showCaseLayouts[currentLayoutIndex]
        collectionView.reloadData()
        scrollView.scroll(.zero)
    }

    private func setupControls() {
        let controlsContainerView = NSVisualEffectView()
        controlsContainerView.blendingMode = .withinWindow
        controlsContainerView.material = .hudWindow
        controlsContainerView.state = .active
        let controls = NSStackView(views: [currentLayoutText, nextLayoutButton])
        controls.edgeInsets = NSEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        controlsContainerView.addSubview(controls)
        controlsContainerView.wantsLayer = true
        controlsContainerView.layer?.cornerRadius = 8
        controlsContainerView.layer?.maskedCorners = [.layerMinXMinYCorner]
        scrollView.scrollerInsets.top += 25

        currentLayoutText.translatesAutoresizingMaskIntoConstraints = false
        currentLayoutText.widthAnchor.constraint(equalToConstant: 50).isActive = true
        currentLayoutText.alignment = .center
        currentLayoutText.isEditable = false
        currentLayoutText.backgroundColor = .clear

        controls.translatesAutoresizingMaskIntoConstraints = false
        controls.topAnchor.constraint(equalTo: controlsContainerView.topAnchor).isActive = true
        controls.bottomAnchor.constraint(equalTo: controlsContainerView.bottomAnchor).isActive = true
        controls.leadingAnchor.constraint(equalTo: controlsContainerView.leadingAnchor).isActive = true
        controls.trailingAnchor.constraint(equalTo: controlsContainerView.trailingAnchor).isActive = true

        view.addSubview(controlsContainerView)
        controlsContainerView.translatesAutoresizingMaskIntoConstraints = false
        controlsContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        controlsContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
}

extension ShowcaseViewController {

    // MARK: - Layouts

    private var showCaseLayouts: [NSCollectionViewLayout] {
        [
            LayoutBuilder { fourColumnsGroup() },
//            fourColumnsGroupAppKit(),
            LayoutBuilder { listLayout() },
            LayoutBuilder { tweetDeckLayout() }
        ]
    }

    private func fourColumnsGroup() -> CompositionalLayout {
        CompositionalLayout { _, _ in
            Section {
                HGroup(count: 4) {
                    Item()
                }
                .height(.absolute(100))
                .interItemSpacing(.fixed(16))
            }
            .interGroupSpacing(16)
            .contentInsets(horizontal: 16, vertical: 8)
        }
    }

    private func fourColumnsGroupAppKit() -> NSCollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(100)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 4
        )
        group.interItemSpacing = .fixed(16)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        return NSCollectionViewCompositionalLayout(section: section)
    }

    private func tweetDeckLayout() -> CompositionalLayout {
        CompositionalLayout { _, _ in
            Section {
                HGroup(count: 1) {
                    Item()
                }
                .height(.absolute(100))
                .width(.absolute(150))
            }
            .interGroupSpacing(4)
            .boundarySupplementaryItems {
                BoundarySupplementaryItem(elementKind: NSCollectionView.elementKindSectionFooter)
                    .alignment(.leading)
                    .width(.absolute(20))
            }
            .orthogonalScrollingBehavior(.continuous)
            .contentInsets(horizontal: 4)
        }
        .scrollDirection(.horizontal)
    }

    private func listLayout() -> CompositionalLayout {
        CompositionalLayout { _, _ in
            Section {
                HGroup(count: 1) {
                    Item()
                }
                .height(.absolute(40))
                .width(.fractionalWidth(1))
            }
            .interGroupSpacing(1)
            .boundarySupplementaryItems {
                BoundarySupplementaryItem(elementKind: NSCollectionView.elementKindSectionHeader)
                    .alignment(.top)
                    .height(.absolute(20))
                    .pinToVisibleBounds(true)
                BoundarySupplementaryItem(elementKind: NSCollectionView.elementKindSectionFooter)
                    .alignment(.bottom)
                    .height(.absolute(20))
                    .pinToVisibleBounds(true)
            }
            .contentInsets(horizontal: 8)
            .supplementariesFollowContentInsets(false)
        }
    }
}
