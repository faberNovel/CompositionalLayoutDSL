//
//  TestingCollectionViewController.swift
//  CompositionalLayoutDSLTests
//
//  Created by Alexandre Podlewski on 13/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

class TestingCollectionViewController: UICollectionViewController {

    private static let cellIdentifier = "TestingCellView"
    private static let supplementaryIdentifier = "TestingSupplementaryView"

    private var sectionItemsCount: [Int] = []

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
        collectionView.register(TestingCellView.self, forCellWithReuseIdentifier: Self.cellIdentifier)
        collectionView.register(
            TestingSupplementaryView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: Self.supplementaryIdentifier
        )
        collectionView.register(
            TestingSupplementaryView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: Self.supplementaryIdentifier
        )
    }

    // MARK: - TestingCollectionViewController

    func configure(with viewModel: TestingCollectionViewModel) {
        sectionItemsCount = viewModel.sectionItemsCount
        collectionView.reloadData()
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
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Self.cellIdentifier,
                for: indexPath
            ) as? TestingCellView
        else { fatalError("Unexpected dequeued cell") }
        cell.configure(with: "\(indexPath)")
        return cell
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard
            let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: Self.supplementaryIdentifier,
                for: indexPath
            ) as? TestingSupplementaryView
        else { fatalError("Unexpected dequeued supplementary view") }

        supplementaryView.configure(with: "\(indexPath)")
        return supplementaryView
    }
}
