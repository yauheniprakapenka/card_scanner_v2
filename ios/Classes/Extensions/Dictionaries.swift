extension Dictionary where Key == String, Value == Int {
    var mostFrequentData: String? {
        return self.sorted { (first, second) -> Bool in
            first.value > second.value
        }.first?.key
    }
}
