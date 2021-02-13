#if swift(>=5.4)
@resultBuilder
public final class KeyPathCodingKeyCollectionBuilder<Root, CodingKey: Swift.CodingKey & Hashable> {
    static func buildBlock<
        ValueA: Codable
    >(
        _ pairA: (keyPath: KeyPath<Root, ValueA>, codingKey: CodingKey)
    ) -> KeyPathCodingKeyCollection<Root, CodingKey> {
        var collection = KeyPathCodingKeyCollection<Root, CodingKey>()
        collection.addPair(keyPath: pairA.keyPath, codingKey: pairA.codingKey)
        return collection
    }

    static func buildBlock<
        ValueA: Codable,
        ValueB: Codable
    >(
        _ pairA: (keyPath: KeyPath<Root, ValueA>, codingKey: CodingKey),
        _ pairB: (keyPath: KeyPath<Root, ValueB>, codingKey: CodingKey)
    ) -> KeyPathCodingKeyCollection<Root, CodingKey> {
        var collection = KeyPathCodingKeyCollection<Root, CodingKey>()
        collection.addPair(keyPath: pairA.keyPath, codingKey: pairA.codingKey)
        collection.addPair(keyPath: pairB.keyPath, codingKey: pairB.codingKey)
        return collection
    }

    static func buildBlock<
        ValueA: Codable,
        ValueB: Codable,
        ValueC: Codable
    >(
        _ pairA: (keyPath: KeyPath<Root, ValueA>, codingKey: CodingKey),
        _ pairB: (keyPath: KeyPath<Root, ValueB>, codingKey: CodingKey),
        _ pairC: (keyPath: KeyPath<Root, ValueC>, codingKey: CodingKey)
    ) -> KeyPathCodingKeyCollection<Root, CodingKey> {
        var collection = KeyPathCodingKeyCollection<Root, CodingKey>()
        collection.addPair(keyPath: pairA.keyPath, codingKey: pairA.codingKey)
        collection.addPair(keyPath: pairB.keyPath, codingKey: pairB.codingKey)
        collection.addPair(keyPath: pairC.keyPath, codingKey: pairC.codingKey)
        return collection
    }

    static func buildBlock<
        ValueA: Codable,
        ValueB: Codable,
        ValueC: Codable,
        ValueD: Codable
    >(
        _ pairA: (keyPath: KeyPath<Root, ValueA>, codingKey: CodingKey),
        _ pairB: (keyPath: KeyPath<Root, ValueB>, codingKey: CodingKey),
        _ pairC: (keyPath: KeyPath<Root, ValueC>, codingKey: CodingKey),
        _ pairD: (keyPath: KeyPath<Root, ValueD>, codingKey: CodingKey)
    ) -> KeyPathCodingKeyCollection<Root, CodingKey> {
        var collection = KeyPathCodingKeyCollection<Root, CodingKey>()
        collection.addPair(keyPath: pairA.keyPath, codingKey: pairA.codingKey)
        collection.addPair(keyPath: pairB.keyPath, codingKey: pairB.codingKey)
        collection.addPair(keyPath: pairC.keyPath, codingKey: pairC.codingKey)
        collection.addPair(keyPath: pairD.keyPath, codingKey: pairD.codingKey)
        return collection
    }

    static func buildBlock<
        ValueA: Codable,
        ValueB: Codable,
        ValueC: Codable,
        ValueD: Codable,
        ValueE: Codable
    >(
        _ pairA: (keyPath: KeyPath<Root, ValueA>, codingKey: CodingKey),
        _ pairB: (keyPath: KeyPath<Root, ValueB>, codingKey: CodingKey),
        _ pairC: (keyPath: KeyPath<Root, ValueC>, codingKey: CodingKey),
        _ pairD: (keyPath: KeyPath<Root, ValueD>, codingKey: CodingKey),
        _ pairE: (keyPath: KeyPath<Root, ValueE>, codingKey: CodingKey)
    ) -> KeyPathCodingKeyCollection<Root, CodingKey> {
        var collection = KeyPathCodingKeyCollection<Root, CodingKey>()
        collection.addPair(keyPath: pairA.keyPath, codingKey: pairA.codingKey)
        collection.addPair(keyPath: pairB.keyPath, codingKey: pairB.codingKey)
        collection.addPair(keyPath: pairC.keyPath, codingKey: pairC.codingKey)
        collection.addPair(keyPath: pairD.keyPath, codingKey: pairD.codingKey)
        collection.addPair(keyPath: pairE.keyPath, codingKey: pairE.codingKey)
        return collection
    }

