extension String {
    /// Машинное зрение может распознать цифры как буквы.
    /// Этот метод заменяет букву на похожую цифру.
    var replaceLettersToNumbers: String {
        let s = replacingOccurrences(of: "S", with: "5")
        let b = s.replacingOccurrences(of: "b", with: "6")
        let D = b.replacingOccurrences(of: "D", with: "0")
        let B = D.replacingOccurrences(of: "B", with: "3")
        let H = B.replacingOccurrences(of: "H", with: "4")
        let g = H.replacingOccurrences(of: "g", with: "3")
        let L = g.replacingOccurrences(of: "L", with: "6")
        return L
    }
}
