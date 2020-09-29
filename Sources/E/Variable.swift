//
//  Variable.swift
//  E
//
//  Created by Zach Eriksen on 9/29/20.
//

public enum Variable: Equatable, Hashable {
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
    public init(arrayLiteral: Variable...) {
        self = .array(arrayLiteral)
    }
}

extension Variable: ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (Variable, Variable)...) {
        let dictionary = Variable.dictionary([:])
        
        if case .dictionary(var dictionary) = dictionary {
            elements.forEach { (key, value) in
                dictionary[key] = value
            }
        }
        
        self = dictionary
    }
}
