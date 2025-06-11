//
//  ChatQuery+Extension.swift
//  FunctionCalling-MacPaw-OpenAI
//
//  Created by 伊藤史 on 2024/09/27.
//

import FunctionCalling
import OpenAI

extension ChatQuery.ChatCompletionToolParam {
    init(tool: FunctionCalling.Tool) {
        self.init(function: .init(tool: tool))
    }
}

extension ChatQuery.ChatCompletionToolParam.FunctionDefinition {
    init(tool: FunctionCalling.Tool) {
        self.init(
            name: tool.name,
            description: tool.description,
            parameters: AnyJSONSchema(inputSchema: tool.inputSchema)
        )
    }
}

extension AnyJSONSchema {
    init(inputSchema: InputSchema) {
        self.init(fields: [
            .type(JSONSchemaInstanceType(type: inputSchema.type)),
            .properties(inputSchema.properties?.mapValues { AnyJSONSchema(inputSchema: $0) } ?? [:]),
            .required(inputSchema.requiredProperties ?? []),
            .enumValues(inputSchema.enumValues ?? [])
        ])
    }
}

extension JSONSchemaInstanceType {
    init(type: InputSchema.DataType) {
        switch type {
        case .string:
            self = .string
        case .number:
            self = .number
        case .integer:
            self = .integer
        case .boolean:
            self = .boolean
        case .array:
            self = .array
        case .object:
            self = .object
        }
    }
}