    static func buildBlock<
        ValueA: Codable,
        ValueB: Codable,
        ValueC: Codable,
        ValueD: Codable,
        ValueE: Codable,
        ValueF: Codable
    >(
        _ pairA: (keyPath: KeyPath<Root, ValueA>, codingKey: CodingKey),
        _ pairB: (keyPath: KeyPath<Root, ValueB>, codingKey: CodingKey),
        _ pairC: (keyPath: KeyPath<Root, ValueC>, codingKey: CodingKey),
        _ pairD: (keyPath: KeyPath<Root, ValueD>, codingKey: CodingKey),
        _ pairE: (keyPath: KeyPath<Root, ValueE>, codingKey: CodingKey),
        _ pairF: (keyPath: KeyPath<Root, ValueF>, codingKey: CodingKey)
    ) -> KeyPathCodingKeyCollection<Root, CodingKey> {
        var collection = KeyPathCodingKeyCollection<Root, CodingKey>()
        collection.addPair(keyPath: pairA.keyPath, codingKey: pairA.codingKey)
        collection.addPair(keyPath: pairB.keyPath, codingKey: pairB.codingKey)
        collection.addPair(keyPath: pairC.keyPath, codingKey: pairC.codingKey)
        collection.addPair(keyPath: pairD.keyPath, codingKey: pairD.codingKey)
        collection.addPair(keyPath: pairE.keyPath, codingKey: pairE.codingKey)
        collection.addPair(keyPath: pairF.keyPath, codingKey: pairF.codingKey)
        return collection
    }

    static func buildBlock<
        ValueA: Codable,
        ValueB: Codable,
        ValueC: Codable,
        ValueD: Codable,
        ValueE: Codable,
        ValueF: Codable,
        ValueG: Codable
    >(
        _ pairA: (keyPath: KeyPath<Root, ValueA>, codingKey: CodingKey),
        _ pairB: (keyPath: KeyPath<Root, ValueB>, codingKey: CodingKey),
        _ pairC: (keyPath: KeyPath<Root, ValueC>, codingKey: CodingKey),
        _ pairD: (keyPath: KeyPath<Root, ValueD>, codingKey: CodingKey),
        _ pairE: (keyPath: KeyPath<Root, ValueE>, codingKey: CodingKey),
        _ pairF: (keyPath: KeyPath<Root, ValueF>, codingKey: CodingKey),
        _ pairG: (keyPath: KeyPath<Root, ValueG>, codingKey: CodingKey)
    ) -> KeyPathCodingKeyCollection<Root, CodingKey> {
        var collection = KeyPathCodingKeyCollection<Root, CodingKey>()
        collection.addPair(keyPath: pairA.keyPath, codingKey: pairA.codingKey)
        collection.addPair(keyPath: pairB.keyPath, codingKey: pairB.codingKey)
        collection.addPair(keyPath: pairC.keyPath, codingKey: pairC.codingKey)
        collection.addPair(keyPath: pairD.keyPath, codingKey: pairD.codingKey)
        collection.addPair(keyPath: pairE.keyPath, codingKey: pairE.codingKey)
        collection.addPair(keyPath: pairF.keyPath, codingKey: pairF.codingKey)
        collection.addPair(keyPath: pairG.keyPath, codingKey: pairG.codingKey)
        return collection
    }

