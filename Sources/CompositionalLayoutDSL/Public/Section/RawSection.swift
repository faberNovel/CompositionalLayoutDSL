//
//  RawSection.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 27/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

#if os(macOS)
import AppKit
#else
import UIKit
#endif

/// A container to allow usage of `NSCollectionLayoutSection` with this library
public struct RawSection: LayoutSection {

    private let rawLayoutSection: NSCollectionLayoutSection

    // MARK: - Life cycle

    public init(rawLayoutSection: NSCollectionLayoutSection) {
        self.rawLayoutSection = rawLayoutSection
    }

    // MARK: - LayoutSection

    public var layoutSection: LayoutSection {
        return self
    }
}

extension RawSection: BuildableSection {

    func makeSection() -> NSCollectionLayoutSection {
        return rawLayoutSection
    }
}
