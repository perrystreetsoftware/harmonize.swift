import Foundation

internal extension Array {
    func filterAsInstanceOf<T>(_:T.Type) -> [T] {
        compactMap { $0 as? T }
    }
    
    func `as`<T>(_:T.Type) -> [T] {
        filterAsInstanceOf(T.self)
    }
}
