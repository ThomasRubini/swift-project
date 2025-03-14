import Testing

@Suite
struct ExampleTest {
    @Test
    func isSorted() {
        var myList: [Int] = [1, 0, 2, 3, 10, -5, 1, 2, 3]
        var sortedList: [Int] = sort(myList)
        for i in 0..<sortedList.count - 1 {
            #expect(sortedList[i] <= sortedList[i + 1])
        }
    }
}
