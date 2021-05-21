//
//  BindingValueTransformerName.swift
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

///
/// This `enum` is dedicated to binding value transformers registration.
///
/// The registration if a new transformer starts with extending `BindingValueTransformerName`.
///
/// You then declare a new read-only computed property which type resolves to a `BindingValueTransformer` type.
/// The property is expected to return the type of the value transformer.
///
/// Here is an example of the registration of an hypothetical transformer `IntToDoubleValueTransformer`:
///
///     extension BindingValueTransformerName {
///         var intToDouble: IntToDoubleValueTransformer.Type {
///             IntToDoubleValueTransformer.self
///         }
///     }
///
/// The corresponding `intToDouble` transformer is now registered and can be used with any `Binding<Int>` instance.
/// `$someIntBinding.transform(using: \.intToDouble)`
///
public enum BindingValueTransformerName {
    public var negateBoolean: NagateBooleanBindingTransformer.Type {
        NagateBooleanBindingTransformer.self
    }
}

public enum BindingValueProducerName {
    
}