    static func buildBlock<
        ValueA: Codable,
        ValueB: Codable,
        ValueC: Codable,
        ValueD: Codable,
        ValueE: Codable,
        ValueF: Codable,
        ValueG: Codable,
        ValueH: Codable
    >(
        _ pairA: (keyPath: KeyPath<Root, ValueA>, codingKey: CodingKey),
        _ pairB: (keyPath: KeyPath<Root, ValueB>, codingKey: CodingKey),
        _ pairC: (keyPath: KeyPath<Root, ValueC>, codingKey: CodingKey),
        _ pairD: (keyPath: KeyPath<Root, ValueD>, codingKey: CodingKey),
        _ pairE: (keyPath: KeyPath<Root, ValueE>, codingKey: CodingKey),
        _ pairF: (keyPath: KeyPath<Root, ValueF>, codingKey: CodingKey),
        _ pairG: (keyPath: KeyPath<Root, ValueG>, codingKey: CodingKey),
        _ pairH: (keyPath: KeyPath<Root, ValueH>, codingKey: CodingKey)
    ) -> KeyPathCodingKeyCollection<Root, CodingKey> {
        var collection = KeyPathCodingKeyCollection<Root, CodingKey>()
        collection.addPair(keyPath: pairA.keyPath, codingKey: pairA.codingKey)
        collection.addPair(keyPath: pairB.keyPath, codingKey: pairB.codingKey)
        collection.addPair(keyPath: pairC.keyPath, codingKey: pairC.codingKey)
        collection.addPair(keyPath: pairD.keyPath, codingKey: pairD.codingKey)
        collection.addPair(keyPath: pairE.keyPath, codingKey: pairE.codingKey)
        collection.addPair(keyPath: pairF.keyPath, codingKey: pairF.codingKey)
        collection.addPair(keyPath: pairG.keyPath, codingKey: pairG.codingKey)
        collection.addPair(keyPath: pairH.keyPath, codingKey: pairH.codingKey)
        return collection
    }

    static func buildBlock<
        ValueA: Codable,
        ValueB: Codable,
        ValueC: Codable,
        ValueD: Codable,
        ValueE: Codable,
        ValueF: Codable,
        ValueG: Codable,
        ValueH: Codable,
        ValueI: Codable
    >(
        _ pairA: (keyPath: KeyPath<Root, ValueA>, codingKey: CodingKey),
        _ pairB: (keyPath: KeyPath<Root, ValueB>, codingKey: CodingKey),
        _ pairC: (keyPath: KeyPath<Root, ValueC>, codingKey: CodingKey),
        _ pairD: (keyPath: KeyPath<Root, ValueD>, codingKey: CodingKey),
        _ pairE: (keyPath: KeyPath<Root, ValueE>, codingKey: CodingKey),
        _ pairF: (keyPath: KeyPath<Root, ValueF>, codingKey: CodingKey),
        _ pairG: (keyPath: KeyPath<Root, ValueG>, codingKey: CodingKey),
        _ pairH: (keyPath: KeyPath<Root, ValueH>, codingKey: CodingKey),
        _ pairI: (keyPath: KeyPath<Root, ValueI>, codingKey: CodingKey)
    ) -> KeyPathCodingKeyCollection<Root, CodingKey> {
        var collection = KeyPathCodingKeyCollection<Root, CodingKey>()
        collection.addPair(keyPath: pairA.keyPath, codingKey: pairA.codingKey)
        collection.addPair(keyPath: pairB.keyPath, codingKey: pairB.codingKey)
        collection.addPair(keyPath: pairC.keyPath, codingKey: pairC.codingKey)
        collection.addPair(keyPath: pairD.keyPath, codingKey: pairD.codingKey)
        collection.addPair(keyPath: pairE.keyPath, codingKey: pairE.codingKey)
        collection.addPair(keyPath: pairF.keyPath, codingKey: pairF.codingKey)
        collection.addPair(keyPath: pairG.keyPath, codingKey: pairG.codingKey)
        collection.addPair(keyPath: pairH.keyPath, codingKey: pairH.codingKey)
        collection.addPair(keyPath: pairI.keyPath, codingKey: pairI.codingKey)
        return collection
    }

