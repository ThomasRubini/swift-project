import Testing
@testable import swift_project

@Suite
struct DemoTests {
    @Test
    func testAddTask() {
        let linkedList = LinkedList<Task>()

        let task = Task(
            title: "Tâche Test",
            description: "Description test",
            priority: 5,
            requiredRAM: 256,
            estimatedTime: 120,
            state: .todo
        )

        linkedList.add(task)

        guard let headTask = linkedList.head else {
            #expect(Bool(false), "La tête de la liste ne devrait pas être nil après l'ajout d'une tâche.")
            return
        }

        #expect(linkedList.head?.next == nil)
    }
}
