protocol SortProtocol<ListProtocol>{
    mutating func sort(list: inout ListProtocol) -> ListProtocol
}