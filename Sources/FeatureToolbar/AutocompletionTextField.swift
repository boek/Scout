//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/24/22.
//

import Combine
import SwiftUI

public struct AutocompleteTextfield: View {
    var placeholder: String
    @Binding var text: String
    var autocompleteValue: String?
    @State var shouldAutocomplete = true
    @State var previousValue = ""

    public init(
        placeholder: String,
        text: Binding<String>,
        autocompleteValue: String? = nil
    ) {
        self.placeholder = placeholder
        self._text = text
        self.autocompleteValue = autocompleteValue
    }

    public var body: some View {
        ZStack(alignment: .leading) {
            TextField(
                placeholder,
                text: $text
            )
            .background(alignment: .leading) {
                autocompletionView
            }
            .onReceive(Just(text)) { newValue in
                if shouldAutocomplete && newValue.count < previousValue.count && !newValue.isEmpty {
                    self.shouldAutocomplete = false
                    text = previousValue
                } else if !shouldAutocomplete && newValue.count > previousValue.count {
                    self.shouldAutocomplete = true
                    previousValue = text
                } else {
                    previousValue = text
                }
            }
        }
    }

    @ViewBuilder
    public var autocompletionView: some View {
        if let autocompleteValue = autocompleteValue {
            if shouldAutocomplete {
                HStack(spacing: 0) {
                    Text(text).opacity(0)
                    Text(autocompleteValue.replacingOccurrences(of: text, with: ""))
                        .background(Color.purple.opacity(0.2))
//                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct AutocompleteTextfield_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AutocompleteTextfield(
                placeholder: "Hello",
                text: .constant("")
            )
            AutocompleteTextfield(
                placeholder: "Hello",
                text: .constant("hello")
            )
            AutocompleteTextfield(
                placeholder: "Hello",
                text: .constant("https://goo"),
                autocompleteValue: "https://google.com/"
            )
        }.padding()
    }
}
