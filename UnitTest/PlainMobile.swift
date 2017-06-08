//
//  PlainMobileFormField.swift
//  PlainMobile
//
//  Created by Maksim Isaev on 05/06/2017.
//  Copyright © 2017 Maksim Isaev. All rights reserved.
//

import Foundation

enum LabelPosition: String {
    case none = "none"
    case side = "side"
    case top = "top"
}

enum FieldType: String {
    case char = "char"
    case logical = "log"
    case label = "label"
    case undefined = ""
}


class PlainMobileForm {
    var code: String = ""
    var desc: String = ""
    var type: String = ""
    var sections: [PlainMobileFormSection] = []
}

class PlainMobileFormSection {
    var sequence: Int = 0
    var title: String = ""
    var starting: Bool = false
    var nextSection: Int = 0
    var errorSection: Int = 0
    var fields: [PlainMobileFormField] = []
    
    var hadInvalidValues: Bool {
        return self.fields.filter({$0.invalid == true}).count > 0
    }
}

class PlainMobileFormField {
    var sequence: Int = 0
    var label: String = ""
    var order: Int = 0
    var valueSpan: Int = 0
    var labelSpan: Int = 0
    var append: Bool = false
    var labelPosition: LabelPosition = .side
    var type: FieldType = .undefined
    var invalidValues: String = ""
    var value: AnyObject?
    
    var totalSpan: Int {
        return labelPosition == .side ? valueSpan + labelSpan : valueSpan
    }
    
    var invalid: Bool {
        if invalidValues.characters.count == 0 {
            return false
        }
        if type == .char {
            if let stringValue = value as? String {
                let compareCharacters = "<>"
                if stringContainsChars(string: stringValue, contains: compareCharacters) {
                    return invalidComparing(targetString: stringValue)
                }
                let dashChar = "-"
                if stringContainsChars(string: invalidValues, contains: dashChar) {
                    return invalidFoundInRange(targetString: stringValue, separator: dashChar)
                }
                return invalidValues.lowercased().components(separatedBy: ",").contains(stringValue.lowercased())
            }
            return false
        }
        if type == .logical {
            if let boolValue = value as? Bool {
                switch invalidValues.lowercased() {
                case "1", "y", "yes", "true" :
                    return (boolValue == true)
                case "0", "n", "no", "false" :
                    return (boolValue == false)
                default:
                    return false
                }
            }
            return false
        }
        return false
    }
    
    func stringContainsChars(string: String, contains substring: String) -> Bool {
        if invalidValues.lowercased().rangeOfCharacter(from: CharacterSet(charactersIn: substring)) != nil {
            return true
        }
        return false
    }
    
    func invalidFoundInRange(targetString:String, separator: String) -> Bool {
        var invalidValuesAsArray = invalidValues.components(separatedBy: separator)
        
        if invalidValuesAsArray.count != 2 {
            return false
        }
        guard let lowerBound = Decimal(string: invalidValuesAsArray[0]) else {
            return false
        }
        guard let upperBound = Decimal(string: invalidValuesAsArray[1]) else {
            return false
        }
        guard let decimalValue = Decimal(string: targetString) else {
            return false
        }
        if lowerBound > upperBound {
            return false
        }
        if lowerBound...upperBound ~= decimalValue{
            return true
        }
        return false
    }
    
    func invalidComparing(targetString:String) -> Bool {
        guard let decimalValue = Decimal(string: targetString) else {
            return false
        }
        
        let less: Bool = invalidValues.contains("<")
        let more: Bool = invalidValues.contains(">")
        
        let removal: [Character] = ["<",">"," "]
        let invalidValuesAsCharacters = invalidValues.characters
        let clearedInvalidValue = invalidValuesAsCharacters.filter{ !removal.contains($0) }
        let clearedStringInvalidValue = String(clearedInvalidValue)
        guard let decimalInvalidValue = Decimal(string: clearedStringInvalidValue) else {
            return false
        }
        
        switch (less,more) {
        case (true,true): //<>
            return decimalValue != decimalInvalidValue
        case (false,true): //>
            return decimalValue > decimalInvalidValue
        case (true,false): //<
            return decimalValue < decimalInvalidValue
        default:
            return false
        }
    }
}






