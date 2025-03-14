protocol ServerProtocol {
    var id: Int { get set }
    var availableRAM: Int { get set }
    var allocatedTasks: [Task] { get set }

    mutating func allocate(task: Task) -> Bool
}

struct Server: ServerProtocol {
    var id: Int
    var availableRAM: Int
    var allocatedTasks: [Task]

    init(id: Int, availableRAM: Int) {
        self.id = id
        self.availableRAM = availableRAM
        self.allocatedTasks = []
    }

    mutating func allocate(task: Task) -> Bool {
        guard task.requiredRAM <= availableRAM else { return false }
        allocatedTasks.append(task)
        availableRAM -= task.requiredRAM
        return true
    }
}
