//
//  UiViewGenerator.swift
//  Coconut-xib-converter
//
//  Created by Dami on 03/11/2016.
//
//

import Foundation

class UiViewGenerator : UiGenerator {
    
    func convert(definition: UiDefinitionObject) throws -> UiViewDefinition {
        if let view = definition as? UiViewDefinition {
            return view
        }
        
        throw GeneratorError.unknown(msg: "Unable to cast")
    }
    
    func generateAttributeDefinition(definition: UiDefinitionObject, output stream: GeneratorStream) throws {
        stream.writeLine("  public var \(definition.vName)): View")
    }
    
    func generateAttribute(definition: UiDefinitionObject, output stream: GeneratorStream) throws {
        let name = definition.vName
        stream.write("      self.\(name)")
        try generateView(definition: definition, output: stream)

    }
    
    func generateVariable(definition: UiDefinitionObject, output stream: GeneratorStream) throws {
        let name = definition.vName
        stream.write("      let \(name)")
        try generateView(definition: definition, output: stream)
    }
    
    func generateInstanciate(definition: UiDefinitionObject, output stream: GeneratorStream) throws {
    }
    
    // --- Generate view content ---
    
    func generateView(definition: UiDefinitionObject, output stream: GeneratorStream) throws {
        stream.writeLine(" = View()")
        let view = try convert(definition: definition)
        for subView in view.views {
            let generator = try UiGeneratorSelector.instance.findGenerator(definition: subView)
            try generator.generateVariable(definition: subView, output: stream)
            stream.writeLine("      \(view.vName).addSubview(\(subView.vName))")
        }
    }
    
}
