//
//  UiWindowDefinition.swift
//  Sample-coconut
//
//  Created by Dami on 02/11/2016.
//
//

import Foundation

class UiWindowDefinition : UiDefinitionObject {
    
    var contentRect: NSRect
    var title: String
    var view : UiViewDefinition?
    
    init(id: String, vName: String, view: UiViewDefinition?, contentRect: NSRect, customClass: String, title: String) {
        
        self.contentRect = contentRect
        self.title = title
        self.view = view
        
        var views = [UiViewDefinition]()
        if let view = view {
            views.append(view)
        }
        
        super.init(id: id, uiDefinitionType: .window, vName: vName, customClass: customClass)
    }
}
