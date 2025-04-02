class TaskLinkedList: LinkedList<Task> {
    func addTask(_ task: Task) {
        self.add(task)
    }

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