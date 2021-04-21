//
//  DemoSupplementaryView.swift
//  CompositionalLayoutDSL_Example_macOS
//
//  Created by Alexandre Podlewski on 21/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import AppKit

final class DemoSupplementaryView: NSView, NSCollectionViewElement {

    private let label = NSText()

    // MARK: - Life cycle

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        label.string = ""
    }

    // MARK: - DemoSupplementaryView

    func configure(with text: String) {
        label.string = text
    }

    // MARK: - Private

    private func setup() {
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.darkGray.cgColor
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: 50).isActive = true
        label.heightAnchor.constraint(equalToConstant: 15).isActive = true
        label.alignment = .center
        label.backgroundColor = NSColor.darkGray
        label.isEditable = false
    }
}