    static func buildBlock<
        ValueA: Codable,
        ValueB: Codable,
        ValueC: Codable,
        ValueD: Codable,
        ValueE: Codable,
        ValueF: Codable,
        ValueG: Codable,
        ValueH: Codable,
        ValueI: Codable,
        ValueJ: Codable
    >(
        _ pairA: (keyPath: KeyPath<Root, ValueA>, codingKey: CodingKey),
        _ pairB: (keyPath: KeyPath<Root, ValueB>, codingKey: CodingKey),
        _ pairC: (keyPath: KeyPath<Root, ValueC>, codingKey: CodingKey),
        _ pairD: (keyPath: KeyPath<Root, ValueD>, codingKey: CodingKey),
        _ pairE: (keyPath: KeyPath<Root, ValueE>, codingKey: CodingKey),
        _ pairF: (keyPath: KeyPath<Root, ValueF>, codingKey: CodingKey),
        _ pairG: (keyPath: KeyPath<Root, ValueG>, codingKey: CodingKey),
        _ pairH: (keyPath: KeyPath<Root, ValueH>, codingKey: CodingKey),
        _ pairI: (keyPath: KeyPath<Root, ValueI>, codingKey: CodingKey),
        _ pairJ: (keyPath: KeyPath<Root, ValueJ>, codingKey: CodingKey)
    ) -> KeyPathCodingKeyCollection<Root, CodingKey> {
        var collection = KeyPathCodingKeyCollection<Root, CodingKey>()
        collection.addPair(keyPath: pairA.keyPath, codingKey: pairA.codingKey)
        collection.addPair(keyPath: pairB.keyPath, codingKey: pairB.codingKey)
        collection.addPair(keyPath: pairC.keyPath, codingKey: pairC.codingKey)
        collection.addPair(keyPath: pairD.keyPath, codingKey: pairD.codingKey)
        collection.addPair(keyPath: pairE.keyPath, codingKey: pairE.codingKey)
        collection.addPair(keyPath: pairF.keyPath, codingKey: pairF.codingKey)
        collection.addPair(keyPath: pairG.keyPath, codingKey: pairG.codingKey)
        collection.addPair(keyPath: pairH.keyPath, codingKey: pairH.codingKey)
        collection.addPair(keyPath: pairI.keyPath, codingKey: pairI.codingKey)
        collection.addPair(keyPath: pairJ.keyPath, codingKey: pairJ.codingKey)
        return collection
    }

    static func buildBlock<
        ValueA: Codable,
        ValueB: Codable,
        ValueC: Codable,
        ValueD: Codable,
        ValueE: Codable,
        ValueF: Codable,
        ValueG: Codable,
        ValueH: Codable,
        ValueI: Codable,
        ValueJ: Codable,
        ValueK: Codable
    >(
        _ pairA: (keyPath: KeyPath<Root, ValueA>, codingKey: CodingKey),
        _ pairB: (keyPath: KeyPath<Root, ValueB>, codingKey: CodingKey),
        _ pairC: (keyPath: KeyPath<Root, ValueC>, codingKey: CodingKey),
        _ pairD: (keyPath: KeyPath<Root, ValueD>, codingKey: CodingKey),
        _ pairE: (keyPath: KeyPath<Root, ValueE>, codingKey: CodingKey),
        _ pairF: (keyPath: KeyPath<Root, ValueF>, codingKey: CodingKey),
        _ pairG: (keyPath: KeyPath<Root, ValueG>, codingKey: CodingKey),
        _ pairH: (keyPath: KeyPath<Root, ValueH>, codingKey: CodingKey),
        _ pairI: (keyPath: KeyPath<Root, ValueI>, codingKey: CodingKey),
        _ pairJ: (keyPath: KeyPath<Root, ValueJ>, codingKey: CodingKey),
        _ pairK: (keyPath: KeyPath<Root, ValueK>, codingKey: CodingKey)
    ) -> KeyPathCodingKeyCollection<Root, CodingKey> {
        var collection = KeyPathCodingKeyCollection<Root, CodingKey>()
        collection.addPair(keyPath: pairA.keyPath, codingKey: pairA.codingKey)
        collection.addPair(keyPath: pairB.keyPath, codingKey: pairB.codingKey)
        collection.addPair(keyPath: pairC.keyPath, codingKey: pairC.codingKey)
        collection.addPair(keyPath: pairD.keyPath, codingKey: pairD.codingKey)
        collection.addPair(keyPath: pairE.keyPath, codingKey: pairE.codingKey)
        collection.addPair(keyPath: pairF.keyPath, codingKey: pairF.codingKey)
        collection.addPair(keyPath: pairG.keyPath, codingKey: pairG.codingKey)
        collection.addPair(keyPath: pairH.keyPath, codingKey: pairH.codingKey)
        collection.addPair(keyPath: pairI.keyPath, codingKey: pairI.codingKey)
        collection.addPair(keyPath: pairJ.keyPath, codingKey: pairJ.codingKey)
        collection.addPair(keyPath: pairK.keyPath, codingKey: pairK.codingKey)
        return collection
    }

