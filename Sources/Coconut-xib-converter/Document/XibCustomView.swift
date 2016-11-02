//
//  XibView.swift
//  Coconut-xib-converter
//
//  Created by Dami on 16/10/2016.
//
//

import Foundation

public class XibCustomView : XibObject {
    
    public let subViews: [XibCustomView]
    public let customClass : String
    
    init(id: String?, subViews: [XibCustomView] = [XibCustomView](), customClass: String?) {
        self.subViews = subViews
        self.customClass = customClass == nil ? "View" : customClass!
        super.init(id: id)
    }
}
