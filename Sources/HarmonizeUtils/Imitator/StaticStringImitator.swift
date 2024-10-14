//
//  StaticStringImitator.swift
//  SwiftLint
//
//  Copyright (c) 2020 Realm Inc. All Rights Reserved.
//

// Taken from: https://github.com/realm/SwiftLint/blob/9ebd6ae9d20798b111bd7088e3c247be4473b006/Tests/IntegrationTests/IntegrationTests.swift#L74
// We're using the smart hacky above to be able to also hack `XCTFail`
// So we can assert errors in the original source code location.
package struct StaticStringImitator {
    let string: String

    func withStaticString(_ closure: (StaticString) -> Void) {
        let isASCII = string.utf8.allSatisfy { $0 < 0x7f }
        string.utf8CString.dropLast().withUnsafeBytes {
            let imitator = Imitator(startPtr: $0.baseAddress!, utf8CodeUnitCount: $0.count, isASCII: isASCII)
            closure(imitator.staticString)
        }
    }

    struct Imitator {
        let startPtr: UnsafeRawPointer
        let utf8CodeUnitCount: Int
        let flags: Int8

        init(startPtr: UnsafeRawPointer, utf8CodeUnitCount: Int, isASCII: Bool) {
            self.startPtr = startPtr
            self.utf8CodeUnitCount = utf8CodeUnitCount
            flags = isASCII ? 0x2 : 0x0
        }

        var staticString: StaticString {
            unsafeBitCast(self, to: StaticString.self)
        }
    }
}

package extension String {
    func withStaticString(_ closure: (StaticString) -> Void) {
        StaticStringImitator(string: self).withStaticString(closure)
    }
}