    static func buildBlock<
        ValueA: Codable,
        ValueB: Codable,
        ValueC: Codable,
        ValueD: Codable,
        ValueE: Codable,
        ValueF: Codable,
        ValueG: Codable,
        ValueH: Codable,
        ValueI: Codable,
        ValueJ: Codable,
        ValueK: Codable,
        ValueL: Codable
    >(
        _ pairA: (keyPath: KeyPath<Root, ValueA>, codingKey: CodingKey),
        _ pairB: (keyPath: KeyPath<Root, ValueB>, codingKey: CodingKey),
        _ pairC: (keyPath: KeyPath<Root, ValueC>, codingKey: CodingKey),
        _ pairD: (keyPath: KeyPath<Root, ValueD>, codingKey: CodingKey),
        _ pairE: (keyPath: KeyPath<Root, ValueE>, codingKey: CodingKey),
        _ pairF: (keyPath: KeyPath<Root, ValueF>, codingKey: CodingKey),
        _ pairG: (keyPath: KeyPath<Root, ValueG>, codingKey: CodingKey),
        _ pairH: (keyPath: KeyPath<Root, ValueH>, codingKey: CodingKey),
        _ pairI: (keyPath: KeyPath<Root, ValueI>, codingKey: CodingKey),
        _ pairJ: (keyPath: KeyPath<Root, ValueJ>, codingKey: CodingKey),
        _ pairK: (keyPath: KeyPath<Root, ValueK>, codingKey: CodingKey),
        _ pairL: (keyPath: KeyPath<Root, ValueL>, codingKey: CodingKey)
    ) -> KeyPathCodingKeyCollection<Root, CodingKey> {
        var collection = KeyPathCodingKeyCollection<Root, CodingKey>()
        collection.addPair(keyPath: pairA.keyPath, codingKey: pairA.codingKey)
        collection.addPair(keyPath: pairB.keyPath, codingKey: pairB.codingKey)
        collection.addPair(keyPath: pairC.keyPath, codingKey: pairC.codingKey)
        collection.addPair(keyPath: pairD.keyPath, codingKey: pairD.codingKey)
        collection.addPair(keyPath: pairE.keyPath, codingKey: pairE.codingKey)
        collection.addPair(keyPath: pairF.keyPath, codingKey: pairF.codingKey)
        collection.addPair(keyPath: pairG.keyPath, codingKey: pairG.codingKey)
        collection.addPair(keyPath: pairH.keyPath, codingKey: pairH.codingKey)
        collection.addPair(keyPath: pairI.keyPath, codingKey: pairI.codingKey)
        collection.addPair(keyPath: pairJ.keyPath, codingKey: pairJ.codingKey)
        collection.addPair(keyPath: pairK.keyPath, codingKey: pairK.codingKey)
        collection.addPair(keyPath: pairL.keyPath, codingKey: pairL.codingKey)
        return collection
    }

    static func buildBlock<
        ValueA: Codable,
        ValueB: Codable,
        ValueC: Codable,
        ValueD: Codable,
        ValueE: Codable,
        ValueF: Codable,
        ValueG: Codable,
        ValueH: Codable,
        ValueI: Codable,
        ValueJ: Codable,
        ValueK: Codable,
        ValueL: Codable,
        ValueM: Codable
    >(
        _ pairA: (keyPath: KeyPath<Root, ValueA>, codingKey: CodingKey),
        _ pairB: (keyPath: KeyPath<Root, ValueB>, codingKey: CodingKey),
        _ pairC: (keyPath: KeyPath<Root, ValueC>, codingKey: CodingKey),
        _ pairD: (keyPath: KeyPath<Root, ValueD>, codingKey: CodingKey),
        _ pairE: (keyPath: KeyPath<Root, ValueE>, codingKey: CodingKey),
        _ pairF: (keyPath: KeyPath<Root, ValueF>, codingKey: CodingKey),
        _ pairG: (keyPath: KeyPath<Root, ValueG>, codingKey: CodingKey),
        _ pairH: (keyPath: KeyPath<Root, ValueH>, codingKey: CodingKey),
        _ pairI: (keyPath: KeyPath<Root, ValueI>, codingKey: CodingKey),
        _ pairJ: (keyPath: KeyPath<Root, ValueJ>, codingKey: CodingKey),
        _ pairK: (keyPath: KeyPath<Root, ValueK>, codingKey: CodingKey),
        _ pairL: (keyPath: KeyPath<Root, ValueL>, codingKey: CodingKey),
        _ pairM: (keyPath: KeyPath<Root, ValueM>, codingKey: CodingKey)
    ) -> KeyPathCodingKeyCollection<Root, CodingKey> {
        var collection = KeyPathCodingKeyCollection<Root, CodingKey>()
        collection.addPair(keyPath: pairA.keyPath, codingKey: pairA.codingKey)
        collection.addPair(keyPath: pairB.keyPath, codingKey: pairB.codingKey)
        collection.addPair(keyPath: pairC.keyPath, codingKey: pairC.codingKey)
        collection.addPair(keyPath: pairD.keyPath, codingKey: pairD.codingKey)
        collection.addPair(keyPath: pairE.keyPath, codingKey: pairE.codingKey)
        collection.addPair(keyPath: pairF.keyPath, codingKey: pairF.codingKey)
        collection.addPair(keyPath: pairG.keyPath, codingKey: pairG.codingKey)
        collection.addPair(keyPath: pairH.keyPath, codingKey: pairH.codingKey)
        collection.addPair(keyPath: pairI.keyPath, codingKey: pairI.codingKey)
        collection.addPair(keyPath: pairJ.keyPath, codingKey: pairJ.codingKey)
        collection.addPair(keyPath: pairK.keyPath, codingKey: pairK.codingKey)
        collection.addPair(keyPath: pairL.keyPath, codingKey: pairL.codingKey)
        collection.addPair(keyPath: pairM.keyPath, codingKey: pairM.codingKey)
        return collection
    }

