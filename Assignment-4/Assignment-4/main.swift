// Swift Structures:
// 1. Define a Swift structure named 'Book' with four properties. Declare these
// properties, and their types.
// Swift Structures:
// 1. Define a Swift structure named 'Book' with four properties. Declare these
// properties, and their types.

// Swift Structures:
// Define a Swift structure named 'Book' with four properties. Declare these properties, and their types.

import Foundation

// Swift Structures:
// Define a Swift structure named 'Book' with four properties. Declare these properties, and their types.

struct Book {
    let title: String
    let author: String
    let pages: Int
    let publicationYear: Int
    
    // Method to display information about the book
    func displayInfo() -> String {
        return "Title: \(title)\nAuthor: \(author)\nPages: \(pages)\nPublication Year: \(publicationYear)\n\n"
    }
}

// Create instances of the 'Book' structure
let book1 = Book(title: "The Great Gatsby", author: "F. Scott Fitzgerald", pages: 180, publicationYear: 1925)
let book2 = Book(title: "To Kill a Mockingbird", author: "Harper Lee", pages: 281, publicationYear: 1960)
let book3 = Book(title: "1984", author: "George Orwell", pages: 328, publicationYear: 1949)

// Print information about a specific book
print(book2.displayInfo())

// Swift Class:
// Define a class 'Shape' with two methods: area() and perimeter().
class Shape {
    // Methods to be overridden by subclasses
    func area() -> Double {
        fatalError("Subclasses must override area()")
    }
    
    func perimeter() -> Double {
        fatalError("Subclasses must override perimeter()")
    }
}

// Subclass 'Rectangle' inheriting from 'Shape'
class Rectangle: Shape {
    let width: Int
    let height: Int
    
    // Initialize with width and height
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
    
    // Calculate area of the rectangle
    override func area() -> Double {
        return Double(width * height)
    }
    
    // Calculate perimeter of the rectangle
    override func perimeter() -> Double {
        return Double(2 * (width + height))
    }
}

// Subclass 'Circle' inheriting from 'Shape'
class Circle: Shape {
    let radius: Double
    
    // Initialize with radius
    init(radius: Double) {
        self.radius = radius
    }
    
    // Calculate area of the circle
    override func area() -> Double {
        return Double.pi * radius * radius
    }
    
    // Calculate perimeter of the circle
    override func perimeter() -> Double {
        return 2 * Double.pi * radius
    }
}

// Instantiate a 'Rectangle' and a 'Circle'
let rectangle = Rectangle(width: 5, height: 3)
let circle = Circle(radius: 4.0)

// Function to print details of a shape
func printDetails(shape: Shape) {
    print("Area: \(shape.area()), Perimeter: \(shape.perimeter())\n")
}

// Print details of the rectangle and circle
print("Rectangle Details:")
printDetails(shape: rectangle)
print("Circle Details:")
printDetails(shape: circle)

// Swift Protocols:
// Define a protocol named ShapeProtocol
protocol ShapeProtocol {
    func name() -> String
    func area() -> Double
    func perimeter() -> Double
}

// Class 'Square' conforming to 'ShapeProtocol'
class Square: ShapeProtocol {
    let sideLength: Int
    
    // Initialize with side length
    init(sideLength: Int) {
        self.sideLength = sideLength
    }
    
    // Name of the shape
    func name() -> String {
        return "Square"
    }
    
    // Calculate area of the square
    func area() -> Double {
        return Double(sideLength * sideLength)
    }
    
    // Calculate perimeter of the square
    func perimeter() -> Double {
        return Double(4 * sideLength)
    }
}

// Class 'CircleShape' conforming to 'ShapeProtocol'
class CircleShape: ShapeProtocol {
    let radius: Double
    
    // Initialize with radius
    init(radius: Double) {
        self.radius = radius
    }
    
    // Name of the shape
    func name() -> String {
        return "Circle"
    }
    
    // Calculate area of the circle
    func area() -> Double {
        return Double.pi * radius * radius
    }
    
    // Calculate perimeter of the circle
    func perimeter() -> Double {
        return 2 * Double.pi * radius
    }
}

// Swift Extensions:
// Extend Int to have a cube() method
extension Int {
    func cube() -> Int {
        return self * self * self
    }
}

// Print cubes of numbers
print("Cubes of Numbers:")
print(9.cube())
print(10.cube())
print(11.cube())
print("\n")

// Extend String to have a toInt() method
extension String {
    func toInt() -> Int? {
        return Int(self)
    }
}

// Convert string to Int
let numString = "567"
if let intValue = numString.toInt() {
    print("Converted String to Int:", intValue)
} else {
    print("Conversion failed.")
}
print("\n")

// Add a minMax() method on the Array
extension Array where Element: Comparable {
    func minMax() -> (min: Element, max: Element)? {
        guard let minElement = self.min(), let maxElement = self.max() else {
            return nil
        }
        return (minElement, maxElement)
    }
}

// Find minimum and maximum values in the array
let numbers = [9, 8, 4, 6, 3]
if let minMaxValues = numbers.minMax() {
    print("Array:", numbers)
    print("Minimum:", minMaxValues.min, "Maximum:", minMaxValues.max)
} else {
    print("Array is empty.")
}
print("\n")

// Extend Date to return a formatted string
extension Date {
    func formattedString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: self)
    }
}

// Get formatted date
let currentDate = Date()
print("Formatted Date:", currentDate.formattedString())
print("\n")


