import Testing
@testable import swift_project

@Suite
struct DemoTests {
    @Test
    func testAddTask() {
        let linkedList = LinkedList()

        let task = Task(
            id: 1,
            title: "Tâche Test",
            description: "Description test",
            priority: 5,
            requiredRAM: 256,
            estimatedTime: 120,
            state: .todo
        )

        linkedList.addTask(task)

        guard let headTask = linkedList.head?.task else {
            #expect(Bool(false), "La tête de la liste ne devrait pas être nil après l'ajout d'une tâche.")
            return
        }

        #expect(headTask.id == task.id)
        #expect(headTask.title == "Tâche Test")
        #expect(linkedList.head?.next == nil)
    }
}