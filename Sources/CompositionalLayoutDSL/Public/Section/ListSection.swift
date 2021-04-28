//
//  ListSection.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 20/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

#if !os(macOS)
import UIKit

@available(iOS 14.0, tvOS 14, *)
public struct ListSection: LayoutSection {

    private var configuration: UICollectionLayoutListConfiguration
    private let layoutEnvironment: NSCollectionLayoutEnvironment

    // MARK: - Life cycle

    /// Creates a list section with the specified list configuration and layout environment.
    public init(
        configuration: UICollectionLayoutListConfiguration,
        layoutEnvironment: NSCollectionLayoutEnvironment
    ) {
        self.configuration = configuration
        self.layoutEnvironment = layoutEnvironment
    }

    /// Creates a list section with the specified list appearance and layout environment.
    public init(
        appearance: UICollectionLayoutListConfiguration.Appearance,
        layoutEnvironment: NSCollectionLayoutEnvironment
    ) {
        self.configuration = UICollectionLayoutListConfiguration(appearance: appearance)
        self.layoutEnvironment = layoutEnvironment
    }

    // MARK: - ListSection

    /// A Boolean value that determines whether the list shows separators between cells.
    @available(tvOS, unavailable)
    public func showsSeparators(_ showsSeparators: Bool) -> Self {
        with(self) { $0.configuration.showsSeparators = showsSeparators }
    }

    /// The background color of the list.
    ///
    /// The default value is nil, which means that the configuration uses the system background
    /// color for the specified appearance.
    public func backgroundColor(_ backgroundColor: UIColor?) -> Self {
        with(self) { $0.configuration.backgroundColor = backgroundColor }
    }

    @available(tvOS, unavailable)
    public func trailingSwipeActionsConfigurationProvider(
        // swiftlint:disable:next line_length
        _ trailingSwipeActionsConfigurationProvider: UICollectionLayoutListConfiguration.SwipeActionsConfigurationProvider?
    ) -> Self {
        // swiftlint:disable:next line_length
        with(self) { $0.configuration.trailingSwipeActionsConfigurationProvider = trailingSwipeActionsConfigurationProvider }
    }

    /// The type of header to use for the list.
    ///
    /// The default value is `UICollectionLayoutListConfiguration.HeaderMode.none`.
    public func headerMode(_ headerMode: UICollectionLayoutListConfiguration.HeaderMode) -> Self {
        with(self) { $0.configuration.headerMode = headerMode }
    }

    /// The type of footer to use for the list.
    ///
    /// The default value is `UICollectionLayoutListConfiguration.FooterMode.none`.
    public func footerMode(_ footerMode: UICollectionLayoutListConfiguration.FooterMode) -> Self {
        with(self) { $0.configuration.footerMode = footerMode }
    }

    // MARK: - LayoutSection

    public var layoutSection: LayoutSection {
        return self
    }
}

@available(iOS 14.0, tvOS 14, *)
extension ListSection: BuildableSection {
    func makeSection() -> NSCollectionLayoutSection {
        return .list(using: configuration, layoutEnvironment: layoutEnvironment)
    }
}
#endif
