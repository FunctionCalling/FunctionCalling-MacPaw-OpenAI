// The Swift Programming Language
// https://docs.swift.org/swift-book

import FunctionCalling
import OpenAI

extension ToolContainer {
    public var macPawOpenAITools: [ChatQuery.ChatCompletionToolParam] {
        guard let allTools else {
            return []
        }

        return allTools.compactMap { ChatQuery.ChatCompletionToolParam(tool: $0) }
    }
}
