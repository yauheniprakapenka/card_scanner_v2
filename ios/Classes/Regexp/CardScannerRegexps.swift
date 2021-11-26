struct CardScannerRegexps {
    static let cardNumberRegex = "^(\\s*\\d\\s*){16}$"
    static let expiryDateRegex = "(0[1-9]|1[0-2])/([0-9]{2})"
    static let cardHolderName = "^ *(([A-Z.]+ {0,2}){1,8}) *$" // A line containing name has : minimum 1 word and maximum 8 words
}
