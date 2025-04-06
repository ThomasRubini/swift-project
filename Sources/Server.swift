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

    // Allocate tasks to the server using a dynamic programming approach, to maximize the total RAM used (not the number of tasks allocated !)
    func allocate(from taskList: any TaskLinkedListProtocol) {
        var tasksArray: [Task] = []

        // Collect all tasks in the todo state
        for task in taskList {
            if task.state == TaskState.todo {
                tasksArray.append(task)
            }
        }

        // Handle special case
        if tasksArray.count == 0 || availableRAM == 0 {
            allocatedTasks = []
            return
        }

        // Build the DP table (precompute everything)
        var dp = Array(repeating: Array(repeating: 0, count: availableRAM + 1), count: tasksArray.count + 1)

        for task in 1...tasksArray.count { // 
            let requiredRAM = tasksArray[task - 1].requiredRAM
            for ramCapacity in 0...availableRAM { // simulate every possible capacity
                if requiredRAM <= ramCapacity { // If the task can fit in the simulated capacity
                    // Add it
                    dp[task][ramCapacity] = max(
                        dp[task - 1][ramCapacity],
                        dp[task - 1][ramCapacity - requiredRAM] + requiredRAM
                    )
                } else {
                    // Skip it
                    dp[task][ramCapacity] = dp[task - 1][ramCapacity]
                }
            }
        }

        // Reconstruct optimal solution from the DP table
        var w = availableRAM
        var selectedTasks: [Task] = []

        for i in stride(from: tasksArray.count, through: 1, by: -1) {
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
