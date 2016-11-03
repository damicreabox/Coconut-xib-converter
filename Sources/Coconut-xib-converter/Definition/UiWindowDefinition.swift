//
//  UiWindowDefinition.swift
//  Sample-coconut
//
//  Created by Dami on 02/11/2016.
//
//

import Foundation

class UiWindowDefinition : UiViewDefinition {
    
    var contentRect: NSRect
    var title: String
    
    override var viewType: UiViewType {
        get {
            return UiViewType.window
        }
    }
    
    init(id: String, view: UiViewDefinition?, contentRect: NSRect, customClass: String, title: String) {
        
        self.contentRect = contentRect
        self.title = title
        
        var views = [UiViewDefinition]()
        if let view = view {
            views.append(view)
        }
        
        super.init(id: id, subViews: views, customClass: customClass)
    }
}
