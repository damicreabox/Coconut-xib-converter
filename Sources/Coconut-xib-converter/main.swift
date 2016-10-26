import LibXml2Swift

import Foundation

guard let url = URL(string: "Files/MyNewView.xib") else {
    exit(1)
}

do {
        
    // Set Xib definition
    let xibDefinition = try XibDefinitionReader.read(at: url)
    
    // Create writer
    let xibDefinitionWriter = UIDefinitionWriter(xibDefinition: xibDefinition)
    
    // Generate files
    try xibDefinitionWriter.write(at: URL(fileURLWithPath: "/Users/dami/XCode/Creabox/Coconut/Sources/Coconut/Sample/"))
        
} catch {
    print("\(error)")
}
