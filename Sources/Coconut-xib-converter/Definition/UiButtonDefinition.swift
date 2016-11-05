//
//  UiButtonDefinition.swift
//  Sample-coconut
//
//  Created by Dami on 02/11/2016.
//
//

import Foundation

class UiButtonDefinition : UiViewDefinition {
    
    override var viewType: UiViewType {
        get {
            return UiViewType.button
        }
    }
    
    init(id: String, vName: String, customClass: String = "Button") {
        super.init(id: id, uiDefinitionType: .button, vName: vName, customClass: customClass)
    }
}
