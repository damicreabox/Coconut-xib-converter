//
//  UiActionGenerator.swift
//  Coconut-xib-converter
//
//  Created by Dami on 05/11/2016.
//
//

import Foundation

class UiActionGenerator : UiGenerator {
    
    func convert(definition: UiDefinition) throws -> UiActionDefinition {
        if let action = definition as? UiActionDefinition {
            return action
        }
        
        throw GeneratorError.unknown(msg: "Unable to cast")
    }
    
    func generateAttributeDefinition(definition: UiDefinition, output stream: GeneratorStream) throws {
        
    }
    
    func generateAttribute(definition: UiDefinition, output stream: GeneratorStream) throws {
        
    }
    
    private func encodeSelector(selector: String) -> String {
        return selector.replacingOccurrences(of: ":", with: "(object)")
    }
    
    func generateVariable(definition: UiDefinition, output stream: GeneratorStream) throws {
        
        let actionDefinition = try convert(definition: definition)
        
        if let targetDefinition = actionDefinition.target, let selector = actionDefinition.selector {
            stream.writeLine("let \(definition.vName) = OjectAction<\(targetDefinition.customClass)>(object: \(targetDefinition.vName)!) { object in object.\(encodeSelector(selector: selector)) }")
        }
    }
    
    func generateInstanciate(definition: UiDefinition, output stream: GeneratorStream) throws {
        
    }
}
