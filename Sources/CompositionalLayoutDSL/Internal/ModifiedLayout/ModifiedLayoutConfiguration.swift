//
//  ModifiedLayoutConfiguration.swift
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

struct ValueModifiedLayoutConfiguration: LayoutConfiguration, BuildableConfiguration {
    let configuration: LayoutConfiguration
    let valueModifier: (inout ConfigurationBuilder.TransformedType) -> Void

    var layoutConfiguration: LayoutConfiguration { self }

    func makeConfiguration() -> ConfigurationBuilder.TransformedType {
        var collectionLayoutConfiguration = ConfigurationBuilder.make(from: configuration)
        valueModifier(&collectionLayoutConfiguration)
        return collectionLayoutConfiguration
    }
}

extension LayoutConfiguration {

    func valueModifier<T>(
        _ value: T,
        keyPath: WritableKeyPath<ConfigurationBuilder.TransformedType, T>
    ) -> LayoutConfiguration {
        ValueModifiedLayoutConfiguration(configuration: self) { $0[keyPath: keyPath] = value }
    }

    func valueModifier(
        modifier: @escaping (inout ConfigurationBuilder.TransformedType) -> Void
    ) -> LayoutConfiguration {
        ValueModifiedLayoutConfiguration(configuration: self, valueModifier: modifier)
    }
}
