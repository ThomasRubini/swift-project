class LinkedListNode {
    var task: Task
    var next: LinkedListNode?

    init(task: Task) {
        self.task = task
        self.next = nil
    }
}

class LinkedList {
    var head: LinkedListNode?
    var tail: LinkedListNode?

    init() {
        self.head = nil
        self.tail = nil
    }

    func addTask(_ task: Task) {
        let newNode = LinkedListNode(task: task)
        if let tail = tail {
            tail.next = newNode
        } else {
            head = newNode
        }
        tail = newNode
    }

    func deleteTaskFromId(by title: String) -> Bool {
        var current = head
        var previous: LinkedListNode?

        while let node = current {
            if node.task.title == title {
                if node === head {
                    head = node.next
                    if node === tail {
                        tail = nil
                    }
                } else if node === tail {
                    tail = previous
                    tail?.next = nil
                } else {
                    previous?.next = node.next
                }
                return true
            }
            previous = current
            current = node.next
        }
        return false
    }
}