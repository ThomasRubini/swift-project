import Testing
@testable import swift_project

@Suite
struct TaskLinkedListTests {
    @Test
    func testAddTask() {
        let linkedList = TaskLinkedList()

        let task = Task(
            title: "Test task",
            description: "Test description",
            priority: 5,
            requiredRAM: 256,
            estimatedTime: 120,
            state: .todo
        )

        linkedList.add(task)

        #expect(linkedList.len() == 1, "List should contain one task after adding.")
        #expect(linkedList.get(0) == task, "First task should be the one added.")
    }
}
