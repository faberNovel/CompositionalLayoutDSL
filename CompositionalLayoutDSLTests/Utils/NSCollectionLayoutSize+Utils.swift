//
//  NSCollectionLayoutSize+Utils.swift
//  CompositionalLayoutDSLTests
//
//  Created by Alexandre Podlewski on 13/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

extension NSCollectionLayoutSize {
    static func fractional(width: CGFloat = 1.0, height: CGFloat = 1.0) -> NSCollectionLayoutSize {
        return NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(width),
            heightDimension: .fractionalHeight(height)
        )
    }
    static func absoluteHeight(_ height: CGFloat) -> NSCollectionLayoutSize {
        return NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(height)
        )
    }
}
