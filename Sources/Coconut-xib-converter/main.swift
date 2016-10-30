import LibXml2Swift

import Foundation

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
        print("Unknow options : \(arguments[index])")
	break
    }
    index += 1
}

guard let url = URL(string: file) else {
    exit(1)
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
