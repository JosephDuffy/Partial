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
