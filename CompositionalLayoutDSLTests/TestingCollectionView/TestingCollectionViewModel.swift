//
//  TestingCollectionViewModel.swift
//  CompositionalLayoutDSLTests
//
//  Created by Alexandre Podlewski on 13/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import Foundation
import SwiftCheck

struct TestingCollectionViewModel {
    let sectionItemsCount: [Int]
}

extension TestingCollectionViewModel: Arbitrary {

    static var arbitrary: Gen<Self> {
        Gen<Self>.compose { c in
            TestingCollectionViewModel(
                sectionItemsCount: c.generate(
                    using: Gen<Int>.choose((0, 40)).proliferateNonEmpty
                )
            )
        }
    }
}
