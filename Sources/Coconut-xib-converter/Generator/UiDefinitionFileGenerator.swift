//
//  UiDefinitionFileGenerator.swift
//  Coconut-xib-converter
//
//  Created by Dami on 03/11/2016.
//
//

import Foundation


class UiDefinitionFileGenerator {
    
    func generate(uiDefinitionFile: UiDefinitionFile, at url: URL) throws {
        
        // UI file
        let uiFile = uiDefinitionFile.name
        
        let xibFile = url.appendingPathComponent("\(uiFile).swift")
        
        guard let stream = OutputStream(toFileAtPath: xibFile.path, append: false) else {
            throw GeneratorError.unknown(msg: "Unable to open directory \(url.path)")
        }
        
        // Create file
        stream.open()
        
        // Create generator stream
        let genStream = GeneratorStream(output: stream)
        
        // Create to stream
        try generate(uiDefinitionFile: uiDefinitionFile, to: genStream)
        
        // Close
        stream.close()
    }
    
    func generate(uiDefinitionFile: UiDefinitionFile, to stream: GeneratorStream) throws {
        
        
        stream.writeLine("import Foundation")
        stream.writeLine("import Coconut")
        
        stream.writeEmptyLine()
        
        stream.writeLine("public class \(uiDefinitionFile.name) : UIDefinitionDelegate {")
        stream.writeEmptyLine()
        
        // Add indent
        stream.pushIndent()
        
        // Application -3
        if let applicationDefinition = DefinitionFactory.instance.getDefinition(id: "-3")  {
            stream.writeLine("public let \(applicationDefinition.vName): \(applicationDefinition.customClass)")
        }
        
        
        // First responder -1
        if let firstResponderDefinition = DefinitionFactory.instance.getDefinition(id: "-1")  {
            stream.writeLine("public var \(firstResponderDefinition.vName): \(firstResponderDefinition.customClass)? = nil")
        }
       
        // Owner
        if let ownerDefinition = DefinitionFactory.instance.getDefinition(id: "-2")  {
            stream.writeLine("public var \(ownerDefinition.vName): \(ownerDefinition.customClass)? = nil")
        }
        stream.writeEmptyLine()
        
        // Write windows
        for windowDefinition in uiDefinitionFile.window {
            try UiGeneratorSelector.instance.findGenerator(definition: windowDefinition).generateAttributeDefinition(definition: windowDefinition, output: stream)
        }
        
        // Write views
        for viewDefinition in uiDefinitionFile.views {
            try UiGeneratorSelector.instance.findGenerator(definition: viewDefinition).generateAttributeDefinition(definition: viewDefinition, output: stream)
        }
        
        stream.writeEmptyLine()
        
        stream.writeLine("init() {")
        
        // Add indent
        stream.pushIndent()
        
        // Application -3
        if let applicationDefinition = DefinitionFactory.instance.getDefinition(id: "-3")  {
            stream.writeLine("self.\(applicationDefinition.vName) = Application.shared()")
        }
        // First responder -1
        if let firstResponderDefinition = DefinitionFactory.instance.getDefinition(id: "-1")  {
            stream.writeLine("self.\(firstResponderDefinition.vName) = FirstResponder()")
        }
        
        // Remove indent
        stream.popIndent()
        
        stream.writeLine("}")
        stream.writeEmptyLine()
        
        stream.writeLine("public func instantiate(owner: Any?, objects: [NSObjectProtocol]?) -> Bool {")
        
        // Add indent
        stream.pushIndent()
        
        // Find owner definition
        if let owner = uiDefinitionFile.owner {
        
            stream.writeLine("if let object = owner as? \(owner.customClass) {")
            stream.writeLine("    self.\(owner.vName) = object")
            stream.writeLine("} else {")
            stream.writeLine("    NSLog(\"\\\"\(owner.vName)\\\" not an \\\"\(owner.customClass)\\\"\")")
            stream.writeLine("}")
        }
        
        // Write views
        for windowDefinition in uiDefinitionFile.window {
            stream.writeEmptyLine()
            try UiGeneratorSelector.instance.findGenerator(definition: windowDefinition).generateAttribute(definition: windowDefinition, output: stream)
        }
        
        // Write views
        for viewDefinition in uiDefinitionFile.views {
            stream.writeEmptyLine()
            try UiGeneratorSelector.instance.findGenerator(definition: viewDefinition).generateAttribute(definition: viewDefinition, output: stream)
        }
        
        stream.writeLine("return true")
        
        
        // Remove indent
        stream.popIndent()
        
        stream.writeLine("}")
        stream.writeEmptyLine()
        
        // Remove indent
        stream.popIndent()
        
        stream.writeLine("}")
    }
}
