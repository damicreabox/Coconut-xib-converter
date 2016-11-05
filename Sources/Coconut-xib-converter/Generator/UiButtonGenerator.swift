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
        stream.write("      self.\(definition.vName)")
        try generateButton(definition: definition, output: stream)
    }
    
    func generateVariable(definition: UiDefinitionObject, output stream: GeneratorStream) throws {
        stream.write("      var \(definition.vName)")
        try generateButton(definition: definition, output: stream)
    }
    
    func generateButton(definition: UiDefinitionObject, output stream: GeneratorStream) throws {
        let uiButtonDefinition = try convert(definition: definition)
        stream.writeLine(" = Button(title: \"\(uiButtonDefinition.id)\", action: EmptyAction())")
    }
    
    func generateInstanciate(definition: UiDefinitionObject, output stream: GeneratorStream) throws {
        
        
    }
}
