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
        return self.sortTasks { $0.priority > $1.priority }
    }

    func orderedInsert(_ task: Task) {
        if self.head == nil || self.head?.item.priority ?? 0 > task.priority {
            self.add(task)
            return
        }

        var current = self.head
        while current?.next != nil && current?.next?.item.priority ?? 0 < task.priority {
            current = current?.next
        }

        let newNode = LinkedListNode(item: task)
        newNode.next = current?.next
        current?.next = newNode
    }
}