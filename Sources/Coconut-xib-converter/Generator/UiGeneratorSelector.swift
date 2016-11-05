//
//  UiGeneratorSelector.swift
//  Coconut-xib-converter
//
//  Created by Dami on 05/11/2016.
//
//

import Foundation

protocol UiGenerator {
    
    func generateAttributeDefinition(definition: UiDefinitionObject, output stream: GeneratorStream) throws
    func generateAttribute(definition: UiDefinitionObject, output stream: GeneratorStream) throws
    func generateVariable(definition: UiDefinitionObject, output stream: GeneratorStream) throws
    func generateInstanciate(definition: UiDefinitionObject, output stream: GeneratorStream) throws
}

class UiGeneratorSelector {
    
    static let instance = UiGeneratorSelector()
    
    private var generators = Dictionary<UiDefinitionType, UiGenerator>()
    
    private init() {
        //generators[UiDefinitionType.customObject] = CustomObjectGenerator()
        generators[UiDefinitionType.window] = UiWindowGenerator()
        generators[UiDefinitionType.view] = UiViewGenerator()
        generators[UiDefinitionType.button] = UiButtonGenerator()
    }
    
    func findGenerator(definition: UiDefinitionObject) throws -> UiGenerator {
        
        if let generator = generators[definition.uiDefinitionType] {
            return generator
        }
        
        throw GeneratorError.unknown(msg: "Unknow generator")
    }
}
