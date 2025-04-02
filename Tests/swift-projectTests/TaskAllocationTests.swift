import Testing
@testable import swift_project

struct ServerAllocationTests {
    @Test
    func testExactFitAllocation() {
        let list = TaskLinkedList()
        let taskA = Task(
            title: "A", 
            description: "", 
            priority: 1, 
            requiredRAM: 300, 
            estimatedTime: 10, 
            state: .todo)
        list.addTask(taskA)
        let taskB = Task(
            title: "B", 
            description: "", 
            priority: 1, 
            requiredRAM: 400, 
            estimatedTime: 10, 
            state: .todo)
        list.addTask(taskB)

        let server = Server(id: 1, availableRAM: 700)
        server.allocate(from: list)

        let total = server.allocatedTasks.reduce(0) { $0 + $1.requiredRAM }

        #expect(total == 700)
        #expect(server.allocatedTasks.count == 2)
        #expect(server.allocatedTasks.map(\.title).contains("A"))
        #expect(server.allocatedTasks.map(\.title).contains("B"))
        #expect(taskA.state == .inProgress)
        #expect(taskB.state == .inProgress)
    }

    @Test
    func testCannotFitTooBigTask() {
        let list = TaskLinkedList()
        let taskA = Task(
            title: "A", 
            description: "", 
            priority: 1, 
            requiredRAM: 800, 
            estimatedTime: 10, 
            state: .todo)
        list.addTask(taskA)
        let taskB = Task(
            title: "B", 
            description: "", 
            priority: 1, 
            requiredRAM: 200, 
            estimatedTime: 10, 
            state: .todo)
        list.addTask(taskB)

        let server = Server(id: 2, availableRAM: 500)
        server.allocate(from: list)

        #expect(server.allocatedTasks.contains(where: { $0.title == "A" }) == false)
        #expect(server.allocatedTasks.contains(where: { $0.title == "B" }) == true)
        #expect(taskB.state == .inProgress)
        #expect(taskA.state == .todo)
    }

    @Test
    func testMultipleValidCombinations() {
        let list = TaskLinkedList()
        let taskA = Task(
            title: "A", 
            description: "", 
            priority: 1, 
            requiredRAM: 300, 
            estimatedTime: 10, 
            state: .todo)
        list.addTask(taskA)
        let taskB = Task(
            title: "B", 
            description: "", 
            priority: 1, 
            requiredRAM: 500, 
            estimatedTime: 10, 
            state: .todo)
        list.addTask(taskB)
        let taskC = Task(
            title: "C", 
            description: "", 
            priority: 1, 
            requiredRAM: 400, 
            estimatedTime: 10, 
            state: .todo)
        list.addTask(taskC)
        let taskD = Task(
            title: "D", 
            description: "", 
            priority: 1, 
            requiredRAM: 200, 
            estimatedTime: 10, 
            state: .todo)
        list.addTask(taskD)

        let server = Server(id: 3, availableRAM: 700)
        server.allocate(from: list)

        let totalRAM = server.allocatedTasks.reduce(0) { $0 + $1.requiredRAM }

        #expect(totalRAM == 700)
        #expect(server.allocatedTasks.count >= 1)
        for task in server.allocatedTasks {
            #expect(task.state == .inProgress)
        }
    }

    @Test
    func testNoAvailableTodoTasks() {
        let list = TaskLinkedList()
        let taskA = Task(
            title: "A", 
            description: "", 
            priority: 1, 
            requiredRAM: 300, 
            estimatedTime: 10, 
            state: .inProgress)
        list.addTask(taskA)
        let taskB = Task(
            title: "B", 
            description: "", 
            priority: 1, 
            requiredRAM: 300, 
            estimatedTime: 10, 
            state: .completed)
        list.addTask(taskB)

        let server = Server(id: 4, availableRAM: 700)
        server.allocate(from: list)

        #expect(server.allocatedTasks.isEmpty)
        #expect(taskA.state == .inProgress)
        #expect(taskB.state == .completed)
    }

    @Test
    func testPartialAllocationStillValid() {
        let list: TaskLinkedListProtocol = TaskLinkedList()
        let taskA = Task(
            title: "A", 
            description: "", 
            priority: 1, 
            requiredRAM: 250, 
            estimatedTime: 10, 
            state: .todo)
        list.addTask(taskA)
        let taskB = Task(
            title: "B", 
            description: "", 
            priority: 1, 
            requiredRAM: 350, 
            estimatedTime: 10, 
            state: .todo)
        list.addTask(taskB)
        let taskC = Task(
            title: "C", 
            description: "", 
            priority: 1, 
            requiredRAM: 200, 
            estimatedTime: 10, 
            state: .todo)
        list.addTask(taskC)

        let server = Server(id: 5, availableRAM: 500)
        server.allocate(from: list)

        let totalRAM = server.allocatedTasks.reduce(0) { $0 + $1.requiredRAM }

        #expect(totalRAM <= 500)
        #expect(totalRAM > 0)
        for task in server.allocatedTasks {
            #expect(task.state == .inProgress)
        }
    }
}
