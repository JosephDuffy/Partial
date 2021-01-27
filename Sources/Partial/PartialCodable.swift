import Foundation

public protocol PartialCodable {
    associatedtype CodingKey: Swift.CodingKey

    static func encodeValue(_ value: Any, for keyPath: PartialKeyPath<Self>, to container: inout KeyedEncodingContainer<CodingKey>) throws

    static func decodeValuesInContainer(_ container: KeyedDecodingContainer<CodingKey>) throws -> [PartialKeyPath<Self>: Any]
}