    static func buildBlock<
        ValueA: Codable,
        ValueB: Codable,
        ValueC: Codable,
        ValueD: Codable,
        ValueE: Codable,
        ValueF: Codable,
        ValueG: Codable,
        ValueH: Codable,
        ValueI: Codable,
        ValueJ: Codable,
        ValueK: Codable,
        ValueL: Codable,
        ValueM: Codable,
        ValueN: Codable
    >(
        _ pairA: (keyPath: KeyPath<Root, ValueA>, codingKey: CodingKey),
        _ pairB: (keyPath: KeyPath<Root, ValueB>, codingKey: CodingKey),
        _ pairC: (keyPath: KeyPath<Root, ValueC>, codingKey: CodingKey),
        _ pairD: (keyPath: KeyPath<Root, ValueD>, codingKey: CodingKey),
        _ pairE: (keyPath: KeyPath<Root, ValueE>, codingKey: CodingKey),
        _ pairF: (keyPath: KeyPath<Root, ValueF>, codingKey: CodingKey),
        _ pairG: (keyPath: KeyPath<Root, ValueG>, codingKey: CodingKey),
        _ pairH: (keyPath: KeyPath<Root, ValueH>, codingKey: CodingKey),
        _ pairI: (keyPath: KeyPath<Root, ValueI>, codingKey: CodingKey),
        _ pairJ: (keyPath: KeyPath<Root, ValueJ>, codingKey: CodingKey),
        _ pairK: (keyPath: KeyPath<Root, ValueK>, codingKey: CodingKey),
        _ pairL: (keyPath: KeyPath<Root, ValueL>, codingKey: CodingKey),
        _ pairM: (keyPath: KeyPath<Root, ValueM>, codingKey: CodingKey),
        _ pairN: (keyPath: KeyPath<Root, ValueN>, codingKey: CodingKey)
    ) -> KeyPathCodingKeyCollection<Root, CodingKey> {
        var collection = KeyPathCodingKeyCollection<Root, CodingKey>()
        collection.addPair(keyPath: pairA.keyPath, codingKey: pairA.codingKey)
        collection.addPair(keyPath: pairB.keyPath, codingKey: pairB.codingKey)
        collection.addPair(keyPath: pairC.keyPath, codingKey: pairC.codingKey)
        collection.addPair(keyPath: pairD.keyPath, codingKey: pairD.codingKey)
        collection.addPair(keyPath: pairE.keyPath, codingKey: pairE.codingKey)
        collection.addPair(keyPath: pairF.keyPath, codingKey: pairF.codingKey)
        collection.addPair(keyPath: pairG.keyPath, codingKey: pairG.codingKey)
        collection.addPair(keyPath: pairH.keyPath, codingKey: pairH.codingKey)
        collection.addPair(keyPath: pairI.keyPath, codingKey: pairI.codingKey)
        collection.addPair(keyPath: pairJ.keyPath, codingKey: pairJ.codingKey)
        collection.addPair(keyPath: pairK.keyPath, codingKey: pairK.codingKey)
        collection.addPair(keyPath: pairL.keyPath, codingKey: pairL.codingKey)
        collection.addPair(keyPath: pairM.keyPath, codingKey: pairM.codingKey)
        collection.addPair(keyPath: pairN.keyPath, codingKey: pairN.codingKey)
        return collection
    }

