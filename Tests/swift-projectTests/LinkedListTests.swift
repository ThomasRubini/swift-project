import Testing
@testable import swift_project

@Suite
struct LinkedListTests {
    @Test
    func testEmptyList() {
        let linkedList = LinkedList<String>()

        #expect(linkedList.len() == 0, "List should be empty initially.")
        #expect(linkedList.get(0) == nil, "Getting an element from an empty list should return nil.")
    }

    @Test
    func testAddAndGet() {
        let linkedList = LinkedList<String>()

        linkedList.add("Hello")

        #expect(linkedList.len() == 1, "List should contain one element after adding.")
        #expect(linkedList.get(0) == "Hello", "First element should be 'Hello'.")
    }

    @Test
    func testdeleteByValue() {
        let linkedList = LinkedList<String>()

        linkedList.add("Hello")
        linkedList.add("World")

        #expect(linkedList.len() == 2, "List should contain two elements after adding.")

        let deleteResult = linkedList.deleteByValue("Hello")
        #expect(deleteResult, "Element should be deleted successfully.")

        #expect(linkedList.len() == 1, "List should contain one element after deletion.")
        #expect(linkedList.get(0) == "World", "First element should be 'World' after deletion.")
        #expect(linkedList.get(1) == nil, "Second element should be nil after deletion.")
    }

    func testDeleteByIndex() {
        let linkedList = LinkedList<String>()

        linkedList.add("Hello")
        linkedList.add("World")

        #expect(linkedList.len() == 2, "List should contain two elements after adding.")

        let deleteResult = linkedList.deleteByIndex(0)
        #expect(deleteResult, "Element should be deleted successfully.")

        #expect(linkedList.len() == 1, "List should contain one element after deletion.")
        #expect(linkedList.get(0) == "World", "First element should be 'World' after deletion.")
        #expect(linkedList.get(1) == nil, "Second element should be nil after deletion.")
    }

    @Test
    func testComplete() {
        let linkedList = LinkedList<String>()

        linkedList.add("Hello")
        linkedList.add("World")

        #expect(linkedList.len() == 2, "List should contain three elements after adding.")
        #expect(linkedList.get(0) == "Hello", "First element should be 'Hello'.")
        #expect(linkedList.get(1) == "World", "Second element should be 'World'.")
        #expect(linkedList.get(2) == nil, "Third element should be nil.")

        let deleteResult = linkedList.deleteByValue("Hello")
        #expect(deleteResult, "Element should be deleted successfully.")
        #expect(linkedList.len() == 1, "List should contain two elements after deletion.")
        #expect(linkedList.get(0) == "World", "First element should be 'World' after deletion.")
        #expect(linkedList.get(1) == nil, "Second element should be nil after deletion.")

        linkedList.add("Swift")
        #expect(linkedList.len() == 2, "List should contain three elements after adding.")
        #expect(linkedList.get(0) == "World", "First element should be 'Hello'.")
        #expect(linkedList.get(1) == "Swift", "Second element should be 'Swift'.")
        #expect(linkedList.get(2) == nil, "Third element should be nil.")
    }

    func testFindWhere() {
        let linkedList = LinkedList<String>()

        linkedList.add("Hello")
        linkedList.add("World")
        linkedList.add("Swift")

        #expect(linkedList.len() == 3, "List should contain three elements after adding.")

        let foundElement = linkedList.findWhere { $0 == "World" }
        #expect(foundElement == "World", "Found element should be 'World'.")

        let notFoundElement = linkedList.findWhere { $0 == "NotInList" }
        #expect(notFoundElement == nil, "Should return nil for not found element.")
    }
}
