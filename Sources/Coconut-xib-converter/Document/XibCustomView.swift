//
//  XibView.swift
//  Coconut-xib-converter
//
//  Created by Dami on 16/10/2016.
//
//

import Foundation

public class XibCustomView : XibObject {
    
    public let subViews: [XibObject]
    
    init(id: String?, subViews: [XibObject]) {
        self.subViews = subViews
        super.init(id: id)
    }
}
