import Foundation

public protocol PartialCodable: Codable {
    associatedtype CodingKey: Swift.CodingKey

    static func encodeValue(_ value: Any, for keyPath: PartialKeyPath<Self>, to container: inout KeyedEncodingContainer<CodingKey>) throws
}
