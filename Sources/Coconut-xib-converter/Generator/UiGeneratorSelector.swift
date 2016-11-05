//
//  UiGeneratorSelector.swift
//  Coconut-xib-converter
//
//  Created by Dami on 05/11/2016.
//
//

import Foundation

protocol UiGenerator {
    func generateAttributeDefinition(definition: UiDefinition, output stream: GeneratorStream) throws
    func generateAttribute(definition: UiDefinition, output stream: GeneratorStream) throws
    func generateVariable(definition: UiDefinition, output stream: GeneratorStream) throws
}

class UIObjectGeneratorDelegate<O : UiDefinitionObject> {
    
    func generateBefore(definition: O, output stream: GeneratorStream) throws {
        
    }
    
    func generateInstanciation(definition: O, output stream: GeneratorStream) throws {
        stream.writeLine("\(definition.customClass)()")
    }
    
    func generateAfter(definition: O, output stream: GeneratorStream) throws {
        
    }
}

class UIObjectGenerator<O : UiDefinitionObject> : UiGenerator {
    
    private let delegate : UIObjectGeneratorDelegate<O>
    
    init(delegate : UIObjectGeneratorDelegate<O>) {
        self.delegate = delegate
    }
    
    func convert(definition: UiDefinition) throws -> O {
        if let newDefinition = definition as? O {
            return newDefinition
        }
        
        throw GeneratorError.unknown(msg: "Unable to cast")
    }
    
    func generateAttributeDefinition(definition: UiDefinition, output stream: GeneratorStream) throws {
        stream.writeLine("public var \(definition.vName): \(definition.customClass)? = nil")
    }
    
    func generateAttribute(definition: UiDefinition, output stream: GeneratorStream) throws {
        
        let objectDefinition = try convert(definition: definition)
        
        try delegate.generateBefore(definition: objectDefinition, output: stream)
        stream.write("self.\(definition.vName) = ")
        try delegate.generateInstanciation(definition: objectDefinition, output: stream)
        stream.writeEmptyLine()
        
        stream.writeLine("if let \(definition.vName) = \(definition.vName) {")
        
        // Add indent
        stream.pushIndent()
        
        try delegate.generateAfter(definition: objectDefinition, output: stream)
        
        // remove indent
        stream.popIndent()
        
        stream.writeLine("}")
    }

    func generateVariable(definition: UiDefinition, output stream: GeneratorStream) throws {
        
        let objectDefinition = try convert(definition: definition)
        
        try delegate.generateBefore(definition: objectDefinition, output: stream)
        stream.write("let \(definition.vName) = ")
        try delegate.generateInstanciation(definition: objectDefinition, output: stream)
        stream.writeEmptyLine()
        try delegate.generateAfter(definition: objectDefinition, output: stream)
    }
}

class UiGeneratorSelector {
    
    static let instance = UiGeneratorSelector()
    
    private var generators = Dictionary<UiDefinitionType, UiGenerator>()
    
    private init() {
        //generators[UiDefinitionType.customObject] = CustomObjectGenerator()
        generators[UiDefinitionType.window] = UIObjectGenerator<UiWindowDefinition>(delegate: UiWindowGeneratorDelegate())
        generators[UiDefinitionType.view] = UIObjectGenerator<UiViewDefinition>(delegate: UiViewGeneratorDelegate())
        generators[UiDefinitionType.button] = UIObjectGenerator<UiButtonDefinition>(delegate: UiButtonGeneratorDelegate())
    }
    
    func findGenerator(definition: UiDefinitionObject) throws -> UiGenerator {
        
        if let generator = generators[definition.uiDefinitionType] {
            return generator
        }
        
        throw GeneratorError.unknown(msg: "Unknow generator")
    }
}
