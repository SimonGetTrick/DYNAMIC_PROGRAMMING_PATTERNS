//
//  main.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 28.04.2025.
//

import Foundation


if true { // Example usage longestPalindromicSubstring
    let input = "babad"
    let result = longestPalindromicSubstring(input)
    print("Longest palindromic substring: \(result)") // Output: "bab" or "aba"
    print("Hello, World!")
    
}
if true { // Example usage knapsack w
    let weights = [2, 3, 4]
    let values = [3, 4, 5]
    let W = 8
    let n = 3
    var result = knapsack(W: W, weights: weights, values: values, n: n)
    print("Maximum value: \(result)")
    result = unboundedKnapsack(W: W, weights: weights, values: values, n: n)
    print("Maximum value for unbounded knapsack: \(result)")
}

// Start DFS from the initial node "A"

dfs(node: "A")
// Create a graph and add edges
let graph = Graph()
graph.addEdge(from: "A", to: "B")
graph.addEdge(from: "A", to: "E")
graph.addEdge(from: "B", to: "C")
graph.addEdge(from: "B", to: "D")

// Start DFS and BFS from node A
print("Depth First Search (DFS):")
graph.depthFirstSearch(start: "A")

print("\nBreadth First Search (BFS):")
graph.breadthFirstSearch(start: "A")

// Check for cycles starting from node "A"
graph.addEdge(from: "D", to: "A")
if graph.hasCycle(start: "A") {
    print("Graph contains a cycle") // graph.addEdge(from: "D", to: "A")
} else {
    print("No cycle detected")  // graph.addEdge(from: "A", to: "D")
}

// Create a graph with vertices A, B, C, D, E
let graphMatrix = GraphMatrix(vertices: ["A", "B", "C", "D", "E"])

// Add edges: AB, AE, BC, BD
//  A B C D E
//A 0 1 0 0 1
//B 1 0 1 1 0
//C 0 1 0 0 0
//D 0 1 0 0 0
//E 1 0 0 0 0

graphMatrix.addEdge(from: "A", to: "B")
graphMatrix.addEdge(from: "A", to: "E")
graphMatrix.addEdge(from: "B", to: "C")
graphMatrix.addEdge(from: "B", to: "D")
// Start DFS and BFS from node A
print("Depth First Search (DFS):")
graphMatrix.depthFirstSearch(start: "A")

print("\nBreadth First Search (BFS):")
graphMatrix.breadthFirstSearch(start: "A")

// Example usage
var pq = PriorityQueue<Int>()
pq.enqueue(3)
pq.enqueue(1)
pq.enqueue(4)
pq.enqueue(1)
pq.enqueue(5)

print("Top element: \(pq.peek() ?? -1)") // Output: 1
print("Dequeued: \(pq.dequeue() ?? -1)") // Output: 1
print("Dequeued: \(pq.dequeue() ?? -1)") // Output: 1
print("Top element: \(pq.peek() ?? -1)") // Output: 3
print("Queue size: \(pq.count)") // Output: 3

// Example usage

let tree = BinaryTree()

// Insert values into the binary tree
tree.insert(value: 50)
tree.insert(value: 30)
tree.insert(value: 70)
tree.insert(value: 20)
tree.insert(value: 40)
tree.insert(value: 60)
tree.insert(value: 80)

// Perform in-order traversal (should print the values in sorted order)
print("In-order Traversal:")
tree.inOrderTraversal()
print()

// Perform pre-order traversal
print("Pre-order Traversal:")
tree.preOrderTraversal()
print()

// Perform post-order traversal
print("Post-order Traversal:")
tree.postOrderTraversal()
demo_SetOperations()

// Creation patterns:
demo_SimpleFactory()
AbstractFactory.demo_pattert_1_1_AbstractFactory()
demo_pattert_1_2_ThemeBuilder()
FactoryMethod.demo_FactoryMethod()
demo_PrototypePattern()
demo_SingletonPattern()

// Structure's patterns:
demo_AdapterPattern()
demo_BridgePattern()
demo_CompositePattern()
demo_Decorator()
demo_decorator()
demo_FacadePattern()
demo_FlyweightPattern()
demo_ProxyPattern()

//
//// Behaviour patterns:
demo_ChainOfResponsibility()
demo_CommandPattern()
demo_InterpreterPattern()
demo_IteratorPattern()
demo_MediatorPattern()
demo_MementoPattern()
demo_observer()
demo_StatePattern()
demo_strategy()
demo_TemplateMethodPattern()
demo_VisitorPattern()

//MultyTreadins
demo4_1_ThreadPool()

// logic tasks :
//demo_phone_number_words()
//demo_trie_aho_corasick()
//demo_blockSerch()
//demo_rectCounter()
demo_lakeCounter()
//demo_decompressString()

//Objective-C patterns to Swift:
func testObjectiveCDocumentUsage() {
    let path = "/Users/user/Documents/report.txt"
    let doc = TwoStageCreation(file: path)
    print("File path: \(doc.filePath)")
    print("Contents: \(doc.contents)")
}
testObjectiveCDocumentUsage()
TemplateTestHelper.runTemplateDemo()
let dog: Void = DCDynamicAnimalFactory.createAnimal(withName: "DCDog")
    .speak() // Output: Woof! (DCDog)

let animal = CAnimal()
animal.move() // Prints: "CAnimal moves forward"
animal.speak() // Prints: "CAnimal says something (extension method)"
animal.nickname = "Buddy"
animal.age = 5
print("Nickname: \(animal.nickname), Age: \(animal.age)")
let swiftContainer = AnonymousContainer()
swiftContainer.storeItems("Swift", andItem: 100)
swiftContainer.processItems()
// Output:
// String: Swift
// Number: 100

// New demo for EnumeratorPattern (Objective-C)
EnumeratorPattern.demoEnumeratorPattern()

PerformSelector.demoPerformSelector()
AccessorsPattern.demoAccessorsPattern()
ArchivingPattern.demoArchivingUnarchiving()
CopyingPattern.demoCopyingPattern()
//SingletonPatternObj<=>ConfigurationManager
SingletonPatternObj.demoSingletonPattern()
NotificationsPattern.demoNotificationsPattern()
DelegatePattern.demoDelegatePattern()
HierarchiesPattern.demoHierarchiesPattern()
OutletsTargetsActionsPattern.demoOutletsTargetsActionsPattern()
ResponderChainPattern.demoResponderChainPattern()
AssociativeStoragePattern.demoAssociativeStoragePattern()
