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
        
        stream.writeLine("  public let application: Application")
        stream.writeLine("  public let firstResponder: Responder")
        stream.writeLine("  public var owner: NSObject? = nil")
        stream.writeEmptyLine()
        
        // Write windows
        for windowDefinition in uiDefinitionFile.window {
            try UiGeneratorSelector.instance.findGenerator(definition: windowDefinition).generateAttributeDefinition(definition: windowDefinition, output: stream)
        }
        
        // Write views
        for viewDefinition in uiDefinitionFile.views {
            try UiGeneratorSelector.instance.findGenerator(definition: viewDefinition).generateAttributeDefinition(definition: viewDefinition, output: stream)
        }
        
        stream.writeLine("  ")
        
        stream.writeLine("  init() {")
        stream.writeLine("      self.application = Application.shared()")
        stream.writeLine("      self.firstResponder = application")
        
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
        
        stream.writeLine("  }")
        stream.writeEmptyLine()
        
        stream.writeLine("  public func instantiate(owner: Any?, objects: [NSObjectProtocol]?) -> Bool {")
        
        // Find owner definition
        if let owner = uiDefinitionFile.owner {
        
            stream.writeLine("      if let object = owner as? \(owner.customClass) {")
            stream.writeLine("          self.owner = object")
            stream.writeLine("      } else {")
            stream.writeLine("          NSLog(\"\\\"owner\\\" not an \\\"\(owner.customClass)\\\"\")")
            stream.writeLine("      }")
        }
        
        // Write windows
        for windowDefinition in uiDefinitionFile.window {
            stream.writeEmptyLine()
            try UiGeneratorSelector.instance.findGenerator(definition: windowDefinition).generateInstanciate(definition: windowDefinition, output: stream)
        }
        
        // Write views
        for viewDefinition in uiDefinitionFile.views {
            stream.writeEmptyLine()
            try UiGeneratorSelector.instance.findGenerator(definition: viewDefinition).generateInstanciate(definition: viewDefinition, output: stream)
        }
        
        stream.writeLine("      return true")
        stream.writeLine("  }")
        stream.writeEmptyLine()
        
        stream.writeLine("}")
    }
}
