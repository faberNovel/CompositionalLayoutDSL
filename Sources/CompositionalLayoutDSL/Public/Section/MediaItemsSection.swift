//
//  MediaItemsSection.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 02/10/2023.
//

#if os(tvOS)
import UIKit
import TVUIKit

@available(tvOS 15.0, *)
public struct MediaItemsSection: LayoutSection {

    // MARK: - Life cycle

    /// Creates a list section with the specified list configuration and layout environment.
    public init() {}

    // MARK: - MediaItemsSection

    // MARK: - LayoutSection

    public var layoutSection: LayoutSection {
        return self
    }
}

@available(tvOS 15.0, *)
extension MediaItemsSection: BuildableSection {
    func makeSection() -> NSCollectionLayoutSection {
        return NSCollectionLayoutSection.orthogonalLayoutSectionForMediaItems()
    }
}
#endif
