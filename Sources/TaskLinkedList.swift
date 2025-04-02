protocol TaskLinkedListProtocol: Sequence<Task> {
    func addTask(_ e: Task)
    func deleteFromId(_ id: Int) -> Bool
    func updateState(by title: String, newState: TaskState) -> Bool
    func sortTasks()
    func orderedInsert(_ newTask: Task)
}

class TaskLinkedList: LinkedList<Task>, TaskLinkedListProtocol {
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
        return self.sortTasks { $0.priority < $1.priority }
    }

    func orderedInsert(_ newTask: Task) {
        if self.head == nil || self.head!.item.priority > newTask.priority {
            let newHead = LinkedListNode(item: newTask)
            newHead.next = self.head
            self.head = newHead
            return
        }

        var current = self.head
        while current?.next != nil && current?.next?.item.priority ?? 0 < newTask.priority {
            current = current?.next
        }

        let newNode = LinkedListNode(item: newTask)
        newNode.next = current?.next
        current?.next = newNode
    }
}