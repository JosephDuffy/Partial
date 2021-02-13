import Foundation

public protocol PartialCodable {
    associatedtype CodingKey: Swift.CodingKey & Equatable

    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<Self, CodingKey> { get }
}

public struct KeyPathCodingKeyCollection<Root, CodingKey: Swift.CodingKey & Equatable> {
    private typealias ValueEncoder = (_ value: Any, _ keyPath: PartialKeyPath<Root> ,_ container: inout KeyedEncodingContainer<CodingKey>) throws -> Void
    private typealias ValueDecoder = (_ codingKey: CodingKey,_ container: KeyedDecodingContainer<CodingKey>) throws -> (Any, PartialKeyPath<Root>)?

    private var valueEncoder: ValueEncoder = { _, _, _ in }
    private var valueDecoder: ValueDecoder = { _, _ in nil }

    func encode(_ value: Any, forKey keyPath: PartialKeyPath<Root>, to container: inout KeyedEncodingContainer<CodingKey>) throws {
        try valueEncoder(value, keyPath, &container)
    }

    func decode(_ codingKey: CodingKey, in container: KeyedDecodingContainer<CodingKey>) throws -> (Any, PartialKeyPath<Root>)? {
        try valueDecoder(codingKey, container)
    }

    public mutating func addPair<Value: Swift.Codable>(keyPath: KeyPath<Root, Value>, codingKey: CodingKey) {
        valueEncoder = { [valueEncoder] value, keyPathToEncode, container in
            if keyPathToEncode == keyPath {
                guard let value = value as? Value else {
                    // TODO: Throw
                    return
                }

                try container.encode(value, forKey: codingKey)
            } else {
                try valueEncoder(value, keyPathToEncode, &container)
            }
        }

        valueDecoder = { [valueDecoder] codingKeyToDecode, container in
            if codingKeyToDecode == codingKey {
                if let decodedValue = try container.decodeIfPresent(Value.self, forKey: codingKey) {
                    return (decodedValue, keyPath)
                } else {
                    return nil
                }
            } else {
                return try valueDecoder(codingKeyToDecode, container)
            }
        }
    }
}

@_functionBuilder
public final class KeyPathCodingKeyCollectionBuilder<Root, CodingKey: Swift.CodingKey & Equatable> {
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
