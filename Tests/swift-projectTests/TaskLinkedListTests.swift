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

    @Test
    func testUpdateState() {
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

        #expect(linkedList.updateState(by: "Test task", newState: .inProgress), "Task state should be updated.")
        #expect(linkedList.get(0)?.state == .inProgress, "Task state should be inProgress.")
    }

    func testSortTasks() {
        let linkedList = TaskLinkedList()

        let task1 = Task(
            title: "Task 1",
            description: "Description 1",
            priority: 3,
            requiredRAM: 256,
            estimatedTime: 120,
            state: .todo
        )

        let task2 = Task(
            title: "Task 2",
            description: "Description 2",
            priority: 1,
            requiredRAM: 512,
            estimatedTime: 60,
            state: .todo
        )

        let task3 = Task(
            title: "Task 3",
            description: "Description 3",
            priority: 2,
            requiredRAM: 128,
            estimatedTime: 90,
            state: .todo
        )

        linkedList.add(task1)
        linkedList.add(task2)
        linkedList.add(task3)

        linkedList.sortTasks()

        #expect(linkedList.get(0)!.priority < linkedList.get(1)!.priority, "First task should have the highest priority.")
        #expect(linkedList.get(1)!.priority < linkedList.get(2)!.priority, "Second task should have the second highest priority.")
    }

    func testOrderedInsert() {
        let linkedList = TaskLinkedList()

        let task1 = Task(
            title: "Task 1",
            description: "Description 1",
            priority: 3,
            requiredRAM: 256,
            estimatedTime: 120,
            state: .todo
        )

        let task2 = Task(
            title: "Task 2",
            description: "Description 2",
            priority: 1,
            requiredRAM: 512,
            estimatedTime: 60,
            state: .todo
        )

        let task3 = Task(
            title: "Task 3",
            description: "Description 3",
            priority: 2,
            requiredRAM: 128,
            estimatedTime: 90,
            state: .todo
        )

        linkedList.orderedInsert(task1)
        linkedList.orderedInsert(task2)
        linkedList.orderedInsert(task3)

        #expect(linkedList.get(0) == task2, "First task should be Task 2.")
        #expect(linkedList.get(1) == task3, "Second task should be Task 3.")
        #expect(linkedList.get(2) == task1, "Third task should be Task 1.")
    }
}
