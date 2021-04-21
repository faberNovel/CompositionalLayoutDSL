//
//  ModifiedLayoutConfiguration.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 19/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

struct ValueModifiedLayoutConfiguration: LayoutConfiguration, BuildableConfiguration {
    let configuration: LayoutConfiguration
    let valueModifier: (inout UICollectionViewCompositionalLayoutConfiguration) -> Void

    var layoutConfiguration: LayoutConfiguration { self }

    func makeConfiguration() -> UICollectionViewCompositionalLayoutConfiguration {
        var collectionLayoutConfiguration = ConfigurationBuilder.make(from: configuration)
        valueModifier(&collectionLayoutConfiguration)
        return collectionLayoutConfiguration
    }
}

extension LayoutConfiguration {

    func valueModifier<T>(
        _ value: T,
        keyPath: WritableKeyPath<UICollectionViewCompositionalLayoutConfiguration, T>
    ) -> LayoutConfiguration {
        ValueModifiedLayoutConfiguration(configuration: self) { $0[keyPath: keyPath] = value }
    }

    func valueModifier(
        modifier: @escaping (inout UICollectionViewCompositionalLayoutConfiguration) -> Void
    ) -> LayoutConfiguration {
        ValueModifiedLayoutConfiguration(configuration: self, valueModifier: modifier)
    }
}
