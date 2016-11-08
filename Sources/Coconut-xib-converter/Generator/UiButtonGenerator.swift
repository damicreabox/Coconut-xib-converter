//
//  UiButtonGenerator.swift
//  Coconut-xib-converter
//
//  Created by Dami on 03/11/2016.
//
//

import Foundation

class UiButtonGeneratorDelegate : UIObjectGeneratorDelegate<UiButtonDefinition> {
    
    init() {
        super.init(useAfter: true)
    }
    
    override func generateInstanciation(definition: UiButtonDefinition, output stream: GeneratorStream) throws {
        stream.write("Button(title: \"\(definition.title)\")")
    }
    
    
    override func generateAfter(definition: UiButtonDefinition, output stream: GeneratorStream) throws {
        
        if let actionDefinition = definition.action {
            try UiActionGenerator().generateVariable(caller: definition, action: actionDefinition, output: stream)
            stream.writeLine("\(definition.vName).action = \(actionDefinition.vName)")
        }
    }
}
