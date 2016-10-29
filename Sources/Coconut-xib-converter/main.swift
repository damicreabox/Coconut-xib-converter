import LibXml2Swift

import Foundation

guard let url = URL(string: "Files/MyNewView.xib") else {
    exit(1)
}

let arguments = CommandLine.arguments

var file = "Files/MyNewView.xib"
var output = "/Users/dami/XCode/Creabox/Coconut/Sources/Coconut/Sample/"

var index = 0
let size = arguments.count
while index < size {
    
    switch arguments[index] {
        
    case "file" :
        index += 1
        if (index < size) {
            file = arguments[index]
            print(" - \(arguments[index - 1]) : \(file)")
        }
        break
        
    case "output":
        index += 1
        if (index < size) {
            output = arguments[index]
            print(" - \(arguments[index - 1]) : \(output)")
        }
        break
        
    default:
        break
    }
    index += 1
}

do {
        
    // Set Xib definition
    let xibDefinition = try XibDefinitionReader.read(at: url)
    
    // Create writer
    let xibDefinitionWriter = UIDefinitionWriter(xibDefinition: xibDefinition)
    
    // Generate files
    try xibDefinitionWriter.write(at: URL(fileURLWithPath: output))
        
} catch {
    print("\(error)")
}
