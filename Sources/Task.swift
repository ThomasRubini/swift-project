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
