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
    public let customClass : String
    public let frame : NSRect
    
    init(id: String?, view: XibCustomView?, frame: NSRect, customClass: String?) {
        self.view = view
        self.frame = frame
        self.customClass = customClass == nil ? "Window" : customClass!
        super.init(id: id)
    }
}
