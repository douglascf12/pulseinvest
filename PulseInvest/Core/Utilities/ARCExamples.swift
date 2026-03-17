import Foundation

final class Person {

    let name: String

    init(name: String) {
        self.name = name
        print("\(name) created")
    }

    deinit {
        print("\(name) deallocated")
    }

}

final class ARCExamples {

    static func simpleExample() {

        var person: Person? = Person(name: "Douglas")

        person = nil

    }

}
