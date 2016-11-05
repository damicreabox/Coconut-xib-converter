//
//  UiButtonGenerator.swift
//  Coconut-xib-converter
//
//  Created by Dami on 03/11/2016.
//
//

import Foundation

class UiButtonGeneratorDelegate : UIObjectGeneratorDelegate<UiButtonDefinition> {
    
    
    override func generateBefore(definition: UiButtonDefinition, output stream: GeneratorStream) throws {
        
        if let actionDefinition = definition.action {
            try UiActionGenerator().generateVariable(definition: actionDefinition, output: stream)
        }
    }
    
    override func generateInstanciation(definition: UiButtonDefinition, output stream: GeneratorStream) throws {
        
        stream.write("Button(title: \"\(definition.title)\"")
        
        if let actionDefinition = definition.action {
            stream.write(", action: \(actionDefinition.vName)")
        }
        
        stream.write(")")
    }
}
