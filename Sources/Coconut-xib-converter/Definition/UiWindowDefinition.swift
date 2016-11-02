//
//  UiWindowDefinition.swift
//  Sample-coconut
//
//  Created by Dami on 02/11/2016.
//
//

import Foundation

class UiWindowDefinition : UiViewDefinition {
    
    var frame: NSRect?
    var title: String
    
    init(id: String, view: UiViewDefinition?, frame: NSRect?, customClass: String, title: String) {
        
        self.frame = frame
        self.title = title
        
        var views = [UiViewDefinition]()
        if let view = view {
            views.append(view)
        }
        
        super.init(id: id, subViews: views, customClass: customClass)
    }
}
