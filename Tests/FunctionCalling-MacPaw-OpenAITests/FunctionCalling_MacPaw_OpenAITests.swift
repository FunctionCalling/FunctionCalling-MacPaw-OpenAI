import Testing
@testable import FunctionCalling_MacPaw_OpenAI
import FunctionCalling

actor MacPawOpenAITests {
    @FunctionCalling(service: .claude)
    struct FunctionContainer {
        /// Return current weather of location that passed by the argument
        /// - Parameter location: location that
        /// - Returns: string of weather
        @CallableFunction
        func getWeather(location: String) -> String {
            return "Sunny"
        }
        
        @CallableFunction
        func getStock(args: String) -> Int {
            return 0
        }
    }

    @Test func checkConvertedResults() async throws {
        let functions = FunctionContainer().macPawOpenAITools
        
        #expect(functions.count == 2)
        
        let getWeather = try #require(functions.first?.function)
        #expect(getWeather.name == "getWeather")
        #expect(getWeather.description == """
        Return current weather of location that passed by the argument- Parameter location: location that- Returns: string of weather
        """)
        
        let getStock = try #require(functions[1].function)
        #expect(getStock.name == "getStock")
        #expect(getStock.description == "")
    }
}
