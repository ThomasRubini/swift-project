protocol LinkedListProtocol {
    associatedtype Element: Equatable

    var head: LinkedListNode<Element>? { get set }
    var tail: LinkedListNode<Element>? { get set }

    func add(_ t: Element)
}

class LinkedListNode<T: Equatable> {
    var item: T
    var next: LinkedListNode?

    init(item: T) {
        self.item = item
        self.next = nil
    }
}

class LinkedList<T: Equatable>: LinkedListProtocol{
    typealias Element = T

    var head: LinkedListNode<T>?
    var tail: LinkedListNode<T>?

    init() {
        self.head = nil
        self.tail = nil
    }

    func add(_ t: Element) {
        let newNode = LinkedListNode(item: t)
        if let tail = tail {
            tail.next = newNode
        } else {
            head = newNode
        }
        tail = newNode
    }

    func deleteItem(t: Element) -> Bool {
        var current = head
        var previous: LinkedListNode<T>?

        while let node = current {
            if node.item == t {
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

