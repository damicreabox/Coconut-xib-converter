//
//  UiWindowGenerator.swift
//  Coconut-xib-converter
//
//  Created by Dami on 03/11/2016.
//
//

import Foundation

class UiWindowGenerator : UiGenerator {
    
    func convert(definition: UiDefinitionObject) throws -> UiWindowDefinition {
        if let window = definition as? UiWindowDefinition {
            return window
        }
        
        throw GeneratorError.unknown(msg: "Unable to cast")
    }
    
    func generateAttributeDefinition(definition: UiDefinitionObject, output stream: GeneratorStream) throws {
        stream.writeLine("  public var \(definition.vName): Window")
    }
    
    func generateAttribute(definition: UiDefinitionObject, output stream: GeneratorStream) throws {
        
        let uiWindowDefinition = try convert(definition: definition)
        let name = definition.vName
        
        // Create window
        stream.writeLine("      let \(name)Frame = \(RectGenerator().newInstance(rect: uiWindowDefinition.contentRect))")
        stream.writeLine("      self.\(name) = Window(contentRect: \(name)Frame)")
        
        // Set title
        stream.writeLine("      \(name).title = \"\(uiWindowDefinition.title)\"")
        
        if let view = uiWindowDefinition.view {
            
            let generator = try UiGeneratorSelector.instance.findGenerator(definition: view)
            
            try generator.generateVariable(definition: view, output: stream)
            stream.writeLine("      \(name).contentView = \(view.vName)")
        }
    }

    func generateVariable(definition: UiDefinitionObject, output stream: GeneratorStream) throws {
        
    }

    func generateInstanciate(definition: UiDefinitionObject, output stream: GeneratorStream) throws {
        let uiWindowDefinition = try convert(definition: definition)
        stream.writeLine("      \(uiWindowDefinition.vName).makeKeyAndOrderFront(\(uiWindowDefinition.vName))")
    }

}
