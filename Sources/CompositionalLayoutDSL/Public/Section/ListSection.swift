//
//  ListSection.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 20/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

@available(iOS 14.0, tvOS 14, *)
public struct ListSection: LayoutSection {

    private let configuration: UICollectionLayoutListConfiguration
    private let layoutEnvironment: NSCollectionLayoutEnvironment

    // MARK: - Life cycle

    /// Creates a list section with the specified list configuration and layout environment.
    public init(
        configuration: UICollectionLayoutListConfiguration,
        layoutEnvironment: NSCollectionLayoutEnvironment
    ) {
        self.configuration = configuration
        self.layoutEnvironment = layoutEnvironment
    }

    // MARK: - LayoutSection

    public var layoutSection: LayoutSection {
        return self
    }
}

@available(iOS 14.0, tvOS 14, *)
extension ListSection: BuildableSection {
    func makeSection() -> NSCollectionLayoutSection {
        return .list(using: configuration, layoutEnvironment: layoutEnvironment)
    }
}
