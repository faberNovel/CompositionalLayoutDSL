# Change Log
All notable changes to this project will be documented in this file.
`CompositionalLayoutDSL` adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]

### Removed
- Drop support for Swift 5.3, we now use `@resultBuilder` instead of `@_functionBuilder`

## [0.1.0] - 2021-04-28Z

### Created

#### Structures
- `CompositionalLayout`
- `Configuration`
- `Section`
- `ListSection`
- `RawSection`
- `HGroup`
- `VGroup`
- `CustomGroup`
- `Item`
- `DecorationItem`
- `SupplementaryItem`
- `BoundarySupplementaryItem`

#### Enumerations
- `SupplementaryItem.AnchorOffset`
- `ListResultBuilder`

#### Protocols
- `LayoutConfiguration`
- `LayoutSection`
- `LayoutGroup`
- `LayoutItem`
- `LayoutDecorationItem`
- `LayoutSupplementaryItem`
- `LayoutBoundarySupplementaryItem`
- `ResizableItem`

#### Type aliases
- `LayoutItemBuilder`
- `LayoutBoundarySupplementaryItemBuilder`
- `LayoutSupplementaryItemBuilder`
- `LayoutDecorationItemBuilder`

#### Functions
- `LayoutSectionBuilder(layoutSection:) -> NSCollectionLayoutSection`
- `LayoutBuilder(configuration:layoutSection:) -> NSCollectionViewCompositionalLayout`
- `LayoutBuilder(configuration:layoutSection:) -> UICollectionViewCompositionalLayout`
- `LayoutBuilder(compositionalLayout:) -> NSCollectionViewCompositionalLayout`
- `LayoutBuilder(compositionalLayout:) -> UICollectionViewCompositionalLayout`

#### External extensions

- `NSCollectionView.setCollectionViewLayout(_ layout: CompositionalLayout)`
- `UICollectionView.setCollectionViewLayout(_ layout: CompositionalLayout)`
