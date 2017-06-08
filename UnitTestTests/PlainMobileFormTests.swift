//
//  PlainMobileFormTests.swift
//  MobileForms
//
//  Created by Yuri Solodkin on 05/06/2017.
//  Copyright © 2017 COINS. All rights reserved.
//

import XCTest

@testable import UnitTest

class PlainMobileFormTests: XCTestCase {
    
    func testFieldInvalid_singleValue() {
        
        let field1 = PlainMobileFormField()
        field1.type = .char
        
        field1.invalidValues = "A"
        field1.value = "X" as AnyObject
        XCTAssertEqual(field1.invalid, false)
        
        field1.invalidValues = "A"
        field1.value = "A" as AnyObject
        XCTAssertEqual(field1.invalid, true)
        
        field1.invalidValues = "A"
        field1.value = "a" as AnyObject
        XCTAssertEqual(field1.invalid, true)
        
        field1.invalidValues = "A"
        field1.value = "" as AnyObject
        XCTAssertEqual(field1.invalid, false)
    }
    
    func testFieldInvalid_List() {
        
        let field1 = PlainMobileFormField()
        field1.type = .char
        
        field1.invalidValues = "Aa,Bb,Cc"
        
        field1.value = "Xx" as AnyObject
        XCTAssertEqual(field1.invalid, false)
        
        field1.value = "AA" as AnyObject
        XCTAssertEqual(field1.invalid, true)
        
        field1.value = "cC" as AnyObject
        XCTAssertEqual(field1.invalid, true)
        
        field1.value = "c" as AnyObject
        XCTAssertEqual(field1.invalid, false)
        
        field1.value = "aaa" as AnyObject
        XCTAssertEqual(field1.invalid, false)
        
        field1.value = "Aa,Bb,Cc" as AnyObject
        XCTAssertEqual(field1.invalid, false)
        
        field1.value = "" as AnyObject
        XCTAssertEqual(field1.invalid, false)
    }
    
    func testFieldInvalid_range() {
        
        let field1 = PlainMobileFormField()
        field1.type = .char
        
        field1.invalidValues = "0.01-10"
        field1.value = "0" as AnyObject
        XCTAssertEqual(field1.invalid, false)
        
        field1.invalidValues = "0.01-10"
        field1.value = "0.01" as AnyObject
        XCTAssertEqual(field1.invalid, true)
        
        field1.invalidValues = "0.01-10"
        field1.value = "5.0" as AnyObject
        XCTAssertEqual(field1.invalid, true)
        
        field1.invalidValues = "0.01-10"
        field1.value = "10" as AnyObject
        XCTAssertEqual(field1.invalid, true)
        
        field1.invalidValues = "0.01-10"
        field1.value = "10.00001" as AnyObject
        XCTAssertEqual(field1.invalid, false)
        
        field1.invalidValues = "1.4-1.4"
        field1.value = "1.4" as AnyObject
        XCTAssertEqual(field1.invalid, true)
        
        field1.invalidValues = "11-10"
        field1.value = "10" as AnyObject
        XCTAssertEqual(field1.invalid, false)
        
        field1.invalidValues = "-1-10"
        field1.value = "5" as AnyObject
        XCTAssertEqual(field1.invalid, false)
        
        field1.invalidValues = "a-6"
        field1.value = "5" as AnyObject
        XCTAssertEqual(field1.invalid, false)
        
        field1.invalidValues = "-10"
        field1.value = "10" as AnyObject
        XCTAssertEqual(field1.invalid, false)
        
        field1.invalidValues = "a-c"
        field1.value = "b" as AnyObject
        XCTAssertEqual(field1.invalid, false)
        
        field1.invalidValues = "0-10"
        field1.value = "" as AnyObject
        XCTAssertEqual(field1.invalid, false)
    }
    
