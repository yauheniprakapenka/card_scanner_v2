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
                let sanitizedBlockText = line.text.sanitized
                print("Sanitized Card Number : \(sanitizedBlockText)")
                
                if let firstMatch = cardNumberRegex.firstMatch(
                    in: sanitizedBlockText,
                    range: NSRange(location: 0, length: sanitizedBlockText.count)
                ) {
                    let cardNumber = (sanitizedBlockText as NSString).substring(with: firstMatch.range).trimmingCharacters(in: .whitespacesAndNewlines) as String
                    
                    if !cardNumber.isLuhnValid {
                        print("Card \(cardNumber) is not valid")
                        continue
                    }
                    
                    print("Card \(cardNumber) is valid")
                    
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
