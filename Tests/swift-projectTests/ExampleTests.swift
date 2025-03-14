import Testing
@testable import swift_project

@Suite
struct DemoTests {
    @Test
    func testAddTask() {
        let linkedList = LinkedList()

        let task = Task(
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

        #expect(headTask.title == task.title)
        #expect(headTask.title == "Tâche Test")
        #expect(linkedList.head?.next == nil)
    }

    @Test
    func testDeleteFromId() {
        let linkedList = LinkedList()

        let task1 = Task(title: "Tâche 1", description: "Desc 1", priority: 2, requiredRAM: 128, estimatedTime: 60, state: .todo)
        let task2 = Task(title: "Tâche 2", description: "Desc 2", priority: 4, requiredRAM: 256, estimatedTime: 120, state: .inProgress)

        linkedList.addTask(task1)
        linkedList.addTask(task2)

        let deleteResult = linkedList.deleteTaskFromId(by: task1.title)
        #expect(deleteResult, "La tâche devrait être supprimée avec succès.")

        guard let headTask = linkedList.head?.task else {
            #expect(Bool(false), "La liste ne devrait pas être vide après la suppression d'une tâche.")
            return
        }

        #expect(headTask.title == task2.title, "La tête de la liste devrait être la deuxième tâche après la suppression de la première.")
        #expect(linkedList.head?.next == nil, "Il ne devrait rester qu'une seule tâche après la suppression.")

        let failedDelete = linkedList.deleteTaskFromId(by: task1.title)
        #expect(!failedDelete, "Supprimer une tâche déjà supprimée devrait retourner false.")
    }
}