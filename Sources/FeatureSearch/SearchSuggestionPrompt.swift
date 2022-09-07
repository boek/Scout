//
//  SearchSuggestionPrompt.swift
//  
//
//  Created by Jeff Boek on 9/6/22.
//

import SwiftUI

struct SearchSuggestionPrompt: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Show Search Suggestions?")
                .font(.title2)
                .bold()
            Text("To get suggestions Firefox Focus needs to send what you type in the address bar to the search engine")
                .font(.subheadline)

            HStack {
                Button("Yes") {}
                    .buttonStyle(.bordered)
                Button("No") {}
                    .buttonStyle(.bordered)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .multilineTextAlignment(.center)
    }
}

struct SearchSuggestionPrompt_Previews: PreviewProvider {
    static var previews: some View {
        SearchSuggestionPrompt()
    }
}
