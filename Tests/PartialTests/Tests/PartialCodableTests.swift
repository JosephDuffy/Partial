import Quick
import Nimble
import Foundation

@testable
import Partial

final class PartialCodableTests: QuickSpec {
    override func spec() {
        describe("PartialCodable") {
            struct CodableType: Codable, PartialCodable, Hashable {
                static func decodeValuesInContainer(_ container: KeyedDecodingContainer<CodingKeys>) throws -> [PartialKeyPath<CodableType>: Any] {
                    var values: [PartialKeyPath<CodableType>: Any] = [:]

                    values[\Self.foo] = try container.decodeIfPresent(String.self, forKey: .foo)
                    values[\Self.bar] = try container.decodeIfPresent(Int.self, forKey: .bar)

                    return values
                }

                static func encodeValue(
                    _ value: Any,
                    for keyPath: PartialKeyPath<CodableType>,
                    to container: inout KeyedEncodingContainer<CodingKeys>
                ) throws {
                    switch keyPath {
                    case \Self.foo:
                        try container.encode(value as! String, forKey: .foo)
                    case \Self.bar:
                        try container.encode(value as! Int, forKey: .bar)
                    default:
                        break
                    }
                }

                let foo: String
                let bar: Int
            }

            var partial: Partial<CodableType>!

            beforeEach {
                partial = Partial()
            }

            context("with complete value") {
                beforeEach {
                    partial.foo = "foo"
                    partial.bar = 123
                }

                context("the encoded data") {
                    var encodedData: Data!

                    beforeEach {
                        let encoder = JSONEncoder()
                        encodedData = try? encoder.encode(partial)
                    }

                    it("should not be nil") {
                        expect(encodedData).toNot(beNil())
                    }

                    it("should be usable to decode Wrapped") {
                        do {
                            let decoder = JSONDecoder()
                            let decodedValue = try decoder.decode(CodableType.self, from: encodedData)

                            expect(decodedValue.foo) == "foo"
                            expect(decodedValue.bar) == 123
                        } catch {
                            fail("Should not throw: \(error)")
                        }
                    }

                    it("should be usable to decode Partial<Wrapped>") {
                        do {
                            let decoder = JSONDecoder()
                            let decodedValue = try decoder.decode(Partial<CodableType>.self, from: encodedData)

                            expect(decodedValue.foo) == "foo"
                            expect(decodedValue.bar) == 123
                        } catch {
                            fail("Should not throw: \(error)")
                        }
                    }
                }
            }
        }
    }
}
