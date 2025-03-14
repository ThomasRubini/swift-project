protocol SortProtocol {
    associatedtype ListProtocol
    mutating func sort(list: inout ListProtocol) -> ListProtocol
}
