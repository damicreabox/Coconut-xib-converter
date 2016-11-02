//
//  CustomObjectGenerator.swift
//  Coconut-xib-converter
//
//  Created by Dami on 25/10/2016.
//
//

import Foundation


class CustomObjectGenerator {
    
    // Write objects
    func attributeDefinition(object: CustomObjectDefinition, to stream: OutputStream) {
        
        // Si First responder ou application
        if (object.id == "-1" || object.id == "-3") {
            return
        }
        
        // Si owner
        if (object.id == "-2") {
            UIDefinitionWriter.write(line: "    public var owner: \(object.customClass)? = nil\n", to: stream)
        } else {
            UIDefinitionWriter.write(line: "    public var \(object.name) = \(object.customClass)()\n", to: stream)
        }
        
    }
    
    func attributeConnection(object: CustomObjectDefinition, index: Int, to stream: OutputStream) {
        
        // Si first responder ou application
        if (object.id == "-1" || object.id == "-3") {
            return
        }
        
        // Si owner
        if (object.id == "-2") {
            
            let attrName = "self.owner"
            
            UIDefinitionWriter.write(line: "        if let object = objects?[\(index)] as? \(object.customClass) { \n", to: stream)
            UIDefinitionWriter.write(line: "            \(attrName) = object\n", to: stream)
            UIDefinitionWriter.write(line: "        } else {\n", to: stream)
            UIDefinitionWriter.write(line: "            NSLog(\"\\\"\(object.name)\\\" not an \\\"\(object.customClass)\\\"\")\n", to: stream)
            UIDefinitionWriter.write(line: "        }\n", to: stream)
        }
    }
}
