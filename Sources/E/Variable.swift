//
//  Variable.swift
//  E
//
//  Created by Zach Eriksen on 9/29/20.
//

public enum Variable: Hashable {
    case void
    case bool(Bool)
    case int(Int)
    case float(Float)
    case double(Double)
    case string(String)
    case set(Set<Variable>)
    case array([Variable])
    case dictionary([Variable: Variable])
}

public extension Variable {
    init() {
        self = .void
    }
    
    init(bool: Bool) {
        self = .bool(bool)
    }
    
    init(int: Int) {
        self = .int(int)
    }
    
    init(float: Float) {
        self = .float(float)
    }
    
    init(double: Double) {
        self = .double(double)
    }
    
    init(string: String) {
        self = .string(string)
    }
    
    init(set: Set<Variable>) {
        self = .set(set)
    }
    
    init(array: [AnyHashable]) {
        self = .array(array.map({ $0.variable }))
    }
    
    init(dictionary: [AnyHashable: AnyHashable]) {
        let variable = Variable.dictionary([:])
        
        if case .dictionary(var variable) = variable {
            dictionary.forEach { (key, value) in
                variable[value.variable] = value.variable
            }
        }
        
        self = variable
    }
}

public extension Variable {
    var flatten: Variable {
        guard case .array(let value) = self else {
            return self
        }
        
        guard !value.isEmpty else {
            return .array([])
        }
        
        guard value.count > 1 else {
            return value[0]
        }
        
        let flattenedArray = value.map(\.flatten)
        
        var flatArray = [Variable]()
        
        for variable in flattenedArray {
            if case .array(let values) = variable {
                flatArray.append(contentsOf: values.map(\.flatten))
            } else {
                flatArray.append(variable)
            }
        }
        
        return .array(flatArray)
    }
}

public extension Variable {
    /// Update the Variable's Value
    /// - Returns: A new Variable with the type of T
    func update<T>(_ closure: (T) -> Variable) -> Self {
        guard let value = value(as: T.self) else {
            print("[E] ERROR (\(#function): Could not modify value \(self) as \(T.self)...")
            return self
        }
        
        return closure(value)
    }
    
    /// Modify the Variable to be any type of Variable
    /// - Returns: A new Variable of any type
    func modify<T>(_ closure: (T?) -> Variable) -> Self {
        guard let value = value(as: T.self) else {
            return closure(nil)
        }
        
        return closure(value)
    }
    
    func value<T>(as type: T.Type? = nil) -> T? {
        switch self {
        case .void:
            return nil
        case .bool(let value):
            return value as? T
        case .int(let value):
            return value as? T
        case .float(let value):
            return value as? T
        case .double(let value):
            return value as? T
        case .string(let value):
            return value as? T
        case .set(let value):
            return value as? T
        case .array(let value):
            return value as? T
        case .dictionary(let value):
            return value as? T
        }
    }
}

extension Variable: ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: Bool) {
        self = .bool(value)
    }
}

extension Variable: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = .int(value)
    }
}

extension Variable: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Float) {
        self = .float(value)
    }
}

extension Variable: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self = .string(value)
    }
}

extension Variable: ExpressibleByArrayLiteral {
    public init(arrayLiteral: AnyHashable...) {
        self = .array(arrayLiteral.map({ $0.variable }))
    }
}

extension Variable: ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (AnyHashable, AnyHashable)...) {
        let dictionary = Variable.dictionary([:])
        
        if case .dictionary(var dictionary) = dictionary {
            elements.forEach { (key, value) in
                dictionary[value.variable] = value.variable
            }
        }
        
        self = dictionary
    }
}

public extension AnyHashable {
    var variable: Variable {
        if let variable = self as? Variable {
            return variable
        } else if let string = self as? String {
            return .string(string)
        } else if let int = self as? Int {
            return .int(int)
        } else if let float = self as? Float {
            return .float(float)
        } else if let double = self as? Double {
            return .double(double)
        } else if let bool = self as? Bool {
            return .bool(bool)
        } else if let array = self as? [AnyHashable] {
            return .array(array.map({ $0.variable }))
        } else if let object = self as? [String: AnyHashable] {
            var dictionary: [Variable: Variable] = [:]
            
            object.forEach { (key: String, value: AnyHashable) in
                dictionary[.string(key)] = value.variable
            }
            
            return .dictionary(dictionary)
        } else {
            return .string(self.description)
        }
    }
}
