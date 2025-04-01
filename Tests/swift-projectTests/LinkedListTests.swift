import Testing
@testable import swift_project

@Suite
struct LinkedListTests {
    @Test
    func testAdd() {
        let linkedList = LinkedList<String>()

        linkedList.add("Hello")

        guard let headTask = linkedList.head else {
            #expect(Bool(false), "List head should not be nil after adding element.")
            return
        }

        #expect(linkedList.head?.next == nil)
        #expect(linkedList.head?.item == "Hello")
    }

    @Test
    func testDelete() {
        let linkedList = LinkedList<String>()

        linkedList.add("Hello")
        linkedList.add("World")

        let deleteResult = linkedList.delete("Hello")
        #expect(deleteResult, "Element should be deleted successfully.")

        guard let headTask = linkedList.head else {
            #expect(Bool(false), "List should not be empty after deleting an element.")
            return
        }

        #expect(headTask.item == "World", "List head should be the second element after deleting the first.")
        #expect(linkedList.head?.next == nil, "There should be only one element left after deleting.")
    }
}
