extension String {
    var cardNumberSized: String {
        return ((self as NSString).substring(to: count >= 16 ? 16 : count) as String)
    }
}
