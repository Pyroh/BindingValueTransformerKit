//
//  EmptyNilTransformer.swift
//
//  BindingValueTransformerKit
//
//  MIT License
//
//  Copyright (c) 2021 Pierre Tacchi
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import SwiftUI
import OptionalType

enum NilIfEmptyBindingTransformer<T: _EmptiableCollection>: BindingValueTransformer {
    static func transform(value: T) -> T? { value.isEmpty ? nil : value }
    static func reverseTransform(value: T?) -> T { value ?? .empty }
}

enum EmptyIfNilBindingTransformer<T: OptionalType>: BindingValueTransformer where T.Wrapped: _EmptiableCollection {
    static func transform(value: T) -> T.Wrapped { value.wrapped ?? .empty }
    static func reverseTransform(value: T.Wrapped) -> T { value.isEmpty ? nil : .wrap(value) }
}

public extension Binding where Value: _EmptiableCollection {
    var nilIfEmpty: Binding<Value?> {
        transform(using: NilIfEmptyBindingTransformer.self)
    }
}

public extension Binding where Value: OptionalType, Value.Wrapped: _EmptiableCollection {
    var emptyIfNil: Binding<Value.Wrapped> {
        transform(using: EmptyIfNilBindingTransformer.self)
    }
}
