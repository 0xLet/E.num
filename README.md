# E

Swift... but only enums!

## Variables

### Basic String Example

```swift
let text: Variable = .string("Hello, World!")
```

### Basic Dictionary Example

```swift
let dictionary: Variable = .dictionary(
	[
		.bool(false): .double(3.14)
	]
)
```

### Array Example

```swift
let list: Variable = .array(
	[
		.bool(false),
		.string("False"),
		.dictionary(
			[
				.bool(false): .double(3.14)
			]
		),
		.int(27)
	]
)
```

### Getting Values Example

```swift
if case .string(let value) = text {
	print("String: \(value)")
}

if case .array(let value) = list,
   let lastValue = value.last,
   case .int(let number) = lastValue {
	print(number * 99)
}
```

## Functions

### Void Function Example

```swift
let voidExample = Function.void {
	print("Print Lorem ipsum")
}
// ...
voidExample()
```

### In Function Example

```swift
let printString = Function.in { stringValue in
	guard case .string(let value) = stringValue else {
		return
	}

	print(value)
}
// ...
printString(.string("Hello, World..."))
```

### In & Out Function Example

```swift
let double = Function.inout { value in
	if case .int(let value) = value {
		return .int(value * 2)
	} else if case .float(let value) = value {
		return .float(value * 2)
	} else if case .double(let value) = value {
		return .double(value * 2)
	} else if case .string(let value) = value {
		return .string("\(value)\(value)")
	}

	return .array([value, value])
}
// ...
print("Double of \(Variable.float(3.14)) is \(double(.float(3.14)))")
```
