# DataExtractor
A simple Swift 3.0 class using `NSDataDetector` to extract physical addresses, email addresses, phone numbers, and dates from a string.

**Methods**

Initializer:
	`let dataExtractor = DataExtractor()`

**`func getEmailAddress(from dataString: String) -> [String]`**

example usage:
	`dataExtractor.getEmailAddress(from myString)`

**`func getPhoneNumber(from: dataString: String) -> [String]`**

example usage:
	`dataExtractor.getPhoneNumber(from: myString)`

**`func getAddressData(from string: String) -> [Dictionary<String, Any>]`**

example usage:
	`dataExtractor.getAddressData(from myString)`

**'func getDateData(from string: String) -> [Date]'**

example usage:
	`dataExtractor.getDateData(from myString)`
