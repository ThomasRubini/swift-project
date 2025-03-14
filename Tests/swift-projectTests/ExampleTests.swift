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

        linkedList.add(task)

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
        let linkedList = TaskList()

        let task1 = Task(title: "Tâche 1", description: "Desc 1", priority: 2, requiredRAM: 128, estimatedTime: 60, state: .todo)
        let task2 = Task(title: "Tâche 2", description: "Desc 2", priority: 4, requiredRAM: 256, estimatedTime: 120, state: .inProgress)

        linkedList.add(task1)
        linkedList.add(task2)

        let deleteResult = linkedList.deleteItem(by: task1.title)
        #expect(deleteResult, "La tâche devrait être supprimée avec succès.")

        guard let headTask = linkedList.head?.task else {
            #expect(Bool(false), "La liste ne devrait pas être vide après la suppression d'une tâche.")
            return
        }

        #expect(headTask.title == task2.title, "La tête de la liste devrait être la deuxième tâche après la suppression de la première.")
        #expect(linkedList.head?.next == nil, "Il ne devrait rester qu'une seule tâche après la suppression.")

        let failedDelete = linkedList.deleteItem(by: task1.title)
        #expect(!failedDelete, "Supprimer une tâche déjà supprimée devrait retourner false.")
    }

    @Test
    func testUpdateTaskState() {
        let linkedList = TaskList()

        let task = Task(title: "Tâche à modifier", description: "Desc modifiable", priority: 3, requiredRAM: 512, estimatedTime: 90, state: .todo)
        linkedList.add(task)

        let updateResult = linkedList.updateTaskState(by: task.title, newState: .completed)
        #expect(updateResult, "La mise à jour de l'état devrait être réussie.")

        guard let updatedTask = linkedList.head?.task else {
            #expect(Bool(false), "La liste ne devrait pas être vide après la mise à jour d'une tâche.")
            return
        }

        #expect(updatedTask.state == .completed, "L'état de la tâche devrait être mis à jour à 'completed'.")
    }

    @Test
    func testSortTasksByPriority() {
        let linkedList = TaskList()

        let task1 = Task(title: "Basse priorité", description: "Desc", priority: 3, requiredRAM: 128, estimatedTime: 60, state: .todo)
        let task2 = Task(title: "Haute priorité", description: "Desc", priority: 1, requiredRAM: 256, estimatedTime: 120, state: .todo)
        let task3 = Task(title: "Priorité moyenne", description: "Desc", priority: 2, requiredRAM: 256, estimatedTime: 120, state: .todo)

        linkedList.add(task1)
        linkedList.add(task2)
        linkedList.add(task3)

        linkedList.sortTasks()

        var currentNode = linkedList.head
        #expect(currentNode?.task.priority == 1, "La première tâche devrait avoir la priorité la plus haute.")
        currentNode = currentNode?.next
        #expect(currentNode?.task.priority == 2, "La deuxième tâche devrait avoir une priorité moyenne.")
        currentNode = currentNode?.next
        #expect(currentNode?.task.priority == 3, "La troisième tâche devrait avoir la priorité la plus basse.")
    }
}