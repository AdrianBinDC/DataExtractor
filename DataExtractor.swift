//
//  DataExtractor.swift
//
//  Created by Adrian Bolinger on 12/9/16.
//  Copyright © 2016 Adrian Bolinger. All rights reserved.
//  Special thanks to Duncan C for his assistance on getAddressData
//  http://stackoverflow.com/users/205185/duncan-c
//

import Foundation

/*
 This class extracts data from a string. Create initializer for the class and methods for feeding strings
 */

class DataExtractor: NSObject {
    
    /// String from which DataExtractor will extract data elements
    
    // MARK: - Initializers
    convenience init(string: String) {
        self.init()
    }
    
    // MARK: - Data Extraction Methods
    
    /// Extracts email addresses and returns an array of email address strings
    func getEmailAddress(from dataString: String) -> [String] {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        // (4):
        let matches = regex.matches(in: dataString, options: [], range: NSRange(location: 0, length: dataString.characters.count))
        
        var emailArray = [String]()
        
        for match in matches {
            let email = (dataString as NSString).substring(with: match.range)
            emailArray.append(email)
        }
        
        return emailArray
    }
    
    /// Extracts a phone number and returns an array of phone number strings
    func getPhoneNumber(from dataString: String) -> [String] {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
        let matches = detector.matches(in: dataString, options: [], range: NSRange(location: 0, length: dataString.utf16.count))
        
        var phoneNumberArray = [String]()
        
        // put matches into String array
        for match in matches {
            let phoneNumber = (dataString as NSString).substring(with: match.range)
            phoneNumberArray.append(phoneNumber)
        }
        
        // remove non-numeric characters from phone number
        var index = 0 // starts the index of the array off at zero
        for var phoneNumber in phoneNumberArray {
            let cleanPhoneNumber = String(phoneNumber.characters.filter { String($0).rangeOfCharacter(from: CharacterSet(charactersIn: "0123456789")) != nil })
            // take out the dirty phone number
            phoneNumberArray.remove(at: index)
            // insert the clean phone number
            phoneNumberArray.insert(cleanPhoneNumber, at: index)
            // increment for the next loop through phoneNumberArray
            index += 1
        }
        
        return phoneNumberArray
    }

    /// Returns array of address dictionaries from a String
    func getAddressData(from string: String) -> [Dictionary<String, Any>] {
        var addressData = [Dictionary<String, Any>()]
        
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.address.rawValue)
        let matches = detector.matches(in: string, options: [], range: NSRange(location: 0, length: string.utf16.count))
        
        // put matches into String array
        for match in matches {
            if match.resultType == .address {
                addressData.append(match.addressComponents!)
            }
        }
        
        return addressData
    }
    
    // Returns array of Date objects contained in a String
    func getDateData(from string: String) -> [Date] {
        var dateData = [Date]()
        
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.date.rawValue)
        let matches = detector.matches(in: string, options: [], range: NSRange(location: 0, length: string.utf16.count))
        
        // put matches into String array
        for match in matches {
            if match.resultType == .date {
                dateData.append(match.date!)
            }
        }
        
        return dateData
    }    
}
