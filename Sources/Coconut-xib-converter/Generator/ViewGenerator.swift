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
    func definition(view: XibCustomView, index: Int, to stream: OutputStream) -> Int {
        UIDefinitionWriter.write(line: "    private let view\(index): \(view.customClass)\n", to: stream)
        return index + 1
    }
    
    // Create méthode
    func methode(view: XibCustomView, index: Int, to stream: OutputStream) -> Int {
        UIDefinitionWriter.write(line: "    static func createView\(index)() -> View {\n", to: stream)
        UIDefinitionWriter.write(line: "        return View()\n", to: stream)
        UIDefinitionWriter.write(line: "    }\n", to: stream)
        return index + 1
    }
    
    // Definitions
    func instanciation(definition: XibDefinition, view: XibCustomView, index: Int, to stream: OutputStream) -> Int {
        UIDefinitionWriter.write(line: "        self.view\(index) = \(definition.name).createView\(index)()\n", to: stream)
        return index + 1
    }
}
