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
            parameters: FunctionParameters(inputSchema: tool.inputSchema)
        )
    }
}

extension ChatQuery.ChatCompletionToolParam.FunctionDefinition.FunctionParameters {
    init(inputSchema: InputSchema) {
        self.init(
            type: JSONType(dataType: inputSchema.type),
            properties: inputSchema.properties?.mapValues { Property(inputSchema: $0) },
            required: inputSchema.requiredProperties,
            enum: inputSchema.enumValues
        )
    }
}

extension ChatQuery.ChatCompletionToolParam.FunctionDefinition.FunctionParameters.Property.Items {
    init?(inputSchema: InputSchema?) {
        guard let inputSchema else {
            return nil
        }

        self.init(
            type: JSONType(dataType: inputSchema.type),
            properties: inputSchema.properties?.mapValues {
                ChatQuery.ChatCompletionToolParam.FunctionDefinition.FunctionParameters.Property(inputSchema: $0)
            },
            enum: inputSchema.enumValues
        )
    }
}

extension ChatQuery.ChatCompletionToolParam.FunctionDefinition.FunctionParameters.Property {
    init(inputSchema: InputSchema) {
        self.init(
            type: JSONType(dataType: inputSchema.type),
            description: inputSchema.description,
            format: inputSchema.format,
            items: Items(inputSchema: inputSchema.items),
            required: inputSchema.requiredProperties,
            enum: inputSchema.enumValues
        )
    }
}

extension ChatQuery.ChatCompletionToolParam.FunctionDefinition.FunctionParameters.JSONType {
    init(dataType: InputSchema.DataType) {
        switch dataType {
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