    static func buildBlock<
        ValueA: Codable,
        ValueB: Codable,
        ValueC: Codable,
        ValueD: Codable,
        ValueE: Codable,
        ValueF: Codable,
        ValueG: Codable,
        ValueH: Codable,
        ValueI: Codable,
        ValueJ: Codable,
        ValueK: Codable,
        ValueL: Codable,
        ValueM: Codable,
        ValueN: Codable,
        ValueO: Codable
    >(
        _ pairA: (keyPath: KeyPath<Root, ValueA>, codingKey: CodingKey),
        _ pairB: (keyPath: KeyPath<Root, ValueB>, codingKey: CodingKey),
        _ pairC: (keyPath: KeyPath<Root, ValueC>, codingKey: CodingKey),
        _ pairD: (keyPath: KeyPath<Root, ValueD>, codingKey: CodingKey),
        _ pairE: (keyPath: KeyPath<Root, ValueE>, codingKey: CodingKey),
        _ pairF: (keyPath: KeyPath<Root, ValueF>, codingKey: CodingKey),
        _ pairG: (keyPath: KeyPath<Root, ValueG>, codingKey: CodingKey),
        _ pairH: (keyPath: KeyPath<Root, ValueH>, codingKey: CodingKey),
        _ pairI: (keyPath: KeyPath<Root, ValueI>, codingKey: CodingKey),
        _ pairJ: (keyPath: KeyPath<Root, ValueJ>, codingKey: CodingKey),
        _ pairK: (keyPath: KeyPath<Root, ValueK>, codingKey: CodingKey),
        _ pairL: (keyPath: KeyPath<Root, ValueL>, codingKey: CodingKey),
        _ pairM: (keyPath: KeyPath<Root, ValueM>, codingKey: CodingKey),
        _ pairN: (keyPath: KeyPath<Root, ValueN>, codingKey: CodingKey),
        _ pairO: (keyPath: KeyPath<Root, ValueO>, codingKey: CodingKey)
    ) -> KeyPathCodingKeyCollection<Root, CodingKey> {
        var collection = KeyPathCodingKeyCollection<Root, CodingKey>()
        collection.addPair(keyPath: pairA.keyPath, codingKey: pairA.codingKey)
        collection.addPair(keyPath: pairB.keyPath, codingKey: pairB.codingKey)
        collection.addPair(keyPath: pairC.keyPath, codingKey: pairC.codingKey)
        collection.addPair(keyPath: pairD.keyPath, codingKey: pairD.codingKey)
        collection.addPair(keyPath: pairE.keyPath, codingKey: pairE.codingKey)
        collection.addPair(keyPath: pairF.keyPath, codingKey: pairF.codingKey)
        collection.addPair(keyPath: pairG.keyPath, codingKey: pairG.codingKey)
        collection.addPair(keyPath: pairH.keyPath, codingKey: pairH.codingKey)
        collection.addPair(keyPath: pairI.keyPath, codingKey: pairI.codingKey)
        collection.addPair(keyPath: pairJ.keyPath, codingKey: pairJ.codingKey)
        collection.addPair(keyPath: pairK.keyPath, codingKey: pairK.codingKey)
        collection.addPair(keyPath: pairL.keyPath, codingKey: pairL.codingKey)
        collection.addPair(keyPath: pairM.keyPath, codingKey: pairM.codingKey)
        collection.addPair(keyPath: pairN.keyPath, codingKey: pairN.codingKey)
        collection.addPair(keyPath: pairO.keyPath, codingKey: pairO.codingKey)
        return collection
    }

