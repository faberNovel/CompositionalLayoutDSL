//
//  ResizableItem.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

public protocol ResizableItem {
    func size(_ size: NSCollectionLayoutSize) -> Self
    func width(_ width: NSCollectionLayoutDimension) -> Self
    func height(_ height: NSCollectionLayoutDimension) -> Self
}

public extension ResizableItem {
    func size(_ size: NSCollectionLayoutSize) -> Self {
        self.width(size.widthDimension).height(size.heightDimension)
    }
}
