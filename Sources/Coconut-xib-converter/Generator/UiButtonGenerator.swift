//
//  UiButtonGenerator.swift
//  Coconut-xib-converter
//
//  Created by Dami on 03/11/2016.
//
//

import Foundation

class UiButtonGenerator : UiViewGeneratorProtocol {
    
    func createName(uiViewDefinition: UiViewDefinition) -> String {
        if (uiViewDefinition.index == nil) {
            return "button"
        } else {
            return "button\(uiViewDefinition.index!)"
        }
    }
    
    func generateAttributeDefinition(uiViewDefinition: UiViewDefinition, output stream: GeneratorStream) {
        stream.writeLine("  public var \(createName(uiViewDefinition: uiViewDefinition)): Button")
    }
    
    func generateAttribute(uiViewDefinition: UiViewDefinition, output stream: GeneratorStream){
        let name = createName(uiViewDefinition: uiViewDefinition)
        stream.writeLine("      self.\(name) = Button()")
    }
    
    func generateVariable(uiViewDefinition: UiViewDefinition, output stream: GeneratorStream){
        let name = createName(uiViewDefinition: uiViewDefinition)
        stream.writeLine("      var \(name) = Button()")
    }
}
