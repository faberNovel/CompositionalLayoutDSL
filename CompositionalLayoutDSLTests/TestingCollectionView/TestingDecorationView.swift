//
//  TestingDecorationView.swift
//  CompositionalLayoutDSLTests
//
//  Created by Alexandre Podlewski on 14/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

class TestingDecorationView: UICollectionReusableView {

    static let kind = "TestingDecorationView"

    // MARK: - Life cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - Private

    private func setup() {
        backgroundColor = .systemBackground
        layer.borderWidth = 5
        layer.borderColor = UIColor.cyan.cgColor
    }
}
