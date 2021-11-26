import Foundation
import MLKitTextRecognition

class CardNumberFilter: ScanFilter {
    private var cardNumberRegex: NSRegularExpression = try! NSRegularExpression(pattern: CardScannerRegexps.cardNumberRegex, options: [.anchorsMatchLines])
    
    var visionText: Text
    var scannerOptions: CardScannerOptions
    
    init(visionText: Text, scannerOptions: CardScannerOptions) {
        self.visionText = visionText
        self.scannerOptions = scannerOptions
    }
    
    func filter() -> ScanFilterResult? {
        for (blockIndex, block) in visionText.blocks.enumerated() {
            for (_, line) in block.lines.enumerated() {
                let scannedText = line.text
                let trimmedText = scannedText.removeAllWhitespaceAndNewline
                
                let minCardNumberCount = 16
                if trimmedText.count < minCardNumberCount {
                    continue
                }
                
                let replacedLettersText = trimmedText.replaceLettersToNumbers
       
                print("""
                ----------
                RESULT
                \(trimmedText) | remove All Whitespace And Newline"
                \(replacedLettersText) | replace Letters To Numbers
                ----------
                """)
                
                let replacedLettersToNumbersMatch = cardNumberRegex.firstMatch(
                    in: replacedLettersText,
                    range: NSRange(location: 0, length: replacedLettersText.count)
                )
                
                if replacedLettersToNumbersMatch != nil {
                    print("MATCH: replacedLettersToNumbersMatch")
                    let cardNumber = (replacedLettersText as NSString).substring(with: replacedLettersToNumbersMatch!.range).trimmingCharacters(in: .whitespacesAndNewlines) as String
                    
                    if !cardNumber.isLuhnValid {
                        print("\(cardNumber) not valid\n")
                        continue
                    }
                    
                    print("\(cardNumber) valid")
                    
                    return CardNumberScanResult(
                        visionText: visionText,
                        textBlockIndex: blockIndex,
                        textBlock: block,
                        cardNumber: cardNumber
                    )
                }
            }
        }
        
        return nil
    }
    
}
