//
//  UiWindowGenerator.swift
//  Coconut-xib-converter
//
//  Created by Dami on 03/11/2016.
//
//

import Foundation

class UiWindowGeneratorDelegate : UIObjectGeneratorDelegate<UiWindowDefinition> {
    
    init() {
        super.init(useAfter: true)
    }
    
    override func generateBefore(definition: UiWindowDefinition, output stream: GeneratorStream) throws {
        stream.writeLine("let \(definition.vName)Frame = \(RectGenerator().newInstance(rect: definition.contentRect))")
    }
    
    override func generateInstanciation(definition: UiWindowDefinition, output stream: GeneratorStream) throws {
        stream.write("Window(contentRect: \(definition.vName)Frame)")
    }
    
    override func generateAfter(definition: UiWindowDefinition, output stream: GeneratorStream) throws {
        
        // Set title
        stream.writeLine("\(definition.vName).title = \"\(definition.title)\"")
        
        if let view = definition.view {
            
            let generator = try UiGeneratorSelector.instance.findGenerator(definition: view)
            
            try generator.generateVariable(definition: view, output: stream)
            stream.writeLine("\(definition.vName).contentView = \(view.vName)")
        }
        stream.writeLine("\(definition.vName).makeKeyAndOrderFront(\(definition.vName))")
    }
}
