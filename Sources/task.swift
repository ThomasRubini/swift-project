import Foundation

enum TaskState: String {
    case todo = "à faire"
    case inProgress = "en cours"
    case completed = "terminée"
}

struct Task : Equatable {
    var title: String              
    var description: String        
    var priority: Int              
    var requiredRAM: Int           
    var estimatedTime: Double       
    var state: TaskState             

    init(title: String, description: String, priority: Int, requiredRAM: Int, estimatedTime: Double, state: TaskState = .todo) {
        self.title = title
        self.description = description
        self.priority = priority
        self.requiredRAM = requiredRAM
        self.estimatedTime = estimatedTime
        self.state = state
    }
    
    static func == (lhs: Task, rhs: Task) -> Bool {
        lhs.title == rhs.title
    }
}

class TaskList: LinkedList<Task> {
    func updateTaskState(by title: String, newState: TaskState) -> Bool {
        var currentNode = self.head
        
        while let node = currentNode {
            if node.item.title == title {
                node.item.state = newState
                return true
            }
            currentNode = node.next
        }
        return false
    }

    func sortTasks() {
        var current = self.head

        while current != nil {
            var maxNode = current
            var searchNode = current?.next

            while searchNode != nil {
                if let searchPriority = searchNode?.item.priority, let maxPriority = maxNode?.item.priority,
                   searchPriority < maxPriority {
                    maxNode = searchNode
                }
                searchNode = searchNode?.next
            }

            if let currentTask = current?.item, let maxTask = maxNode?.item {
                current?.item = maxTask
                maxNode?.item = currentTask
            }

            current = current?.next
        }
    }
}