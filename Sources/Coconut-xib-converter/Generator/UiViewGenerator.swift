//
//  UiViewGenerator.swift
//  Coconut-xib-converter
//
//  Created by Dami on 03/11/2016.
//
//

import Foundation

class UiViewGenerator : UiViewGeneratorProtocol {
    
    var generators = Dictionary<UiViewType, UiViewGeneratorProtocol>()
    
    init() {
        generators[UiViewType.button] = UiButtonGenerator()
        generators[UiViewType.window] = UiWindowGenerator()
    }
    
    func createName(uiViewDefinition: UiViewDefinition) -> String {
        if (uiViewDefinition.index == nil) {
            return "view"
        } else {
            return "view\(uiViewDefinition.index!)"
        }
    }
    
    func generateAttributeDefinition(uiViewDefinition: UiViewDefinition, output stream: GeneratorStream) throws {
        if let generator = generators[uiViewDefinition.viewType] {
            try generator.generateAttributeDefinition(uiViewDefinition: uiViewDefinition, output: stream)
        } else {
            stream.writeLine("  public var \(createName(uiViewDefinition: uiViewDefinition)): View")
        }
    }
    
    func generateAttribute(uiViewDefinition: UiViewDefinition, output stream: GeneratorStream) throws {
        if let generator = generators[uiViewDefinition.viewType] {
            try generator.generateAttribute(uiViewDefinition: uiViewDefinition, output: stream)
        } else {
            let name = createName(uiViewDefinition: uiViewDefinition)
            stream.writeLine("      self.\(name) = View()")
            try generateView(uiViewDefinition: uiViewDefinition, output: stream)
        }
    }
    
    func generateVariable(uiViewDefinition: UiViewDefinition, output stream: GeneratorStream) throws{
        if let generator = generators[uiViewDefinition.viewType] {
            try generator.generateVariable(uiViewDefinition: uiViewDefinition, output: stream)
        } else {
            let name = createName(uiViewDefinition: uiViewDefinition)
            stream.writeLine("      var \(name) = View()")
            try generateView(uiViewDefinition: uiViewDefinition, output: stream)
        }
    }
    
    func generateView(uiViewDefinition: UiViewDefinition, output stream: GeneratorStream) throws {
        let name = createName(uiViewDefinition: uiViewDefinition)
        
        for subView in uiViewDefinition.views {
            
        }
    }
}
