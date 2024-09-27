# FunctionCalling-MacPaw-OpenAI

This library simplifies the integration of the [FunctionCalling](https://github.com/fumito-ito/FunctionCalling) macro into [MacPaw/OpenAI](https://github.com/MacPaw/OpenAI). By using this library, you can directly generate `Tool` objects from Swift native functions, which can then be specified as FunctionCalling when invoking OpenAI.

## Usage

```swift

import FunctionCalling
import FunctionCalling_MacPaw_OpenAI
import OpenAI

// MARK: Declare the container and functions for the tools to be called from FunctionCalling.

@FunctionCalling(service: .chatGPT)
struct MyFunctionTools {
    @CallableFunction
    /// Get the current stock price for a given ticker symbol
    ///
    /// - Parameter: The stock ticker symbol, e.g. GOOG for Google Inc.
    func getStockPrice(ticker: String) async throws -> String {
        // code to return stock price of passed ticker
    }
}

// MARK: You can directly pass the tools generated from objects to the model in ChatQuery.
let query = ChatQuery(
    model: .gpt3_5Turbo,
    messages: [.init(role: .user, content: "who are you")],
    tools: FunctionContainer().macPawOpenAITools
)
let result = try await openAI.chats(query: query)
```

## Installation

### Swift Package Manager

```
let package = Package(
    name: "MyPackage",
    products: [...],
    targets: [
        .target(
            "YouAppModule",
            dependencies: [
                .product(name: "FunctionCalling-MacPaw-OpenAI", package: "FunctionCalling-MacPaw-OpenAI")
            ]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/FunctionCalling/FunctionCalling-MacPaw-OpenAI", from: "0.1.0")
    ]
)
```

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License

The MIT License
