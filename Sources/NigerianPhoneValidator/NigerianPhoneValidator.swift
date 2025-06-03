// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

/// A comprehensive validator for Nigerian phone numbers
public final class NigerianPhoneValidator {
    
    /// Shared instance for convenient access
    public static let shared = NigerianPhoneValidator()
    
    /// Nigerian network operators and their prefixes
    public enum NetworkOperator: String, CaseIterable {
        case mtn = "MTN"
        case airtel = "Airtel"
        case glo = "Glo"
        case etisalat = "9mobile"
        case ntel = "ntel"
        case smile = "Smile"
        case spectranet = "Spectranet"
        case swift = "Swift"
        case zoom = "Zoom"
        
        /// Get all prefixes for this operator
        public var prefixes: [String] {
            switch self {
            case .mtn:
                return ["0803", "0806", "0703", "0706", "0813", "0816", "0810", "0814", "0903", "0906", "0913", "0916", "0704"]
            case .airtel:
                return ["0802", "0808", "0708", "0812", "0701", "0902", "0907", "0901", "0904", "0912"]
            case .glo:
                return ["0805", "0807", "0705", "0815", "0811", "0905", "0915"]
            case .etisalat:
                return ["0809", "0818", "0817", "0909", "0908"]
            case .ntel:
                return ["0804"]
            case .smile:
                return ["0702"]
            case .spectranet:
                return ["0709"]
            case .swift:
                return ["0710"]
            case .zoom:
                return ["0707"]
            }
        }
    }
    
    /// All valid Nigerian prefixes (updated as of 2024)
    private var validPrefixes: Set<String> {
        var prefixes = Set<String>()
        
        // Add all operator prefixes
        for networkOperator in NetworkOperator.allCases {
            networkOperator.prefixes.forEach { prefix in
                prefixes.insert(prefix)
                // Also add without leading zero
                prefixes.insert(String(prefix.dropFirst()))
            }
        }
        
        // Add any additional custom prefixes
        customPrefixes.forEach { prefix in
            prefixes.insert(prefix)
            // Handle both formats (with and without leading zero)
            if prefix.hasPrefix("0") {
                prefixes.insert(String(prefix.dropFirst()))
            } else {
                prefixes.insert("0" + prefix)
            }
        }
        
        return prefixes
    }
    
    /// Custom prefixes that can be added dynamically
    private var customPrefixes: Set<String> = []
    
    private init() {}
    
    /// Validates if a Nigerian phone number is valid
    /// - Parameter phoneNumber: The phone number to validate
    /// - Returns: True if valid, false otherwise
    public func isValid(_ phoneNumber: String) -> Bool {
        let cleanNumber = cleanPhoneNumber(phoneNumber)
        
        // Check length (10 or 11 digits)
        guard cleanNumber.count == 10 || cleanNumber.count == 11 else {
            return false
        }
        
        // Check if it's all digits
        guard cleanNumber.allSatisfy({ $0.isNumber }) else {
            return false
        }
        
        // Extract prefix based on length
        let prefix: String
        if cleanNumber.count == 11 {
            prefix = String(cleanNumber.prefix(4))
        } else {
            prefix = String(cleanNumber.prefix(3))
        }
        
        return validPrefixes.contains(prefix)
    }
    
    /// Get the network operator for a phone number
    /// - Parameter phoneNumber: The phone number to check
    /// - Returns: The network operator or nil if invalid/unknown
    public func getNetworkOperator(for phoneNumber: String) -> NetworkOperator? {
        let cleanNumber = cleanPhoneNumber(phoneNumber)
        
        guard isValid(cleanNumber) else { return nil }
        
        let prefix: String
        if cleanNumber.count == 11 {
            prefix = String(cleanNumber.prefix(4))
        } else {
            prefix = "0" + String(cleanNumber.prefix(3))
        }
        
        for networkOperator in NetworkOperator.allCases {
            if networkOperator.prefixes.contains(prefix) {
                return networkOperator
            }
        }
        
        return nil
    }
    
    /// Format a Nigerian phone number to standard format
    /// - Parameter phoneNumber: The phone number to format
    /// - Returns: Formatted phone number (e.g., "0803 123 4567") or nil if invalid
    public func format(_ phoneNumber: String) -> String? {
        let cleanNumber = cleanPhoneNumber(phoneNumber)
        
        guard isValid(cleanNumber) else { return nil }
        
        let formattedNumber: String
        if cleanNumber.count == 11 {
            let prefix = String(cleanNumber.prefix(4))
            let middle = String(cleanNumber.dropFirst(4).prefix(3))
            let suffix = String(cleanNumber.suffix(4))
            formattedNumber = "\(prefix) \(middle) \(suffix)"
        } else {
            let prefix = "0" + String(cleanNumber.prefix(3))
            let middle = String(cleanNumber.dropFirst(3).prefix(3))
            let suffix = String(cleanNumber.suffix(4))
            formattedNumber = "\(prefix) \(middle) \(suffix)"
        }
        
        return formattedNumber
    }
    
    /// Add custom prefixes for new network operators or updates
    /// - Parameter prefixes: Array of prefixes to add (with or without leading zero)
    public func addCustomPrefixes(_ prefixes: [String]) {
        for prefix in prefixes {
            let cleanPrefix = prefix.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !cleanPrefix.isEmpty, cleanPrefix.allSatisfy({ $0.isNumber || $0 == "0" }) else {
                continue
            }
            customPrefixes.insert(cleanPrefix)
        }
    }
    
    /// Remove custom prefixes
    /// - Parameter prefixes: Array of prefixes to remove
    public func removeCustomPrefixes(_ prefixes: [String]) {
        for prefix in prefixes {
            let cleanPrefix = prefix.trimmingCharacters(in: .whitespacesAndNewlines)
            customPrefixes.remove(cleanPrefix)
            customPrefixes.remove("0" + cleanPrefix)
            customPrefixes.remove(String(cleanPrefix.dropFirst()))
        }
    }
    
    /// Get all currently valid prefixes
    /// - Returns: Array of all valid prefixes
    public func getAllValidPrefixes() -> [String] {
        return Array(validPrefixes).sorted()
    }
    
    /// Clean phone number by removing non-digit characters except leading +234
    /// - Parameter phoneNumber: Raw phone number input
    /// - Returns: Cleaned phone number
    private func cleanPhoneNumber(_ phoneNumber: String) -> String {
        var cleaned = phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Handle international format (+234)
        if cleaned.hasPrefix("+234") {
            cleaned = "0" + String(cleaned.dropFirst(4))
        } else if cleaned.hasPrefix("234") {
            cleaned = "0" + String(cleaned.dropFirst(3))
        }
        
        // Remove all non-digit characters
        cleaned = cleaned.filter { $0.isNumber }
        
        return cleaned
    }
}

// MARK: - Convenience Extensions
public extension String {
    /// Check if this string is a valid Nigerian phone number
    var isValidNigerianPhoneNumber: Bool {
        return NigerianPhoneValidator.shared.isValid(self)
    }
    
    /// Get formatted Nigerian phone number
    var formattedNigerianPhoneNumber: String? {
        return NigerianPhoneValidator.shared.format(self)
    }
    
    /// Get network operator for this phone number
    var nigerianNetworkOperator: NigerianPhoneValidator.NetworkOperator? {
        return NigerianPhoneValidator.shared.getNetworkOperator(for: self)
    }
}
