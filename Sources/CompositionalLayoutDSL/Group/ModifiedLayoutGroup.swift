//
//  ModifiedLayoutGroup.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 19/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

protocol BuildableLayoutGroupModifier {
    func collectionLayoutGroup(layoutGroup: LayoutGroup) -> NSCollectionLayoutGroup
}

struct ModifiedLayoutGroup: LayoutGroup, BuildableGroup {
    let group: LayoutGroup
    let modifier: BuildableLayoutGroupModifier

    var layoutGroup: LayoutGroup { self }

    func makeGroup() -> NSCollectionLayoutGroup {
        return modifier.collectionLayoutGroup(layoutGroup: group)
    }
}

struct ValueModifiedLayoutGroup: LayoutGroup, BuildableGroup {
    let group: LayoutGroup
    let valueModifier: (inout NSCollectionLayoutGroup) -> Void

    var layoutGroup: LayoutGroup { self }

    func makeGroup() -> NSCollectionLayoutGroup {
        var collectionLayoutGroup = GroupBuilder.make(from: group)
        valueModifier(&collectionLayoutGroup)
        return collectionLayoutGroup
    }
}

extension LayoutGroup {
    func modifier(_ modifier: BuildableLayoutGroupModifier) -> LayoutGroup {
        ModifiedLayoutGroup(group: self, modifier: modifier)
    }

    func valueModifier<T>(_ value: T, keyPath: WritableKeyPath<NSCollectionLayoutGroup, T>) -> LayoutGroup {
        ValueModifiedLayoutGroup(group: self) { $0[keyPath: keyPath] = value }
    }

    func valueModifier(
        modifier: @escaping (inout NSCollectionLayoutGroup) -> Void
    ) -> LayoutGroup {
        ValueModifiedLayoutGroup(group: self, valueModifier: modifier)
    }
}
