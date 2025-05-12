//
//  2.2.Composite.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 12.05.2025.
//

import Foundation

// Protocol defining the component (leaf or composite)
protocol FileSystemComponent {
    var name: String { get }
    func getSize() -> Int
    func describe(indent: Int) -> String
    func findFile(named: String) -> FileSystemComponent?
}

// Leaf class representing a file
class File: FileSystemComponent {
    let name: String
    private let size: Int
    
    init(name: String, size: Int) {
        self.name = name
        self.size = size
    }
    
    func getSize() -> Int {
        return size
    }
    
    func describe(indent: Int) -> String {
        return String(repeating: "  ", count: indent) + "File: \(name) (\(size) bytes)"
    }
    
    // Search for a file (leaf case)
    func findFile(named: String) -> FileSystemComponent? {
        return name == named ? self : nil
    }
}

// Composite class representing a folder (directory)
class Folder: FileSystemComponent {
    let name: String
    private var children: [FileSystemComponent] = []
    
    init(name: String) {
        self.name = name
    }
    
    func add(_ component: FileSystemComponent) {
        children.append(component)
    }
    
    func remove(_ component: FileSystemComponent) {
        children.removeAll { $0.name == component.name }
    }
    
    func getSize() -> Int {
        return children.reduce(0) { $0 + $1.getSize() }
    }
    
    func describe(indent: Int) -> String {
        var result = String(repeating: "  ", count: indent) + "Folder: \(name) (\(getSize()) bytes)\n"
        for child in children {
            result += child.describe(indent: indent + 1) + "\n"
        }
        return result
    }
    
    // Search for a file in the folder and its children
    func findFile(named: String) -> FileSystemComponent? {
        for child in children {
            if let found = child.findFile(named: named) {
                return found
            }
        }
        return nil
    }
}

// Demo function to showcase the Composite pattern
func demo_CompositePattern() {
    let file1 = File(name: "file1.txt", size: 100)
    let file2 = File(name: "file2.txt", size: 200)
    let file3 = File(name: "file3.txt", size: 150)
    
    let documentsFolder = Folder(name: "Documents")
    documentsFolder.add(file1)
    documentsFolder.add(file2)
    
    let rootFolder = Folder(name: "Root")
    rootFolder.add(documentsFolder)
    rootFolder.add(file3)
    
    print(rootFolder.describe(indent: 0))
    
    // Search for a file
    if let foundFile = rootFolder.findFile(named: "file2.txt") {
        print("Found file: \(foundFile.name) with size \(foundFile.getSize()) bytes")
    } else {
        print("File not found.")
    }
}


