import LibXml2Swift

import Foundation

guard let url = URL(string: "Files/MyNewView.xib") else {
    exit(1)
}

// Read XML document
let rootXibDocument = try XmlDomReader.read(atPath: url)

// Check root document
let rootElement = try rootXibDocument.rootElement()
guard (rootElement.name == "document") else {
    exit(2)
}

// Set Xib definition
if let xibDefinition = XibDefinition(element: rootElement) {
    
    // Display object
    for object in xibDefinition.objects {
        print("Object")
    }
}


print("Hello, world!")
