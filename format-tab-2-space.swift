#!/usr/bin/env swift

import Foundation

func replacedTabWithSpaceIfNeeded(in filePath: URL) -> String{
  let doubleSpace = String(repeating: "\u{0020}", count: 2)
  do {
    let contents = try String(contentsOf: filePath)
    return contents.replacingOccurrences(
      of: "\t",
      with: doubleSpace
    )
  } catch {
    fatalError("Error reading contents of \(filePath)")
  }
}

if CommandLine.argc == 2 {
  let fileURLString = CommandLine.arguments[1]
  
  let fileManager = FileManager.default
  if fileManager.fileExists(atPath: fileURLString) {
    
    let fileURL = URL(fileURLWithPath: fileURLString)
    let formattedContents = replacedTabWithSpaceIfNeeded(in: fileURL)
    let data = formattedContents.data(using: .utf8)
    
    fileManager.createFile(
      atPath: fileURL.path,
      contents: data,
      attributes: nil
    )
  } else {
    print("File \"\(fileURLString)\" doesn't exist")
  }
} else {
  print("Please specify an argument for absolute path to RAML file")
}
