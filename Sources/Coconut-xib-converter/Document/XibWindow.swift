//
//  XibWindow.swift
//  Coconut-xib-converter
//
//  Created by Dami on 24/10/2016.
//
//

import Foundation


public class XibWindow : XibObject {
    
    public let view: XibCustomView?
    
    init(id: String?, view: XibCustomView?) {
        self.view = view
        super.init(id: id)
    }
}
