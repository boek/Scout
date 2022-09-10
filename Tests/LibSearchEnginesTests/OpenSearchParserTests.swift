//
//  OpenSearchParserTests.swift
//  
//
//  Created by Jeff Boek on 9/9/22.
//

@testable import LibSearchEngines
import XCTest

final class OpenSearchParserTests: XCTestCase {
    func testThatItCanParseAnOpenSearchDocument() throws {
        let searchEngine = try SearchPluginParser.parse(data: openSearchFileExample)
        XCTAssertEqual(searchEngine.name, "DuckDuckGo")
        XCTAssertEqual(searchEngine.suggestTemplate, "https://ac.duckduckgo.com/ac/?q={searchTerms}&type=list")
    }
}


fileprivate let openSearchFileExample = """
<SearchPlugin xmlns="http://www.mozilla.org/2006/browser/search/">
<ShortName>DuckDuckGo</ShortName>
<InputEncoding>UTF-8</InputEncoding>
<Image width="16" height="16">data:image/png;base64,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</Image>
<Url type="application/x-suggestions+json" method="GET" template="https://ac.duckduckgo.com/ac/">
  <Param name="q" value="{searchTerms}"/>
  <Param name="type" value="list"/>
</Url>
<!-- this is effectively x-moz-phonesearch, but search service expects a text/html entry -->
<Url type="text/html" method="GET" template="https://duckduckgo.com/">
  <Param name="q" value="{searchTerms}"/>
  <Param name="t" value="ffocus"/>
</Url>
<Url type="application/x-moz-tabletsearch" method="GET" template="https://duckduckgo.com/">
  <Param name="q" value="{searchTerms}"/>
  <Param name="t" value="ffocus"/>
</Url>
<SearchForm>https://duckduckgo.com</SearchForm>
</SearchPlugin>
""".data(using: .utf8)!