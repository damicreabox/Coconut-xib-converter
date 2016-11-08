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
        stream.write("Button(frame:")
        if let frame = definition.frame {
            stream.write(RectGenerator().newInstance(rect: frame))
        } else {
            stream.write("NSRect()")
        }
        stream.write(")")
    }
    
    
    override func generateAfter(definition: UiButtonDefinition, output stream: GeneratorStream) throws {
        
        // Set title
        stream.writeLine("\(definition.vName).title = \"\(definition.title)\"")
        
        if let actionDefinition = definition.action {
            try UiActionGenerator().generateVariable(caller: definition, action: actionDefinition, output: stream)
            stream.writeLine("\(definition.vName).action = \(actionDefinition.vName)")
        }
    }
}
