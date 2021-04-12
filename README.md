# CompositionalLayoutDSL

CompositionalLayoutDSL is a Swift library. It makes easier to create compositional layout for collection view.

---

- [Requirements](#requirements)
- [Getting started](#getting-started)
- [Installation](#installation)
    - [CocoaPods](#cocoapods)
    - [Carthage](#carthage)
    - [Swift Package Manager](#swift-package-manager)
    - [Credits](#credits)
- [License](#license)

## Requirements

`CompositionalLayoutDSL` is written in Swift 5. Compatible with iOS 13.0+ and tvOS 13.0+.

## Getting started

Here is an example from the [Example project](./CompositionalLayoutDSL_Example/CompositionalLayoutDSL_Example_iOS/App/ShowcaseViewController/CompositionalLayout/GettingStartedCompositionalLayout.swift)

```swift
collectionView.collectionViewLayout = LayoutBuilder {
    Section {
        VGroup(count: 1) { Item() }
            .height(.fractionalWidth(0.3))
            .width(.fractionalWidth(0.3))
            .interItemSpacing(.fixed(8))
    }
    .interGroupSpacing(8)
    .contentInsets(horizontal: 16, vertical: 8)
    .orthogonalScrollingBehavior(.continuous)
    .supplementariesFollowContentInsets(false)
    .boundarySupplementaryItems {
        BoundarySupplementaryItem(elementKind: UICollectionView.elementKindSectionHeader)
            .height(.absolute(30))
            .alignment(.top)
            .pinToVisibleBounds(true)
    }
}
```

And here what we can see in the [Example](./CompositionalLayoutDSL_Example/CompositionalLayoutDSL_Example_iOS) app

![Screenshot of the getting started layout example](./images/GettingStartedExample.jpg)

## Installation

### Cocoapods

TODO

### Carthage

TODO

### Swift Package Manager

`CompositionalLayoutDSL` can be installed as a Swift Package with Xcode 11 or higher. To install it, add a package using Xcode or a dependency to your Package.swift file:

```swift
.package(url: "https://github.com/faberNovel/CompositionalLayoutDSL")
```

## Credits

CompositionalLayoutDSL is owned and maintained by [Fabernovel](https://www.fabernovel.com/). You can follow us on Twitter at [@Fabernovel](https://twitter.com/FabernovelTech).

## License

`CompositionalLayoutDSL` is available under the MIT license. See the LICENSE file for more info.
