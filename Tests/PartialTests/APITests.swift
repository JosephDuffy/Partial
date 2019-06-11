import Partial

struct APITests {

    /// Contains some example usage
    func testAPI() {
        struct Value {
            struct EmbeddedValue: PartialConvertible {
                let stringValue: String
                let optionaStringValue: String?

                init(partial: Partial<Value.EmbeddedValue>) throws {
                    stringValue = try partial.value(for: \.stringValue)
                    optionaStringValue = try partial.value(for: \.optionaStringValue)
                }
            }

            let stringValue: String
            let optionaStringValue: String?
            let embeddedValue: EmbeddedValue
            let optionalEmbeddedValue: EmbeddedValue?
        }

        var partial = Partial<Value>()
        partial[\.embeddedValue] = Partial<Value.EmbeddedValue>()
        partial.set(value: Partial<Value.EmbeddedValue>(), for: \Value.embeddedValue)

        partial[\.optionalEmbeddedValue] = Partial<Value.EmbeddedValue>()
        partial.set(value: Partial<Value.EmbeddedValue>(), for: \Value.optionalEmbeddedValue)

        // These should cause compiler warnings and not be possible
//        partial[\.optionalEmbeddedValue] = Partial<Value.EmbeddedValue?>()
//        partial.set(value: Partial<Value.EmbeddedValue?>(), for: \Value.optionalEmbeddedValue)
    }

}
