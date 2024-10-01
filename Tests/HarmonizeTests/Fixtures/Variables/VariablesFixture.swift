import Foundation

var property = "a"
let immutable: String = "string"
public var nullable: String? = nil

var inlineProperty1: Int = 2, inlineProperty2: String? = "b"

class ExampleClass {
    var a, b, c, d: Double
    
    init(a: Double, b: Double, c: Double, d: Double) {
        self.a = a
        self.b = b
        self.c = c
        self.d = d
    }
}

class MyClassType {
    private let value: Int
    
    init(value: Int) {
        self.value = value
    }
}

class Main {
    private let myType: MyClassType = MyClassType(value: 2)
    private let myType2: MyClassType
    
    init() {
        self.myType2 = MyClassType(value: 3)
    }
}

class Properties {
    private var example1: String = ""
    public var example2: String = ""
    internal var example3: String = ""
    fileprivate var example4: String = ""
    open var example5: String = ""
    public weak var example6: Properties?
    unowned var example7: Properties?
    fileprivate lazy var example8: String = { "" }()
    final let example9: String = ""
    @available(*, renamed: "example11") @objc static let example10: Int = 0
    var example11: Int { 9 }
    var example12: Int = 2
    var example13: Int {
        get { return example12 }
        set { example12 = newValue }
    }
}

class MyViewModel: ObservableObject {
    @Published public var state: Int = 0
    @Published public private(set) var locked: Bool = false
}
