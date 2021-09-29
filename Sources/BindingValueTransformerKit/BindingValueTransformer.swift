//
//  BindingValueTransformer.swift
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

public protocol BindingValueProducer {
    associatedtype InputType
    associatedtype OutputType
    
    static func produce(from value: InputType) -> OutputType
}

public protocol BindingValueTransformer {
    associatedtype InputType
    associatedtype OutputType
    
    static func transform(value: InputType) -> OutputType
    static func reverseTransform(value: OutputType) -> InputType
    
    static func makeBinding(from binding: Binding<InputType>) -> Binding<OutputType>
}

public extension BindingValueTransformer {
    static func makeBinding(from binding: Binding<InputType>) -> Binding<OutputType> {
        return .init {
            transform(value: binding.wrappedValue)
        } set: { newValue, transaction in
            let newValue = reverseTransform(value: newValue)
            binding.wrappedValue = newValue
        }
    }
}
