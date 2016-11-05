//
//  UiButtonGenerator.swift
//  Coconut-xib-converter
//
//  Created by Dami on 03/11/2016.
//
//

import Foundation

class UiButtonGenerator : UiGenerator {
    
    func convert(definition: UiDefinitionObject) throws -> UiButtonDefinition {
        if let window = definition as? UiButtonDefinition {
            return window
        }
        
        throw GeneratorError.unknown(msg: "Unable to cast")
    }
    
    func generateAttributeDefinition(definition: UiDefinitionObject, output stream: GeneratorStream) throws {
        stream.writeLine("  public var \(definition.vName): Button")
    }
    
    func generateAttribute(definition: UiDefinitionObject, output stream: GeneratorStream) throws {
        try generateButton(prefix: "self.", definition: definition, output: stream)
    }
    
    func generateVariable(definition: UiDefinitionObject, output stream: GeneratorStream) throws {
        try generateButton(prefix: "let ", definition: definition, output: stream)
    }
    
    func generateButton(prefix: String, definition: UiDefinitionObject, output stream: GeneratorStream) throws {
        let uiButtonDefinition = try convert(definition: definition)
        
        if let actionDefinition = uiButtonDefinition.action {
            stream.writeLine("      let \(actionDefinition.vName) = EmptyAction()")
        }
        
        stream.write("      \(prefix)\(definition.vName) = Button(title: \"\(uiButtonDefinition.title)\"")
        
        if let actionDefinition = uiButtonDefinition.action {
            stream.write(", action: \(actionDefinition.vName)")
        }
        
        stream.writeLine(")")
    }
    
    func generateInstanciate(definition: UiDefinitionObject, output stream: GeneratorStream) throws {
        
        
    }
}
