import Foundation

public protocol PartialCodable {
    associatedtype CodingKey: Swift.CodingKey & Hashable

    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<Self, CodingKey> { get }
}

public struct KeyPathCodingKeyCollection<Root, CodingKey: Swift.CodingKey & Hashable> {
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
            guard let value = value as? Value else {
                // TODO: Throw
                return
            }

            try container.encode(value, forKey: codingKey)
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

@_functionBuilder
public final class KeyPathCodingKeyCollectionBuilder<Root, CodingKey: Swift.CodingKey & Hashable> {
    static func buildBlock<ValueA: Codable>(
        _ pairA: (keyPath: KeyPath<Root, ValueA>, codingKey: CodingKey)
    ) -> KeyPathCodingKeyCollection<Root, CodingKey> {
        var collection = KeyPathCodingKeyCollection<Root, CodingKey>()
        collection.addPair(keyPath: pairA.keyPath, codingKey: pairA.codingKey)
        return collection
    }

    static func buildBlock<ValueA: Codable, ValueB: Codable>(
        _ pairA: (keyPath: KeyPath<Root, ValueA>, codingKey: CodingKey),
        _ pairB: (keyPath: KeyPath<Root, ValueB>, codingKey: CodingKey)
    ) -> KeyPathCodingKeyCollection<Root, CodingKey> {
        var collection = KeyPathCodingKeyCollection<Root, CodingKey>()
        collection.addPair(keyPath: pairA.keyPath, codingKey: pairA.codingKey)
        collection.addPair(keyPath: pairB.keyPath, codingKey: pairB.codingKey)
        return collection
    }
}
