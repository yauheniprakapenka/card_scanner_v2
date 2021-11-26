extension String {
    /// Удаляет пробелы и переносы на новую строку из распознанного
    /// машинным зрения текста.
    var removeAllWhitespaceAndNewline: String {
        let newLineRemoved = replacingOccurrences(of: "\n", with: "")
        let newLineAndSpacesRemoved = newLineRemoved.replacingOccurrences(of: " ", with: "")
        return newLineAndSpacesRemoved
    }
}
