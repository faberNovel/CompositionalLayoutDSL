//
//  ContentInsetable.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 14/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

public protocol ContentInsetable {
    func contentInsets(_ insets: NSDirectionalEdgeInsets) -> Self
    func contentInsets(value: CGFloat) -> Self
    func contentInsets(horizontal: CGFloat, vertical: CGFloat) -> Self
    func contentInsets(
        top: CGFloat,
        leading: CGFloat,
        bottom: CGFloat,
        trailing: CGFloat
    ) -> Self
}

public extension ContentInsetable {
    func contentInsets(_ insets: NSDirectionalEdgeInsets) -> Self {
        return contentInsets(
            top: insets.top,
            leading: insets.leading,
            bottom: insets.bottom,
            trailing: insets.trailing
        )
    }

    func contentInsets(value: CGFloat) -> Self {
        return contentInsets(top: value, leading: value, bottom: value, trailing: value)
    }

    func contentInsets(horizontal: CGFloat = 0, vertical: CGFloat = 0) -> Self {
        return contentInsets(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }
}

internal protocol HasContentInsetProperties {
    var contentInsets: NSDirectionalEdgeInsets { get set }
}

extension HasContentInsetProperties {

    public func contentInsets(
        top: CGFloat = 0,
        leading: CGFloat = 0,
        bottom: CGFloat = 0,
        trailing: CGFloat = 0
    ) -> Self {
        with(self) {
            $0.contentInsets = NSDirectionalEdgeInsets(
                top: top,
                leading: leading,
                bottom: bottom,
                trailing: trailing
            )
        }
    }
}
