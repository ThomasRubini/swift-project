import Foundation

enum TaskState: String {
    case todo = "à faire"
    case inProgress = "en cours"
    case completed = "terminée"
}

protocol TaskProtocol {
    var title: String { get set }
    var description: String { get set }
    var priority: Int { get set }
    var requiredRAM: Int { get set }
    var estimatedTime: Double { get set }
    var state: TaskState { get set }
}

struct Task : TaskProtocol {
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
}