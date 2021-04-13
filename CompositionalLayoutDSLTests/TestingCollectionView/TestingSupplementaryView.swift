//
//  TestingSupplementaryView.swift
//  CompositionalLayoutDSLTests
//
//  Created by Alexandre Podlewski on 13/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

class TestingSupplementaryView: UICollectionReusableView {

    private let label = UILabel()

    // MARK: - Life cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }

    // MARK: - TestingSupplementaryView

    func configure(with text: String) {
        label.text = text
    }

    // MARK: - Private

    private func setup() {
        backgroundColor = UIColor { $0.userInterfaceStyle == .dark ? .darkGray : .lightGray }
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
