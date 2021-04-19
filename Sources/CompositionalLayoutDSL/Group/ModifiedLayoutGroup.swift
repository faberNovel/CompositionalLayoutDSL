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

extension LayoutGroup {
    func modifier(_ modifier: BuildableLayoutGroupModifier) -> LayoutGroup {
        ModifiedLayoutGroup(group: self, modifier: modifier)
    }
}
