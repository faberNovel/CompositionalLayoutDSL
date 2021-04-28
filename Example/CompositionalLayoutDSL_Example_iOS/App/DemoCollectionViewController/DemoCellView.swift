//
//  DemoCellView.swift
//  CompositionalLayoutDSL_Example_iOS
//
//  Created by Alexandre Podlewski on 08/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

class DemoCellView: UICollectionViewCell {

    private let label = UILabel()

    override var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.7 : 1
        }
    }

    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .lightGray : .gray
        }
    }

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

    // MARK: - CellView

    func configure(with text: String) {
        label.text = text
    }

    // MARK: - Private

    private func setup() {
        backgroundColor = .gray
        layer.cornerRadius = 6
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
}
