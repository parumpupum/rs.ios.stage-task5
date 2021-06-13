import UIKit

class MessageDecryptor: NSObject {
    
    func decryptMessage(_ message: String) -> String {
        
        var result = message, isChangedKey = false
        while true{
            
            var currentCount = "", key = 0, newString = "", currentString = "", globalKey = 0, i = 0
            for char in result{
                if char >= "0" && char <= "9" && key == 0{ currentCount += String(char)}
                else if char >= "0" && char <= "9" && key == 1{
                    currentCount = String(char)
                    currentString = ""
                    key = 0
                }
                else if char == "[" && key == 1{
                    currentCount = ""
                    currentString = ""
                }
                else if char == "[" && key == 0 {key = 1}
                else if char == "]"{
                    newString = String(result.prefix(i - currentCount.count - 1 - currentString.count))
                    var cicleCount:Int? = Int(currentCount)
                    if currentCount.count == 0 {cicleCount = 1}
                    if cicleCount ?? 0 > 0{
                        for i in 1...(cicleCount ?? 0){
                            newString += currentString
                        }
                    }
                    newString += String(result.suffix(result.count - i - 1))
                    globalKey = 1
                    isChangedKey = true
                    break
                }
                else if key == 1 { currentString += String(char)}
                i += 1
            }
            if globalKey == 0 { break }
            result = newString
        }
        
        if (isChangedKey){return result}
        else {return message}
        
    }
    
}
