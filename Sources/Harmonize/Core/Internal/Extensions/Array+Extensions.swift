import Foundation

internal extension Array {
    func `as`<T>(_:T.Type) -> [T] {
        compactMap { $0 as? T }
    }
}
