//
//  UIDefinitionWriter.swift
//  Coconut-xib-converter
//
//  Created by Dami on 23/10/2016.
//
//

import Foundation

public class UIDefinitionWriter {
    
    private let xibDefinition: XibDefinition
    
    init(xibDefinition: XibDefinition) {
        self.xibDefinition = xibDefinition
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
        
        // Window generator
        let windowGenerator = WindowGenerator()
        
        
        // FIXME Test directory
        
        // UI file
        let uiFile = xibDefinition.name
        
        let xibFile = url.appendingPathComponent("\(uiFile).swift")
        
        guard let stream = OutputStream(toFileAtPath: xibFile.path, append: false) else {
            throw ConverterError.unknowError(msg: "Unable to open directory \(url.path)")
        }
        
        // Create file
        stream.open()
        
        // Write header
        UIDefinitionWriter.write(line: "import Foundation\n", to: stream)
        UIDefinitionWriter.write(line: "public class \(uiFile) : UIDefinitionDelegate {\n", to: stream)
        UIDefinitionWriter.write(line: "    private let application: Application\n", to: stream)
        UIDefinitionWriter.write(line: "    private let firstResponder: Responder\n", to: stream)
        
        for object in xibDefinition.objects {
            customObjectGenerator.definition(object: object, to: stream)
        }
        
        var index = 0
        for window in xibDefinition.windows {
            index = windowGenerator.definition(window: window, index: index, to: stream)
        }
        
        index = 0
        for view in xibDefinition.views {
            index = viewGenerator.definition(view: view, index: index, to: stream)
        }
        
        index = 0
        for view in xibDefinition.views {
            index = viewGenerator.methode(view: view, index: index, to: stream)
        }
        
        UIDefinitionWriter.write(line: "    init() {\n", to: stream)
        UIDefinitionWriter.write(line: "        self.application = Application.shared()\n", to: stream)
        UIDefinitionWriter.write(line: "        self.firstResponder = application\n", to: stream)
        
        index = 0
        for window in xibDefinition.windows {
            index = windowGenerator.instanciation(window: window, index: index, to: stream)
        }
        
        index = 0
        for view in xibDefinition.views {
            index = viewGenerator.instanciation(definition: xibDefinition, view: view, index: index, to: stream)
        }
        
        UIDefinitionWriter.write(line: "    }\n", to: stream)
        UIDefinitionWriter.write(line: "    public func instantiate(owner: Any?, objects: [NSObjectProtocol]?) -> Bool {\n", to: stream)
        
        index = 0
        for object in xibDefinition.objects {
            index = customObjectGenerator.connection(object: object, index: index, to: stream)
        }
        
        index = 0
        for window in xibDefinition.windows {
            index = windowGenerator.display(window: window, index: index, to: stream)
        }
        
        UIDefinitionWriter.write(line: "        return true\n", to: stream)
        UIDefinitionWriter.write(line: "    }\n", to: stream)
        UIDefinitionWriter.write(line: "}\n", to: stream)
        
        // Close
        stream.close()

    }
}
