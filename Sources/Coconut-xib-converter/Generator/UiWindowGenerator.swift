//
//  UiWindowGenerator.swift
//  Coconut-xib-converter
//
//  Created by Dami on 03/11/2016.
//
//

import Foundation

class UiWindowGenerator : UiViewGeneratorProtocol {
    
    func createName(uiViewDefinition: UiViewDefinition) -> String {
        if (uiViewDefinition.index == nil) {
            return "window"
        } else {
            return "window\(uiViewDefinition.index!)"
        }
    }
    
    func generateAttributeDefinition(uiViewDefinition: UiViewDefinition, output stream: GeneratorStream) throws {
        stream.writeLine("  public var \(createName(uiViewDefinition: uiViewDefinition)): Window")
    }
    
    func generateAttribute(uiViewDefinition: UiViewDefinition, output stream: GeneratorStream) throws {
        
        guard let uiWindowDefinition = uiViewDefinition as? UiWindowDefinition else {
            throw GeneratorError.unknown(msg: "")
        }
        
        let name = createName(uiViewDefinition: uiViewDefinition)
        
        stream.writeLine("      let \(name)Frame = \(RectGenerator().newInstance(rect: uiWindowDefinition.contentRect))")
        stream.writeLine("      self.\(name) = Window(contentRect: \(name)Frame)")
    }
    
    func generateVariable(uiViewDefinition: UiViewDefinition, output stream: GeneratorStream) throws {
        
        guard let uiWindowDefinition = uiViewDefinition as? UiWindowDefinition else {
            throw GeneratorError.unknown(msg: "")
        }
        
        let name = createName(uiViewDefinition: uiViewDefinition)
        
        stream.writeLine("      let \(name)Frame = \(RectGenerator().newInstance(rect: uiWindowDefinition.contentRect))")
        stream.writeLine("      var \(name) = Window(contentRect: \(name)Frame)")
    }
}
