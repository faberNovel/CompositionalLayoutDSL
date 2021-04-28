//
//  ModifiedLayoutGroup.swift
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

    func valueModifier<T>(_ value: T, keyPath: WritableKeyPath<NSCollectionLayoutGroup, T>) -> LayoutGroup {
        ValueModifiedLayoutGroup(group: self) { $0[keyPath: keyPath] = value }
    }

    func valueModifier(
        modifier: @escaping (inout NSCollectionLayoutGroup) -> Void
    ) -> LayoutGroup {
        ValueModifiedLayoutGroup(group: self, valueModifier: modifier)
    }
}