    func testFieldInvalid_comparing() {
        let field1 = PlainMobileFormField()
        field1.type = .char
        
        field1.invalidValues = "<2"
        field1.value = "1" as AnyObject
        XCTAssertEqual(field1.invalid, true)
        
        field1.invalidValues = ">4.5"
        field1.value = "7.9" as AnyObject
        XCTAssertEqual(field1.invalid, true)
        
        field1.invalidValues = "<>10"
        field1.value = "9" as AnyObject
        XCTAssertEqual(field1.invalid, true)
        
        field1.invalidValues = "<>100"
        field1.value = "100.0" as AnyObject
        XCTAssertEqual(field1.invalid, false)
        
        field1.invalidValues = ">4"
        field1.value = "4" as AnyObject
        XCTAssertEqual(field1.invalid, false)
        
        field1.invalidValues = ">4"
        field1.value = "3" as AnyObject
        XCTAssertEqual(field1.invalid, false)
        
        field1.invalidValues = ">0.00001"
        field1.value = "0" as AnyObject
        XCTAssertEqual(field1.invalid, false)
        
        field1.invalidValues = "<7"
        field1.value = "7" as AnyObject
        XCTAssertEqual(field1.invalid, false)
        
        field1.invalidValues = "<6"
        field1.value = "8" as AnyObject
        XCTAssertEqual(field1.invalid, false)
        
        field1.invalidValues = "<0"
        field1.value = "0.00001" as AnyObject
        XCTAssertEqual(field1.invalid, false)
        
        field1.invalidValues = "<1000"
        field1.value = "abc" as AnyObject
        XCTAssertEqual(field1.invalid, false)
        
        field1.invalidValues = "<4"
        field1.value = "" as AnyObject
        XCTAssertEqual(field1.invalid, false)
        
        field1.invalidValues = ">4"
        field1.value = "" as AnyObject
        XCTAssertEqual(field1.invalid, false)
        
        field1.invalidValues = "<>4"
        field1.value = "" as AnyObject
        XCTAssertEqual(field1.invalid, false)
    }
    
    func testFieldInvalid_logical() {
        let field1 = PlainMobileFormField()
        field1.type = .logical
        
        field1.invalidValues = "yes"
        field1.value = true as AnyObject
        XCTAssertEqual(field1.invalid, true)
        
        field1.invalidValues = "no"
        field1.value = true as AnyObject
        XCTAssertEqual(field1.invalid, false)
        
        field1.invalidValues = "1"
        field1.value = true as AnyObject
        XCTAssertEqual(field1.invalid, true)
        
        field1.invalidValues = "YES"
        field1.value = true as AnyObject
        XCTAssertEqual(field1.invalid, true)
        
        field1.invalidValues = "True"
        field1.value = true as AnyObject
        XCTAssertEqual(field1.invalid, true)
        
        field1.invalidValues = "TRUE"
        field1.value = true as AnyObject
        XCTAssertEqual(field1.invalid, true)
        
        field1.invalidValues = ""
        field1.value = true as AnyObject
        XCTAssertEqual(field1.invalid, false)
        
        
        field1.invalidValues = "no"
        field1.value = false as AnyObject
        XCTAssertEqual(field1.invalid, true)
        
        field1.invalidValues = "yes"
        field1.value = false as AnyObject
        XCTAssertEqual(field1.invalid, false)
        
        field1.invalidValues = "FALSE"
        field1.value = false as AnyObject
        XCTAssertEqual(field1.invalid, true)
        
        field1.invalidValues = "NO"
        field1.value = false as AnyObject
        XCTAssertEqual(field1.invalid, true)
        
        field1.invalidValues = "0"
        field1.value = false as AnyObject
        XCTAssertEqual(field1.invalid, true)
        
        field1.invalidValues = ""
        field1.value = false as AnyObject
        XCTAssertEqual(field1.invalid, false)
        
        field1.invalidValues = "2"
        field1.value = false as AnyObject
        XCTAssertEqual(field1.invalid, false)
        
    }

    func testFieldInvalid_emptyInvalidValues() {
        let field1 = PlainMobileFormField()
        
        field1.type = .logical
        field1.invalidValues = ""
        field1.value = true as AnyObject
        XCTAssertEqual(field1.invalid, false)
        
        field1.value = false as AnyObject
        XCTAssertEqual(field1.invalid, false)
        
        
        field1.type = .char
        field1.invalidValues = ""
        field1.value = "1" as AnyObject
        XCTAssertEqual(field1.invalid, false)
        
        field1.value = "a" as AnyObject
        XCTAssertEqual(field1.invalid, false)
    }
    
    func testSectionHasInvalidValues() {
        
        let section = PlainMobileFormSection()
        section.sequence = 1
        
        let field1 = PlainMobileFormField()
        field1.type = .char
        section.fields.append(field1)
        
        let field2 = PlainMobileFormField()
        field2.type = .char
        section.fields.append(field2)

        let field3 = PlainMobileFormField()
        field3.type = .logical
        section.fields.append(field3)
        
        XCTAssertEqual(section.hadInvalidValues, false)
        
        field2.value = "Z" as AnyObject
        field2.invalidValues = "Z"
        XCTAssertEqual(section.hadInvalidValues, true)
    }
}
