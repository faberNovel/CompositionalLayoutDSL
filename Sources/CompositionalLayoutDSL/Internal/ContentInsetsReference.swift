//
//  ContentInsetsReference.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 15/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

/// Replacement for UIContentInsetsReference which is not available for iOS 13
enum ContentInsetsReference: Int {
    case automatic = 0
    case none = 1
    case safeArea = 2
    case layoutMargins = 3
    case readableContent = 4

    @available(iOS 14.0, *)
    init(from uiKitObject: UIContentInsetsReference) {
        switch uiKitObject {
        case .automatic:
            self = .automatic
        case .none:
            self = .none
        case .safeArea:
            self = .safeArea
        case .layoutMargins:
            self = .layoutMargins
        case .readableContent:
            self = .readableContent
        @unknown default:
            assertionFailure("Unknown type")
            self = .automatic
        }
    }

    @available(iOS 14.0, *)
    var uiKitValue: UIContentInsetsReference {
        switch self {
        case .automatic:
            return .automatic
        case .none:
            return .none
        case .safeArea:
            return .safeArea
        case .layoutMargins:
            return .layoutMargins
        case .readableContent:
            return .readableContent
        }
    }
}
