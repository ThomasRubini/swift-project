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
}