import Foundation

public extension Array where Element: Collection {
    func flatten() -> [Element.Element] {
        return reduce([], +)
    }
}

public extension Array {
    func filterAsInstanceOf<T>(_:T.Type) -> [T] {
        compactMap { $0 as? T }
    }
    
    func `as`<T>(_:T.Type) -> [T] {
        filterAsInstanceOf(T.self)
    }
}
