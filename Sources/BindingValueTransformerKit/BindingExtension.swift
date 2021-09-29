//
//  BindingExtension.swift
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

public extension Binding {
    func transform<T>(using transformerKey: KeyPath<BindingValueTransformerName, T.Type>) -> Binding<T.OutputType> where T: BindingValueTransformer, T.InputType == Value {
        T.makeBinding(from: self)
    }
    
    func produce<T>(using producerKey: KeyPath<BindingValueProducerName, T.Type>) -> T.OutputType where T: BindingValueProducer, T.InputType == Value {
        T.produce(from: wrappedValue)
    }
    
    func produce<T>(with producer: (Value) throws -> T) rethrows -> T {
        try producer(wrappedValue)
    }
}

public extension Binding where Value: Equatable {
    func equals(_ value: Value) -> Binding<Bool> {
        .init {
            wrappedValue == value
        } set: { flag in
            guard flag else { return }
            wrappedValue = value
        }
    }
}

extension Binding {
    func transform<T>(using transformerType: T.Type) -> Binding<T.OutputType> where T: BindingValueTransformer, T.InputType == Value {
        T.makeBinding(from: self)
    }
}

extension Binding where Value == Bool {
    
    /// A `Binding<Bool>` that negates the receiver's wrapped value.
    var negateBoolean: Binding<Bool> {
        transform(using: NagateBooleanBindingTransformer.self)
    }
}

extension Binding where Value: RawRepresentable {
    var rawValue: Binding<Value.RawValue> {
        transform(using: RawRepresentableBindingTransformer<Value>.self)
    }
}

enum RawRepresentableBindingTransformer<T: RawRepresentable>: BindingValueTransformer {
    static func transform(value: T) -> T.RawValue { value.rawValue }
    static func reverseTransform(value: T.RawValue) -> T { T(rawValue: value)! }
}
