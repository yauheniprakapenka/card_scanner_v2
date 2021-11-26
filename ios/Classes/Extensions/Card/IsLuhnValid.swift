extension String {
    var isLuhnValid: Bool {
        let digitList: [Int] = self.reversed().enumerated().map { (index, element) in
            var num = Int("\(element)") ?? 0
            if (index % 2 == 1) {
                num = (num * 2)
                num = (num == 0) ? num : (num % 9 == 0) ? 9 : num % 9
            }
            return num
        }
        
        return (digitList.reduce(0, +)) % 10 == 0
    }
}
