import PackageDescription

let package = Package(
    name: "Coconut-xib-converter",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/damicreabox/LibXml2Swift.git",
                 majorVersion: 1),
    ]
)
