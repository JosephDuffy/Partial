/// A type that can provide a map of key paths and coding keys to enable
/// `Codable` conformance to `Partial`.
public protocol PartialCodable {
    /// The `CodingKey` type used to encode and decode values.
    ///
    /// This type has the extra requirement of being `Hashable`. This conformance is
    /// synthesized when using a `Hashable` type as the `RawValue` of a `CodingKey` `enum`.
    associatedtype CodingKey: Swift.CodingKey & Hashable

    /// Generate and return a collection of key paths and coding key maps.
    ///
    /// The `KeyPathCodingKeyCollectionBuilder` result builder is provided to simplify the
    /// implementation of this property, for example:
    ///
    /// ```swift
    /// struct CodableType: Codable, PartialCodable, Hashable {
    ///    @KeyPathCodingKeyCollectionBuilder<Self, CodingKeys>
    ///    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<Self, CodingKeys> {
    ///        (\Self.stringValue, CodingKeys.stringValue)
    ///        (\Self.intValue, CodingKeys.intValue)
    ///    }
    ///
    ///    let stringValue: String
    ///    let intValue: Int
    ///}
    /// ```
    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<Self, CodingKey> { get }
}
