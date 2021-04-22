//
//  DemoCellView.swift
//  CompositionalLayoutDSL_Example_macOS
//
//  Created by Alexandre Podlewski on 21/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import AppKit

class DemoCellView: NSCollectionViewItem {

    private let label = NSText()

    // MARK: - Life cycle

    override func loadView() {
        self.view = NSView()
        self.view.wantsLayer = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        label.string = ""
    }

    // MARK: - CellView

    func configure(with text: String) {
        label.string = text
    }

    // MARK: - Private

    private func setup() {
        view.layer?.backgroundColor = NSColor.gray.cgColor
        view.layer?.cornerRadius = 6
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: 50).isActive = true
        label.heightAnchor.constraint(equalToConstant: 15).isActive = true
        label.alignment = .center
        label.backgroundColor = NSColor.gray
        label.isEditable = false
    }
}
