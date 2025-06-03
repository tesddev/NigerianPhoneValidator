import XCTest
@testable import NigerianPhoneValidator

final class NigerianPhoneValidatorTests: XCTestCase {
    
    let validator = NigerianPhoneValidator.shared
    
    func testValidNumbers() {
        let validNumbers = [
            "8034567890",
            "9113456789",
            "09012345678",
            "9012345678",
            "+2348034567890",
            "2348034567890",
            "0803 456 7890",
            "0901-234-5678"
        ]
        
        for number in validNumbers {
            XCTAssertTrue(validator.isValid(number), "Should be valid: \(number)")
        }
    }
    
    func testInvalidNumbers() {
        let invalidNumbers = [
            "123456789",      // Too short
            "080345678901",   // Too long
            "0801234567890",  // Invalid prefix
            "abc1234567890",  // Contains letters
            "",               // Empty
            "1234567890",     // Invalid prefix
            "08034567890y",   // Contains letters
            "08034567890rfffffffffffffffff" // Contains letters
        ]
        
        for number in invalidNumbers {
            XCTAssertFalse(validator.isValid(number), "Should be invalid: \(number)")
        }
    }
    
    func testNetworkOperatorDetection() {
        XCTAssertEqual(validator.getNetworkOperator(for: "08034567890"), .mtn)
        XCTAssertEqual(validator.getNetworkOperator(for: "09012345678"), .airtel)
        XCTAssertEqual(validator.getNetworkOperator(for: "08054567890"), .glo)
        XCTAssertEqual(validator.getNetworkOperator(for: "08094567890"), .etisalat)
    }
    
    func testPhoneNumberFormatting() {
        XCTAssertEqual(validator.format("08034567890"), "0803 456 7890")
        XCTAssertEqual(validator.format("8034567890"), "0803 456 7890")
        XCTAssertEqual(validator.format("+2348034567890"), "0803 456 7890")
        XCTAssertNil(validator.format("123456789"))
    }
    
    func testCustomPrefixes() {
        // Add custom prefix
        validator.addCustomPrefixes(["0999", "0888"])
        
        XCTAssertTrue(validator.isValid("09991234567"))
        XCTAssertTrue(validator.isValid("08881234567"))
        
        // Remove custom prefix
        validator.removeCustomPrefixes(["0999"])
        XCTAssertFalse(validator.isValid("09991234567"))
        XCTAssertTrue(validator.isValid("08881234567"))
    }
    
    func testStringExtensions() {
        XCTAssertTrue("08034567890".isValidNigerianPhoneNumber)
        XCTAssertFalse("123456789".isValidNigerianPhoneNumber)
        
        XCTAssertEqual("08034567890".formattedNigerianPhoneNumber, "0803 456 7890")
        XCTAssertEqual("08034567890".nigerianNetworkOperator, .mtn)
    }
}
