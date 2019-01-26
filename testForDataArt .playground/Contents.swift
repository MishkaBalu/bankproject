import UIKit

extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    func substring(_ r: Range<Int>) -> String {
        let fromIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
        let toIndex = self.index(self.startIndex, offsetBy: r.upperBound)
        let indexRange = Range<String.Index>(uncheckedBounds: (lower: fromIndex, upper: toIndex))
        return String(self[indexRange])
    }
}

//1. Sort array of strings by string length
var a = ["abc", "a", "123ff", "re", ""]

func sortByLength (_ array: [String]) -> [String] {
    var arr = array
    for _ in 0...arr.count{
        for j in 1..<arr.count {
            if arr[j-1].count > arr[j].count {
                let longer = arr[j-1]
                arr[j-1] = arr[j]
                arr[j] = longer
            }
        }
    }
    return arr
}
print("input:  \(a)")
print("result: \(sortByLength(a))")


//2. Archive string (if symbol repeats more than 2 times -> display symbol and number of repeats)
var str = "aabcdddddeaattttt"
//First option
func archiveString1 (_ inputString: String) -> String {
    var str = inputString
    var substrings = [String]()
    var currentChar = str[0]
    var previousChar = str[0]
    var currentCharCount = 0
    for i in 0..<str.count {
        currentChar = str[i]
        
        if currentChar != previousChar {
            if currentCharCount > 2 {
                substrings.append(str.substring(i - currentCharCount..<i))
            }
            currentCharCount = 0
        }
        else if i == str.count - 1 {
            if currentCharCount > 2 {
                substrings.append(str.substring(i - currentCharCount..<str.count))
            }
        }
        currentCharCount += 1
        
        previousChar = currentChar
    }

    for substr in substrings {
        str = str.replacingOccurrences(of: substr, with: "\(substr[0])\(substr.count)")
    }
    return str
}

print("input:  \(str)")
print("result: \(archiveString1(str))")


//Second option:
func archiveString2(string: String) -> String {
    var resultString = ""
    
    var currentCharCount: Int = 1
    var currentChar: Character?
    
    func handleCurrentSubstring() {
        guard let char = currentChar else { return }
        var substring: String
        
        if currentCharCount < 3 {
            substring = String(repeating: char, count: currentCharCount)
        } else {
            substring = "\(char)\(currentCharCount)"
        }
        resultString.append(substring)
    }
    
    for (_, char) in string.enumerated() {
        if currentChar != char {
            handleCurrentSubstring()
            currentChar = char
            currentCharCount = 1
        } else {
            currentCharCount += 1
        }
    }
    
    handleCurrentSubstring()
    
    return resultString
}

print("input:  \(str)")
print("result: \(archiveString2(string: str))")
