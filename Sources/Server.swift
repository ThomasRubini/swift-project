import Foundation

protocol ServerProtocol {
    var id: Int { get set }
    var availableRAM: Int { get set }
    var allocatedTasks: [Task] { get set }

}

class Server: ServerProtocol {
    var id: Int
    var availableRAM: Int
    var allocatedTasks: [Task]

    init(id: Int, availableRAM: Int) {
        self.id = id
        self.availableRAM = availableRAM
        self.allocatedTasks = []
    }


    func allocate(from taskList: any TaskLinkedListProtocol) {
        var tasksArray: [Task] = []

        // Collect all tasks in the todo state
        for task in taskList {
            if task.state == TaskState.todo {
                tasksArray.append(task)
            }
        }

        let tasksCount = tasksArray.count
        // Handle special case
        if tasksCount == 0 || availableRAM == 0 {
            allocatedTasks = []
            return
        }

        // DP table
        var dp = Array(repeating: Array(repeating: 0, count: availableRAM + 1), count: tasksCount + 1)

        for task in 1...tasksCount {
            let requiredRAM = tasksArray[task - 1].requiredRAM
            for ramCapacity in 0...availableRAM {
                if requiredRAM <= ramCapacity { // If the task can fit in the current capacity
                    dp[task][ramCapacity] = max(dp[task - 1][ramCapacity], dp[task - 1][ramCapacity - requiredRAM] + requiredRAM)
                } else {
                    dp[task][ramCapacity] = dp[task - 1][ramCapacity]
                }
            }
        }

        // Reconstruction
        var w = availableRAM
        var selectedTasks: [Task] = []

        for i in stride(from: tasksCount, through: 1, by: -1) {
            if dp[i][w] != dp[i - 1][w] {
                let task = tasksArray[i - 1]
                selectedTasks.append(task)
                w -= task.requiredRAM
            }
        }

        // Mark as in progress
        for task in selectedTasks {
            task.state = TaskState.inProgress
        }

        self.allocatedTasks = selectedTasks
    }


}
