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
    func definition(object: XibCustomObject, to stream: OutputStream) {
        
        // Si First responder ou application
        if (object.id == "-1" || object.id == "-3") {
            return
        }
        
        // Si owner
        let attrName: String
        if (object.id == "-2") {
            attrName = "owner"
        } else {
            attrName = object.name
        }
        
        UIDefinitionWriter.write(line: "    private var \(attrName): \(object.customClass)? = nil\n", to: stream)
    }
    
    func connection(object: XibCustomObject, index: Int, to stream: OutputStream) -> Int {
        
        // Si first responder ou application
        if (object.id == "-1" || object.id == "-3") {
            return index
        }
        
        // Si owner
        let attrName: String
        if (object.id == "-2") {
            attrName = "self.owner"
        } else {
            attrName = object.name
        }
        
        
        UIDefinitionWriter.write(line: "        if let object = objects?[\(index)] as? \(object.customClass) { \n", to: stream)
        UIDefinitionWriter.write(line: "            \(attrName) = object\n", to: stream)
        UIDefinitionWriter.write(line: "        } else {\n", to: stream)
        UIDefinitionWriter.write(line: "            NSLog(\"\\\"\(object.name)\\\" not an \\\"\(object.customClass)\\\"\")\n", to: stream)
        UIDefinitionWriter.write(line: "        }\n", to: stream)
        
        return index + 1
    }
}
