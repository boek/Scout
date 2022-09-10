//
//  File.swift
//  
//
//  Created by Jeff Boek on 9/9/22.
//

import Foundation
struct InvalidXMLError: Error {}

typealias Attributes = [String : String]
typealias Params = [String : String]


struct TemplateBuilder {
    var type: String?
    var template: String?
    var params: [String : String] = [:]

    func build() -> String? {
        guard let template = template else { return nil }
        let params = params.compactMap { $0 + "=" + $1 }.sorted().joined(separator: "&")
        return template + "?" + params
    }
}

struct ParserState {
    var shortName: String?
    var image: String?
    var searchTemplate: String?
    var suggestTemplate: String?
    var templateBuilder: TemplateBuilder?
    var buffer: String = ""
}

enum ParserAction {
    case beganElement(String, Attributes)
    case endElement(String)
    case appendBuffer(String)
}

let reducer: (inout ParserState, ParserAction) -> Void = { state, action in
    if case .beganElement = action {
        state.buffer = ""
    }

    switch action {
    case .appendBuffer(let buffer): state.buffer += buffer
    case .beganElement("Url", let attributes):
        let type: String
        switch attributes["type"] {
        case "text/html": type = "search"
        case "application/x-suggestions+json": type = "suggest"
        default: return
        }

        state.templateBuilder = TemplateBuilder()
        state.templateBuilder?.type = type
        state.templateBuilder?.template = attributes["template"]
    case .beganElement("Param", let attributes):
        guard let name = attributes["name"], let value = attributes["value"] else { return }
        state.templateBuilder?.params[name] = value
    case .endElement("ShortName"): state.shortName = state.buffer
    case .endElement("Image"): state.image = state.buffer
    case .endElement("Url"):
        if state.templateBuilder?.type == "search" {
            state.searchTemplate = state.templateBuilder?.build()
        } else if state.templateBuilder?.type == "suggest" {
            state.suggestTemplate = state.templateBuilder?.build()
        }
        state.templateBuilder = nil
    default: break
    }
}


private enum SearchPluginElement: String {
    case ShortName
    case Image
    case Url
    case Param
}

private class OpenSearchPluginParser: XMLParser, XMLParserDelegate {
    var state = ParserState()
    
    convenience init(xmlData: Data) {
        self.init(data: xmlData)
        delegate = self
    }

    func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName: String?,
        attributes: [String : String] = [:]
    ) {
        reducer(&state, .beganElement(elementName, attributes))
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        reducer(&state, .appendBuffer(string))
    }

    func parser(
        _ parser: XMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName: String?
    ) {
        reducer(&state, .endElement(elementName))
    }

    func parserDidEndDocument(_ parser: XMLParser) { }

    func parseSearchEngine() throws -> SearchEngine {
        parse()
        guard let name = state.shortName,
              let imageURL = state.image.flatMap(URL.init(string:)),
              let imageData = try? Data(contentsOf: imageURL),
              let queryTemplate = state.searchTemplate else { throw InvalidXMLError() }

        return SearchEngine(
            name: name,
            image: imageData,
            queryTemplate: queryTemplate,
            suggestTemplate: state.suggestTemplate
        )
    }
}

struct SearchPluginParser {
    static func parse(data: Data) throws -> SearchEngine {
        let parser = OpenSearchPluginParser(xmlData: data)
        return try parser.parseSearchEngine()
    }
}
