public struct KeyPathCodingKeyCollection<Root, CodingKey: Swift.CodingKey & Hashable> {
    public enum EncodeError: Error {
        case invalidType(value: Any, expectedType: Any.Type)
    }

    private typealias Encoder = (_ value: Any, _ container: inout KeyedEncodingContainer<CodingKey>) throws -> Void
    private typealias Decoder = (_ codingKey: CodingKey, _ container: KeyedDecodingContainer<CodingKey>) throws -> (Any, PartialKeyPath<Root>)?

    private var encoders: [PartialKeyPath<Root>: Encoder] = [:]
    private var decoders: [CodingKey: Decoder] = [:]

    func encode(_ value: Any, forKey keyPath: PartialKeyPath<Root>, to container: inout KeyedEncodingContainer<CodingKey>) throws {
        try encoders[keyPath]?(value, &container)
    }

    func decode(_ codingKey: CodingKey, in container: KeyedDecodingContainer<CodingKey>) throws -> (Any, PartialKeyPath<Root>)? {
        try decoders[codingKey]?(codingKey, container)
    }

    public mutating func addPair<Value: Swift.Codable>(keyPath: KeyPath<Root, Value>, codingKey: CodingKey) {
        encoders[keyPath] = { value, container in
            guard let caseValue = value as? Value else {
                throw EncodeError.invalidType(value: value, expectedType: Value.self)
            }

            try container.encode(caseValue, forKey: codingKey)
        }

        decoders[codingKey] = { codingKey, container in
            if let decodedValue = try container.decodeIfPresent(Value.self, forKey: codingKey) {
                return (decodedValue, keyPath)
            } else {
                return nil
            }
        }
    }
}
