struct E_num {
    var list: Variable = .array(
        [
            .bool(false),
            .string("False"),
            .int(0)
        ]
    )
    
    var dictionary: Variable = .dictionary(
        [
            .bool(false): .double(3.14)
        ]
    )
    
    var text: Variable = .string("Hello, World!")
    
    func stupid() {
        if case .string(let value) = text {
            print("Stupid String: \(value)")
        }
        
        if case .array(let value) = list,
           let firstValue = value.last,
           case .int(let number) = firstValue {
            print(number * 99)
        }
    }
}
