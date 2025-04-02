class LinkedListNode<T: Equatable> {
    var item: T
    var next: LinkedListNode?

    init(item: T) {
        self.item = item
        self.next = nil
    }
}

struct LinkedListIterator<T: Equatable>: IteratorProtocol {
    let list: LinkedList<T>
    var nextNode: LinkedListNode<T>?


    init(_ list: LinkedList<T>) {
        self.list = list
        self.nextNode = list.head
    }


    mutating func next() -> T? {
        let current: T? = nextNode?.item
        nextNode = nextNode?.next
        return current
    }
}


class LinkedList<T: Equatable>: Sequence {

    typealias Element = T

    var head: LinkedListNode<T>?
    var tail: LinkedListNode<T>?

    init() {
        self.head = nil
        self.tail = nil
    }

    func add(_ e: Element) {
        let newNode = LinkedListNode(item: e)
        if let tail = tail {
            tail.next = newNode
        } else {
            head = newNode
        }
        tail = newNode
    }

    func get(_ index: Int) -> T? {
        var currentIndex = 0
        for node in self {
            if currentIndex == index {
                return node
            }
            currentIndex += 1
        }
        return nil
    }

    func makeIterator() -> LinkedListIterator<T> {
        return LinkedListIterator(self)
    }

    func deleteByIndex(_ index: Int) -> Bool {
        guard index >= 0 else { return false }
        var current = head
        var previous: LinkedListNode<T>?
        var currentIndex = 0

        while let node = current {
            // Is it the right index?
            if currentIndex == index {
                if node === head { // if head
                    head = node.next
                    if node === tail {
                        tail = nil
                    }
                } else if node === tail { // if tail
                    tail = previous
                    tail?.next = nil
                } else { // in the middle
                    previous?.next = node.next
                }
                return true
            }
            previous = current
            current = node.next
            currentIndex += 1
        }
        return false
    }

    func deleteByValue(_ e: Element) -> Bool {
        var current = head
        var previous: LinkedListNode<T>?

        while let node = current {
            if node.item == e {
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

    func len() -> Int {
        var count = 0
        for _ in self {
            count += 1
        }

        return count
    }

    func findWhere(_ predicate: (T) -> Bool) -> T? {
        var current = head

        while let node = current {
            if predicate(node.item) {
                return node.item
            }
            current = node.next
        }
        return nil
    }

    func sortTasks(_ predicate: (T, T) -> Bool) {
        var current = self.head
        while current != nil {
            var maxNode = current
            var searchNode = current?.next

            while searchNode != nil {
                if predicate(searchNode!.item, maxNode!.item) {
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
