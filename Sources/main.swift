import Foundation

func generateRandomTitle() -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let length = Int.random(in: 5...15)
    return String((0..<length).map { _ in letters.randomElement()! })
}

func generateRandomTask() -> Task {
    return Task(
        title: generateRandomTitle(),
        description: "Some description",
        priority: Int.random(in: 1...10000),
        requiredRAM: 0,
        estimatedTime: 0,
        state: TaskState.allCases.randomElement()!
    )
}

func generateRandomTasks(count: Int) -> TaskLinkedList {
    let list = TaskLinkedList()
    for _ in 0..<count {
        list.add(generateRandomTask())
    }
    return list
}

func perf_csv() {
    print("count,ms")

    let samples = stride(from: 0, through: 10000, by: 500).map { $0 }
    
    for count in samples {
        let taskList = generateRandomTasks(count: count)
        let startTime = Date()
        taskList.sortTasks()
        let endTime = Date()
        let elapsedTime = (endTime.timeIntervalSince(startTime) * 1000).rounded()
        print("\(count),\(elapsedTime)")
    }
}


func main() {
    if CommandLine.arguments.count == 1 {
        print("No arguments provided.")
        exit(1)
    }
    switch CommandLine.arguments[1] {
    case "perf_csv":
        perf_csv()
    default:
        print("Unknown command. See code.")
    }
}

main()