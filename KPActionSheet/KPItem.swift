//
//  KPMenuViewItem.swift
//  KPActionSheet
//
//  Created by Khuong Pham on 2/25/17.
//  Copyright © 2017 fantageek. All rights reserved.
//

import Foundation

public struct KPItem {
    
    public enum ItemType {
        case Normal
        case Cancel
    }
    
    public typealias TapHandler = (() -> ())
    
    public var title: String? = nil
    public var type: ItemType = .Normal
    public var tapHandler: TapHandler?
    
    public init(title: String?, onTap tapHandler: TapHandler?) {
        self.title = title
        self.tapHandler = tapHandler
    }
    
    public init(title: String?, type: ItemType) {
        self.title = title
        self.type = type
    }
}
