//
//  Variable.swift
//  E.num
//
//  Created by Zach Eriksen on 9/29/20.
//

import Foundation

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
