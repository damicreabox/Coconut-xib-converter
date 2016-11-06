//
//  UiActionGenerator.swift
//  Coconut-xib-converter
//
//  Created by Dami on 05/11/2016.
//
//

import Foundation

class UiActionGenerator {
    
    func convert(definition: UiDefinition) throws -> UiActionDefinition {
        if let action = definition as? UiActionDefinition {
            return action
        }
        
        throw GeneratorError.unknown(msg: "Unable to cast")
    }
    
    private func encodeSelector(definition: UiDefinition, selector: String) -> String {
        return selector.replacingOccurrences(of: ":", with: "(\(definition.vName))")
    }
    
    func generateVariable(caller: UiDefinition, action: UiActionDefinition, output stream: GeneratorStream) throws {
        
        let actionDefinition = try convert(definition: action)
        
        if let targetDefinition = actionDefinition.target, let selector = actionDefinition.selector {
            
            stream.write("let \(action.vName) = OjectAction<\(caller.customClass),\(targetDefinition.customClass)>(")
            stream.write("caller: \(caller.vName),")
            stream.write("target: \(targetDefinition.vName)!")
            stream.write(") {")
            stream.write("caller, target in target.\(encodeSelector(definition: caller, selector: selector))")
            stream.writeLine("}")
        }
    }
}
