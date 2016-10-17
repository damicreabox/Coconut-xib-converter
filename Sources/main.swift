import LibXml2Swift

import Foundation

guard let url = URL(string: "Files/MyNewView.xib") else {
    exit(1)
}

do {
    // Read XML document
    let rootXibDocument = try XmlDomReader.read(atPath: url)
    
    // Check root document
    let rootElement = try rootXibDocument.rootElement()
    guard (rootElement.name == "document") else {
        exit(2)
    }
    
    // Set Xib definition
    if let xibDefinition = XibDefinition(element: rootElement) {
        
        // Generate files
        try xibDefinition.generate(at: URL(fileURLWithPath: "/tmp/coconut/Sources"))
        
    }
} catch {
    print("\(error)")
}



