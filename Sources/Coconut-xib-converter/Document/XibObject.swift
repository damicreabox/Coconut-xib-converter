//
//  XibObject.swift
//  Coconut-xib-converter
//
//  Created by Dami on 16/10/2016.
//
//

import Foundation

public class XibObject {
    public let id: String
    init(id: String?) {
        self.id = id == nil ? "" : id!
    }
}
