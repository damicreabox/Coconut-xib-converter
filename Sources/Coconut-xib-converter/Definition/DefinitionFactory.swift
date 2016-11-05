//
//  DefinitionFactory.swift
//  Coconut-xib-converter
//
//  Created by Dami on 05/11/2016.
//
//

import Foundation

class DefinitionFactory {
    
    static let instance = DefinitionFactory()
    
    private init() {
        
    }
    
    var elements = Dictionary<String, UiDefinition>()
    
    private var windowCount = -1
    private var viewCount = -1
    private var buttonCount = -1
    private var objectCount = -1
    
    private func registerDefinition<T: UiDefinition>(definition: T) -> T {
        elements[definition.id] = definition
        return definition
    }
    
    public func getDefinition(id: String) -> UiDefinition? {
        return elements[id]
    }
    
    func window(id: String) -> UiWindowDefinition {
        windowCount = windowCount + 1
        let definition = UiWindowDefinition(id: id, vName: "window\(windowCount)")
        return registerDefinition(definition: definition)
    }
    
    func view(id: String) -> UiViewDefinition {
        viewCount = viewCount + 1
        let definition = UiViewDefinition(id: id, vName: "view\(viewCount)")
        return registerDefinition(definition: definition)
    }
    
    func button(id: String) -> UiButtonDefinition {
        buttonCount = buttonCount + 1
        let definition = UiButtonDefinition(id: id, vName: "button\(buttonCount)")
        return registerDefinition(definition: definition)
    }
    
    func customObject(id: String) -> CustomObjectDefinition {
        objectCount = objectCount + 1
        let definition = CustomObjectDefinition(id: id, vName: "cutomObject\(objectCount)")
        return registerDefinition(definition: definition)
    }
    
    func action(id: String) -> UiActionDefinition {
        objectCount = objectCount + 1
        let definition = UiActionDefinition(id: id, vName: "cutomObject\(objectCount)")
        return registerDefinition(definition: definition)
    }
}
