//
//  GroupBuilder.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 19/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

#if os(macOS)
import AppKit
#else
import UIKit
#endif

internal protocol BuildableGroup: BuildableItem {
    func makeGroup() -> NSCollectionLayoutGroup
}

extension BuildableGroup {
    func makeItem() -> NSCollectionLayoutItem {
        makeGroup()
    }
}

internal enum GroupBuilder {
    static func make(from layoutGroup: LayoutGroup) -> NSCollectionLayoutGroup {
        guard let buildableGroup = getBuildableGroup(from: layoutGroup) else {
            fatalError("Unable to convert the given LayoutGroup to NSCollectionLayoutGroup")
        }
        return buildableGroup.makeGroup()
    }

    private static func getBuildableGroup(from layoutGroup: LayoutGroup) -> BuildableGroup? {
        var currentGroup = layoutGroup
        while !(currentGroup is BuildableGroup) {
            currentGroup = currentGroup.layoutGroup
        }
        return currentGroup as? BuildableGroup
    }
}
