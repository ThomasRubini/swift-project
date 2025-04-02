class TaskLinkedList: LinkedList<Task> {
    func addTask(_ task: Task) {
        self.add(task)
    }

    func deleteFromId(_ id: Int) -> Bool {
        return self.deleteByIndex(id)
    }

    func updateState(by title: String, newState: TaskState) -> Bool {
        let res = self.findWhere { $0.title == title }
        res?.state = newState
        return res != nil
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