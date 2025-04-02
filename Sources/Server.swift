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

        let n = tasksArray.count
        let maxRAM = availableRAM
        // Handle special case
        if n == 0 || maxRAM == 0 {
            allocatedTasks = []
            return
        }

        // DP table
        var dp = Array(repeating: Array(repeating: 0, count: maxRAM + 1), count: n + 1)

        for i in 1...n {
            let ram = tasksArray[i - 1].requiredRAM
            for w in 0...maxRAM {
                if ram <= w {
                    dp[i][w] = max(dp[i - 1][w], dp[i - 1][w - ram] + ram)
                } else {
                    dp[i][w] = dp[i - 1][w]
                }
            }
        }

        // Reconstruction
        var w = maxRAM
        var selectedTasks: [Task] = []

        for i in stride(from: n, through: 1, by: -1) {
            if dp[i][w] != dp[i - 1][w] {
                let task = tasksArray[i - 1]
                selectedTasks.append(task)
                w -= task.requiredRAM
            }
        }

        // Marquer comme en cours
        for task in selectedTasks {
            task.state = TaskState.inProgress
        }

        self.allocatedTasks = selectedTasks
    }


}
