//
//  DemoCollectionViewController.swift
//  testCollectionSectionLayout
//
//  Created by Alexandre Podlewski on 06/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

class DemoCollectionViewController: UICollectionViewController {

    static let cellIdentifier = "DemoCellView"
    static let supplementaryIdentifier = "DemoSupplementaryView"

    var sectionItemsCount: [Int] = [9, 4, 16, 1, 42, 10, 100]

    // MARK: - Life cycle

    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        collectionView.register(DemoCellView.self, forCellWithReuseIdentifier: Self.cellIdentifier)
        collectionView.register(
            DemoSupplementaryView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: Self.supplementaryIdentifier
        )
        collectionView.register(
            DemoSupplementaryView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: Self.supplementaryIdentifier
        )
    }

    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionItemsCount.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return sectionItemsCount[section]
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Self.cellIdentifier,
            for: indexPath
        ) as! DemoCellView
        cell.configure(with: "\(indexPath)")
        return cell
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let supplementaryView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: Self.supplementaryIdentifier,
            for: indexPath
        ) as! DemoSupplementaryView
        supplementaryView.configure(with: "\(indexPath)")
        return supplementaryView
    }
}
