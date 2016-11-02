//
//  ViewGenerator.swift
//  Coconut-xib-converter
//
//  Created by Dami on 25/10/2016.
//
//

import Foundation

class ViewGenerator {
    
    
    // ------ Views ------
    
    // Definitions
    func attributeDefinition(view: UiViewDefinition, index: Int, to stream: OutputStream) {
        UIDefinitionWriter.write(line: "    public let view\(index): \(view.customClass)\n", to: stream)
    }
    
    
    func createAttributeView(definition: UiDefinitionFile, viewDefinition: UiViewDefinition, index: Int, to stream: OutputStream) {
        let name = "self.view\(index)"
        UIDefinitionWriter.write(line: "        \(name) = ", to: stream)
        createView(viewDefinition: viewDefinition, name: name, to: stream)
    }
    
    func createVariableView(viewDefinition: UiViewDefinition, index: Int, to stream: OutputStream) {
        let name = "view\(index)"
        UIDefinitionWriter.write(line: "        var \(name) = ", to: stream)
        createView(viewDefinition: viewDefinition, name: name, to: stream)
    }
    
    private func createView(viewDefinition: UiViewDefinition, name: String, to stream: OutputStream) {
        UIDefinitionWriter.write(line: "\(viewDefinition.customClass)()\n", to: stream)
    }
}
