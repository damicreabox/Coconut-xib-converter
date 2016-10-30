//
//  XibCustomObject.swift
//  Coconut-xib-converter
//
//  Created by Dami on 16/10/2016.
//
//

import Foundation

public class XibCustomObject : XibObject {
    
    public let name: String
    public let customClass: String
    
    init(id: String?, name: String?, customClass: String?) {
        self.name = name == nil ? swiftId(id: id) : name!
        self.customClass = customClass == nil ? "NSObject" : customClass!
        super.init(id: id)
    }
}
