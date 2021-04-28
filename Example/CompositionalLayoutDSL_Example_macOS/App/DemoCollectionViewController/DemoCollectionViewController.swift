//
//  DemoCollectionViewController.swift
//  CompositionalLayoutDSL_Example_macOS
//
//  Created by Alexandre Podlewski on 21/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import AppKit

class DemoCollectionViewController: NSViewController, NSCollectionViewDataSource, NSCollectionViewDelegate {

    static let cellIdentifier = NSUserInterfaceItemIdentifier(rawValue: "DemoCellView")
    static let supplementaryIdentifier = NSUserInterfaceItemIdentifier(rawValue: "DemoSupplementaryView")

    lazy var scrollView = NSScrollView()
    lazy var collectionView = NSCollectionView()

    var sectionItemsCount: [Int] = [9, 4, 16, 1, 42, 10, 100]

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        scrollView.documentView = collectionView
        collectionView.backgroundColors = [NSColor.red]
        setup()
    }

    // MARK: - NSCollectionViewDataSource

    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return sectionItemsCount.count
    }

    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionItemsCount[section]
    }

    func collectionView(
        _ collectionView: NSCollectionView,
        itemForRepresentedObjectAt indexPath: IndexPath
    ) -> NSCollectionViewItem {
        guard
            let cell = collectionView.makeItem(
                withIdentifier: Self.cellIdentifier,
                for: indexPath
            ) as? DemoCellView
        else { fatalError("Unexpected dequeued cell") }
        cell.configure(with: "\(indexPath)")
        return cell
    }

    func collectionView(
        _ collectionView: NSCollectionView,
        viewForSupplementaryElementOfKind kind: NSCollectionView.SupplementaryElementKind,
        at indexPath: IndexPath
    ) -> NSView {
        guard
            let supplementaryView = collectionView.makeSupplementaryView(
                ofKind: kind,
                withIdentifier: Self.supplementaryIdentifier,
                for: indexPath
            ) as? DemoSupplementaryView
        else { fatalError("Unexpected dequeued supplementary view") }

        supplementaryView.configure(with: "\(indexPath)")
        return supplementaryView
    }

    // MARK: - Private

    private func setup() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = NSCollectionViewFlowLayout()
        collectionView.backgroundColors = [.windowBackgroundColor]

        collectionView.register(DemoCellView.self, forItemWithIdentifier: Self.cellIdentifier)
        collectionView.register(
            DemoSupplementaryView.self,
            forSupplementaryViewOfKind: NSCollectionView.elementKindSectionHeader,
            withIdentifier: Self.supplementaryIdentifier
        )
        collectionView.register(
            DemoSupplementaryView.self,
            forSupplementaryViewOfKind: NSCollectionView.elementKindSectionFooter,
            withIdentifier: Self.supplementaryIdentifier
        )

        collectionView.reloadData()
    }
}
