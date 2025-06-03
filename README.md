# NigerianPhoneValidator

A comprehensive Swift Package Manager library for validating Nigerian phone numbers with support for all major network operators.

## Features

- ✅ Validate Nigerian phone numbers (10 and 11 digit formats)
- 🏢 Identify network operators (MTN, Airtel, Glo, 9mobile, etc.)
- 📱 Format phone numbers to standard format
- 🔧 Add custom prefixes for new operators
- 🌍 Handle international format (+234)
- 🚀 Lightweight and fast
- 📝 Comprehensive test coverage

## Installation

### Swift Package Manager

Add this to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/NigerianPhoneValidator.git", from: "1.0.0")
]
```

Or in Xcode:
1. File → Add Package Dependencies
2. Enter the repository URL
3. Select the version/branch

## Usage

### Basic Validation

```swift
import NigerianPhoneValidator

let validator = NigerianPhoneValidator.shared

// Validate phone numbers
validator.isValid("08034567890") // true
validator.isValid("9012345678")  // true
validator.isValid("123456789")   // false

// Using String extension
"08034567890".isValidNigerianPhoneNumber // true
```

### Network Operator Detection

```swift
let operator = validator.getNetworkOperator(for: "08034567890")
print(operator) // Optional(MTN)

// Using String extension
let networkOp = "09012345678".nigerianNetworkOperator
print(networkOp) // Optional(Airtel)
```

### Phone Number Formatting

```swift
let formatted = validator.format("08034567890")
print(formatted) // "0803 456 7890"

// Using String extension
let formatted2 = "8034567890".formattedNigerianPhoneNumber
print(formatted2) // "0803 456 7890"
```

### Adding Custom Prefixes

```swift
// Add new prefixes when new operators launch
validator.addCustomPrefixes(["0999", "0777"])

// Now these numbers will be valid
validator.isValid("09991234567") // true
validator.isValid("07771234567") // true

// Remove prefixes if needed
validator.removeCustomPrefixes(["0999"])
```

### Supported Formats

The library handles various input formats:

```swift
// All these are equivalent and valid
validator.isValid("08034567890")     // Standard 11-digit
validator.isValid("8034567890")      // 10-digit without leading zero
validator.isValid("+2348034567890")  // International format
validator.isValid("2348034567890")   // International without +
validator.isValid("0803 456 7890")  // With spaces
validator.isValid("0803-456-7890")  // With dashes
```

## Supported Network Operators

| Operator | Prefixes |
|----------|----------|
| MTN | 0803, 0806, 0703, 0706, 0813, 0816, 0810, 0814, 0903, 0906, 0913, 0916, 0704 |
| Airtel | 0802, 0808, 0708, 0812, 0701, 0902, 0907, 0901, 0904, 0912 |
| Glo | 0805, 0807, 0705, 0815, 0811, 0905, 0915 |
| 9mobile | 0809, 0818, 0817, 0909, 0908 |
| ntel | 0804 |
| Smile | 0702 |
| Spectranet | 0709 |
| Swift | 0710 |
| Zoom | 0707 |

## API Reference

### NigerianPhoneValidator

#### Methods

- `isValid(_ phoneNumber: String) -> Bool`
- `getNetworkOperator(for phoneNumber: String) -> NetworkOperator?`
- `format(_ phoneNumber: String) -> String?`
- `addCustomPrefixes(_ prefixes: [String])`
- `removeCustomPrefixes(_ prefixes: [String])`
- `getAllValidPrefixes() -> [String]`

#### String Extensions

- `var isValidNigerianPhoneNumber: Bool`
- `var formattedNigerianPhoneNumber: String?`
- `var nigerianNetworkOperator: NetworkOperator?`

## Testing

Run tests using:

```bash
swift test
```

Or in Xcode: `Cmd + U`

## Contributing

1. Fork the repository
2. Create your feature branch
3. Add tests for new functionality
4. Ensure all tests pass
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Updates

The library is regularly updated with new prefixes as Nigerian telecom operators launch new number ranges. You can also add custom prefixes dynamically without waiting for library updates.