    static func buildBlock<
        ValueA: Codable,
        ValueB: Codable,
        ValueC: Codable,
        ValueD: Codable,
        ValueE: Codable,
        ValueF: Codable,
        ValueG: Codable,
        ValueH: Codable,
        ValueI: Codable,
        ValueJ: Codable,
        ValueK: Codable,
        ValueL: Codable,
        ValueM: Codable,
        ValueN: Codable,
        ValueO: Codable,
        ValueP: Codable
    >(
        _ pairA: (keyPath: KeyPath<Root, ValueA>, codingKey: CodingKey),
        _ pairB: (keyPath: KeyPath<Root, ValueB>, codingKey: CodingKey),
        _ pairC: (keyPath: KeyPath<Root, ValueC>, codingKey: CodingKey),
        _ pairD: (keyPath: KeyPath<Root, ValueD>, codingKey: CodingKey),
        _ pairE: (keyPath: KeyPath<Root, ValueE>, codingKey: CodingKey),
        _ pairF: (keyPath: KeyPath<Root, ValueF>, codingKey: CodingKey),
        _ pairG: (keyPath: KeyPath<Root, ValueG>, codingKey: CodingKey),
        _ pairH: (keyPath: KeyPath<Root, ValueH>, codingKey: CodingKey),
        _ pairI: (keyPath: KeyPath<Root, ValueI>, codingKey: CodingKey),
        _ pairJ: (keyPath: KeyPath<Root, ValueJ>, codingKey: CodingKey),
        _ pairK: (keyPath: KeyPath<Root, ValueK>, codingKey: CodingKey),
        _ pairL: (keyPath: KeyPath<Root, ValueL>, codingKey: CodingKey),
        _ pairM: (keyPath: KeyPath<Root, ValueM>, codingKey: CodingKey),
        _ pairN: (keyPath: KeyPath<Root, ValueN>, codingKey: CodingKey),
        _ pairO: (keyPath: KeyPath<Root, ValueO>, codingKey: CodingKey),
        _ pairP: (keyPath: KeyPath<Root, ValueP>, codingKey: CodingKey)
    ) -> KeyPathCodingKeyCollection<Root, CodingKey> {
        var collection = KeyPathCodingKeyCollection<Root, CodingKey>()
        collection.addPair(keyPath: pairA.keyPath, codingKey: pairA.codingKey)
        collection.addPair(keyPath: pairB.keyPath, codingKey: pairB.codingKey)
        collection.addPair(keyPath: pairC.keyPath, codingKey: pairC.codingKey)
        collection.addPair(keyPath: pairD.keyPath, codingKey: pairD.codingKey)
        collection.addPair(keyPath: pairE.keyPath, codingKey: pairE.codingKey)
        collection.addPair(keyPath: pairF.keyPath, codingKey: pairF.codingKey)
        collection.addPair(keyPath: pairG.keyPath, codingKey: pairG.codingKey)
        collection.addPair(keyPath: pairH.keyPath, codingKey: pairH.codingKey)
        collection.addPair(keyPath: pairI.keyPath, codingKey: pairI.codingKey)
        collection.addPair(keyPath: pairJ.keyPath, codingKey: pairJ.codingKey)
        collection.addPair(keyPath: pairK.keyPath, codingKey: pairK.codingKey)
        collection.addPair(keyPath: pairL.keyPath, codingKey: pairL.codingKey)
        collection.addPair(keyPath: pairM.keyPath, codingKey: pairM.codingKey)
        collection.addPair(keyPath: pairN.keyPath, codingKey: pairN.codingKey)
        collection.addPair(keyPath: pairO.keyPath, codingKey: pairO.codingKey)
        collection.addPair(keyPath: pairP.keyPath, codingKey: pairP.codingKey)
        return collection
    }
}
#elseif swift(>=5.1)
@_functionBuilder
public final class KeyPathCodingKeyCollectionBuilder<Root, CodingKey: Swift.CodingKey & Hashable> {
    static func buildBlock<
        ValueA: Codable
    >(
        _ pairA: (keyPath: KeyPath<Root, ValueA>, codingKey: CodingKey)
    ) -> KeyPathCodingKeyCollection<Root, CodingKey> {
        var collection = KeyPathCodingKeyCollection<Root, CodingKey>()
        collection.addPair(keyPath: pairA.keyPath, codingKey: pairA.codingKey)
        return collection
    }

    static func buildBlock<
        ValueA: Codable,
        ValueB: Codable
    >(
        _ pairA: (keyPath: KeyPath<Root, ValueA>, codingKey: CodingKey),
        _ pairB: (keyPath: KeyPath<Root, ValueB>, codingKey: CodingKey)
    ) -> KeyPathCodingKeyCollection<Root, CodingKey> {
        var collection = KeyPathCodingKeyCollection<Root, CodingKey>()
        collection.addPair(keyPath: pairA.keyPath, codingKey: pairA.codingKey)
        collection.addPair(keyPath: pairB.keyPath, codingKey: pairB.codingKey)
        return collection
    }
}
#endif
