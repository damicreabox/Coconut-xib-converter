//
//  UiDefinitionFile.swift
//  Sample-coconut
//
//  Created by Dami on 02/11/2016.
//
//

import Foundation


class UiDefinitionFile {
    
    var name: String = "MyUi"
    var owner: CustomObjectDefinition? = nil
    var customObjects = [CustomObjectDefinition]()
    var views = [UiViewDefinition]()
    var window = [UiWindowDefinition]()
}
