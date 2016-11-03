//
//  UIDefinitionWriter.swift
//  Coconut-xib-converter
//
//  Created by Dami on 23/10/2016.
//
//

import Foundation

enum ConverterError : Error {
    case unknowError(msg: String)
}

public class UIDefinitionWriter {
    
    private let uiDefinition: UiDefinitionFile
    
    init(uiDefinition: UiDefinitionFile) {
        self.uiDefinition = uiDefinition
    }
    
    internal static func write(line: String, to stream: OutputStream) {
        let encodedDataArray = [UInt8](line.utf8)
        stream.write(encodedDataArray, maxLength: encodedDataArray.count)
    }
        
    // -------------------
    
    public func write(at url: URL) throws {
        
        // Custom generator
        let customObjectGenerator = CustomObjectGenerator()
        
        // View generator
        let viewGenerator = ViewGenerator()
        
        
        // FIXME Test directory
        
        // UI file
        let uiFile = uiDefinition.name
        
        let xibFile = url.appendingPathComponent("\(uiFile).swift")
        
        guard let stream = OutputStream(toFileAtPath: xibFile.path, append: false) else {
            throw ConverterError.unknowError(msg: "Unable to open directory \(url.path)")
        }
        
        // Create file
        stream.open()
        
        // Write header
        UIDefinitionWriter.write(line: "import Foundation\n", to: stream)
        UIDefinitionWriter.write(line: "import Coconut\n", to: stream)
        UIDefinitionWriter.write(line: "public class \(uiFile) : UIDefinitionDelegate {\n", to: stream)
        UIDefinitionWriter.write(line: "    public let application: Application\n", to: stream)
        UIDefinitionWriter.write(line: "    public let firstResponder: Responder\n", to: stream)
        
        for object in uiDefinition.customObjects {
            customObjectGenerator.attributeDefinition(object: object, to: stream)
        }
        
        index = 0
        for view in uiDefinition.views {
            viewGenerator.attributeDefinition(view: view, index: index, to: stream)
            index = index + 1
        }
        
        UIDefinitionWriter.write(line: "    init() {\n", to: stream)
        UIDefinitionWriter.write(line: "        self.application = Application.shared()\n", to: stream)
        UIDefinitionWriter.write(line: "        self.firstResponder = application\n", to: stream)
  
        index = 0
        for view in uiDefinition.views {
            viewGenerator.createAttributeView(definition: uiDefinition, viewDefinition: view, index: index, to: stream)
            index = index + 1
        }
        
        UIDefinitionWriter.write(line: "    }\n", to: stream)
        UIDefinitionWriter.write(line: "    public func instantiate(owner: Any?, objects: [NSObjectProtocol]?) -> Bool {\n", to: stream)
        
        index = 0
        for object in uiDefinition.customObjects {
            customObjectGenerator.attributeConnection(object: object, index: index, to: stream)
            index = index + 1
        }
        
        index = 0
        for viewDefinition in uiDefinition.views {
            viewGenerator.createVariableView(viewDefinition: viewDefinition, index: index, to: stream)
            index = index + 1
        }
        
        UIDefinitionWriter.write(line: "        return true\n", to: stream)
        UIDefinitionWriter.write(line: "    }\n", to: stream)
        UIDefinitionWriter.write(line: "}\n", to: stream)
        
        // Close
        stream.close()

    }
}
