// This file is generated. Do not edit it.
// swiftlint:disable cyclomatic_complexity
import Quick
import Nimble
import Foundation

@testable
import Partial

final class Partial_CodableTests: QuickSpec {
    override func spec() {
        describe("Partial+Codable") {
            context("with 1 property") {
                struct CodableType: Codable, PartialCodable, Hashable {
                    #if swift(>=5.1)
                    @KeyPathCodingKeyCollectionBuilder<Self, CodingKeys>
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<Self, CodingKeys> {
                        (\Self.stringA, CodingKeys.stringA)
                    }
                    #else
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<CodableType, CodingKeys> {
                        var collection = KeyPathCodingKeyCollection<CodableType, CodingKeys>()
                        collection.addPair(keyPath: \.stringA, codingKey: .stringA)
                        return collection
                    }
                    #endif

                    let stringA: String
                }

                var partial: Partial<CodableType>!

                beforeEach {
                    partial = Partial()
                }

                context("with complete value") {
                    beforeEach {
                        partial.setValue("Value A", for: \.stringA)
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

                                expect(decodedValue.stringA) == "Value A"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }

                        it("should be usable to decode Partial<Wrapped>") {
                            do {
                                let decoder = JSONDecoder()
                                let decodedValue = try decoder.decode(Partial<CodableType>.self, from: encodedData)

                                expect(try? decodedValue.value(for: \.stringA)) == "Value A"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }
                    }
                }
            }
            context("with 2 property") {
                struct CodableType: Codable, PartialCodable, Hashable {
                    #if swift(>=5.1)
                    @KeyPathCodingKeyCollectionBuilder<Self, CodingKeys>
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<Self, CodingKeys> {
                        (\Self.stringA, CodingKeys.stringA)
                        (\Self.stringB, CodingKeys.stringB)
                    }
                    #else
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<CodableType, CodingKeys> {
                        var collection = KeyPathCodingKeyCollection<CodableType, CodingKeys>()
                        collection.addPair(keyPath: \.stringA, codingKey: .stringA)
                        collection.addPair(keyPath: \.stringB, codingKey: .stringB)
                        return collection
                    }
                    #endif

                    let stringA: String
                    let stringB: String
                }

                var partial: Partial<CodableType>!

                beforeEach {
                    partial = Partial()
                }

                context("with complete value") {
                    beforeEach {
                        partial.setValue("Value A", for: \.stringA)
                        partial.setValue("Value B", for: \.stringB)
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

                                expect(decodedValue.stringA) == "Value A"
                                expect(decodedValue.stringB) == "Value B"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }

                        it("should be usable to decode Partial<Wrapped>") {
                            do {
                                let decoder = JSONDecoder()
                                let decodedValue = try decoder.decode(Partial<CodableType>.self, from: encodedData)

                                expect(try? decodedValue.value(for: \.stringA)) == "Value A"
                                expect(try? decodedValue.value(for: \.stringB)) == "Value B"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }
                    }
                }
            }
            context("with 3 property") {
                struct CodableType: Codable, PartialCodable, Hashable {
                    #if swift(>=5.1)
                    @KeyPathCodingKeyCollectionBuilder<Self, CodingKeys>
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<Self, CodingKeys> {
                        (\Self.stringA, CodingKeys.stringA)
                        (\Self.stringB, CodingKeys.stringB)
                        (\Self.stringC, CodingKeys.stringC)
                    }
                    #else
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<CodableType, CodingKeys> {
                        var collection = KeyPathCodingKeyCollection<CodableType, CodingKeys>()
                        collection.addPair(keyPath: \.stringA, codingKey: .stringA)
                        collection.addPair(keyPath: \.stringB, codingKey: .stringB)
                        collection.addPair(keyPath: \.stringC, codingKey: .stringC)
                        return collection
                    }
                    #endif

                    let stringA: String
                    let stringB: String
                    let stringC: String
                }

                var partial: Partial<CodableType>!

                beforeEach {
                    partial = Partial()
                }

                context("with complete value") {
                    beforeEach {
                        partial.setValue("Value A", for: \.stringA)
                        partial.setValue("Value B", for: \.stringB)
                        partial.setValue("Value C", for: \.stringC)
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

                                expect(decodedValue.stringA) == "Value A"
                                expect(decodedValue.stringB) == "Value B"
                                expect(decodedValue.stringC) == "Value C"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }

                        it("should be usable to decode Partial<Wrapped>") {
                            do {
                                let decoder = JSONDecoder()
                                let decodedValue = try decoder.decode(Partial<CodableType>.self, from: encodedData)

                                expect(try? decodedValue.value(for: \.stringA)) == "Value A"
                                expect(try? decodedValue.value(for: \.stringB)) == "Value B"
                                expect(try? decodedValue.value(for: \.stringC)) == "Value C"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }
                    }
                }
            }
            context("with 4 property") {
                struct CodableType: Codable, PartialCodable, Hashable {
                    #if swift(>=5.1)
                    @KeyPathCodingKeyCollectionBuilder<Self, CodingKeys>
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<Self, CodingKeys> {
                        (\Self.stringA, CodingKeys.stringA)
                        (\Self.stringB, CodingKeys.stringB)
                        (\Self.stringC, CodingKeys.stringC)
                        (\Self.stringD, CodingKeys.stringD)
                    }
                    #else
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<CodableType, CodingKeys> {
                        var collection = KeyPathCodingKeyCollection<CodableType, CodingKeys>()
                        collection.addPair(keyPath: \.stringA, codingKey: .stringA)
                        collection.addPair(keyPath: \.stringB, codingKey: .stringB)
                        collection.addPair(keyPath: \.stringC, codingKey: .stringC)
                        collection.addPair(keyPath: \.stringD, codingKey: .stringD)
                        return collection
                    }
                    #endif

                    let stringA: String
                    let stringB: String
                    let stringC: String
                    let stringD: String
                }

                var partial: Partial<CodableType>!

                beforeEach {
                    partial = Partial()
                }

                context("with complete value") {
                    beforeEach {
                        partial.setValue("Value A", for: \.stringA)
                        partial.setValue("Value B", for: \.stringB)
                        partial.setValue("Value C", for: \.stringC)
                        partial.setValue("Value D", for: \.stringD)
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

                                expect(decodedValue.stringA) == "Value A"
                                expect(decodedValue.stringB) == "Value B"
                                expect(decodedValue.stringC) == "Value C"
                                expect(decodedValue.stringD) == "Value D"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }

                        it("should be usable to decode Partial<Wrapped>") {
                            do {
                                let decoder = JSONDecoder()
                                let decodedValue = try decoder.decode(Partial<CodableType>.self, from: encodedData)

                                expect(try? decodedValue.value(for: \.stringA)) == "Value A"
                                expect(try? decodedValue.value(for: \.stringB)) == "Value B"
                                expect(try? decodedValue.value(for: \.stringC)) == "Value C"
                                expect(try? decodedValue.value(for: \.stringD)) == "Value D"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }
                    }
                }
            }
            context("with 5 property") {
                struct CodableType: Codable, PartialCodable, Hashable {
                    #if swift(>=5.1)
                    @KeyPathCodingKeyCollectionBuilder<Self, CodingKeys>
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<Self, CodingKeys> {
                        (\Self.stringA, CodingKeys.stringA)
                        (\Self.stringB, CodingKeys.stringB)
                        (\Self.stringC, CodingKeys.stringC)
                        (\Self.stringD, CodingKeys.stringD)
                        (\Self.stringE, CodingKeys.stringE)
                    }
                    #else
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<CodableType, CodingKeys> {
                        var collection = KeyPathCodingKeyCollection<CodableType, CodingKeys>()
                        collection.addPair(keyPath: \.stringA, codingKey: .stringA)
                        collection.addPair(keyPath: \.stringB, codingKey: .stringB)
                        collection.addPair(keyPath: \.stringC, codingKey: .stringC)
                        collection.addPair(keyPath: \.stringD, codingKey: .stringD)
                        collection.addPair(keyPath: \.stringE, codingKey: .stringE)
                        return collection
                    }
                    #endif

                    let stringA: String
                    let stringB: String
                    let stringC: String
                    let stringD: String
                    let stringE: String
                }

                var partial: Partial<CodableType>!

                beforeEach {
                    partial = Partial()
                }

                context("with complete value") {
                    beforeEach {
                        partial.setValue("Value A", for: \.stringA)
                        partial.setValue("Value B", for: \.stringB)
                        partial.setValue("Value C", for: \.stringC)
                        partial.setValue("Value D", for: \.stringD)
                        partial.setValue("Value E", for: \.stringE)
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

                                expect(decodedValue.stringA) == "Value A"
                                expect(decodedValue.stringB) == "Value B"
                                expect(decodedValue.stringC) == "Value C"
                                expect(decodedValue.stringD) == "Value D"
                                expect(decodedValue.stringE) == "Value E"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }

                        it("should be usable to decode Partial<Wrapped>") {
                            do {
                                let decoder = JSONDecoder()
                                let decodedValue = try decoder.decode(Partial<CodableType>.self, from: encodedData)

                                expect(try? decodedValue.value(for: \.stringA)) == "Value A"
                                expect(try? decodedValue.value(for: \.stringB)) == "Value B"
                                expect(try? decodedValue.value(for: \.stringC)) == "Value C"
                                expect(try? decodedValue.value(for: \.stringD)) == "Value D"
                                expect(try? decodedValue.value(for: \.stringE)) == "Value E"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }
                    }
                }
            }
            context("with 6 property") {
                struct CodableType: Codable, PartialCodable, Hashable {
                    #if swift(>=5.1)
                    @KeyPathCodingKeyCollectionBuilder<Self, CodingKeys>
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<Self, CodingKeys> {
                        (\Self.stringA, CodingKeys.stringA)
                        (\Self.stringB, CodingKeys.stringB)
                        (\Self.stringC, CodingKeys.stringC)
                        (\Self.stringD, CodingKeys.stringD)
                        (\Self.stringE, CodingKeys.stringE)
                        (\Self.stringF, CodingKeys.stringF)
                    }
                    #else
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<CodableType, CodingKeys> {
                        var collection = KeyPathCodingKeyCollection<CodableType, CodingKeys>()
                        collection.addPair(keyPath: \.stringA, codingKey: .stringA)
                        collection.addPair(keyPath: \.stringB, codingKey: .stringB)
                        collection.addPair(keyPath: \.stringC, codingKey: .stringC)
                        collection.addPair(keyPath: \.stringD, codingKey: .stringD)
                        collection.addPair(keyPath: \.stringE, codingKey: .stringE)
                        collection.addPair(keyPath: \.stringF, codingKey: .stringF)
                        return collection
                    }
                    #endif

                    let stringA: String
                    let stringB: String
                    let stringC: String
                    let stringD: String
                    let stringE: String
                    let stringF: String
                }

                var partial: Partial<CodableType>!

                beforeEach {
                    partial = Partial()
                }

                context("with complete value") {
                    beforeEach {
                        partial.setValue("Value A", for: \.stringA)
                        partial.setValue("Value B", for: \.stringB)
                        partial.setValue("Value C", for: \.stringC)
                        partial.setValue("Value D", for: \.stringD)
                        partial.setValue("Value E", for: \.stringE)
                        partial.setValue("Value F", for: \.stringF)
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

                                expect(decodedValue.stringA) == "Value A"
                                expect(decodedValue.stringB) == "Value B"
                                expect(decodedValue.stringC) == "Value C"
                                expect(decodedValue.stringD) == "Value D"
                                expect(decodedValue.stringE) == "Value E"
                                expect(decodedValue.stringF) == "Value F"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }

                        it("should be usable to decode Partial<Wrapped>") {
                            do {
                                let decoder = JSONDecoder()
                                let decodedValue = try decoder.decode(Partial<CodableType>.self, from: encodedData)

                                expect(try? decodedValue.value(for: \.stringA)) == "Value A"
                                expect(try? decodedValue.value(for: \.stringB)) == "Value B"
                                expect(try? decodedValue.value(for: \.stringC)) == "Value C"
                                expect(try? decodedValue.value(for: \.stringD)) == "Value D"
                                expect(try? decodedValue.value(for: \.stringE)) == "Value E"
                                expect(try? decodedValue.value(for: \.stringF)) == "Value F"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }
                    }
                }
            }
            context("with 7 property") {
                struct CodableType: Codable, PartialCodable, Hashable {
                    #if swift(>=5.1)
                    @KeyPathCodingKeyCollectionBuilder<Self, CodingKeys>
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<Self, CodingKeys> {
                        (\Self.stringA, CodingKeys.stringA)
                        (\Self.stringB, CodingKeys.stringB)
                        (\Self.stringC, CodingKeys.stringC)
                        (\Self.stringD, CodingKeys.stringD)
                        (\Self.stringE, CodingKeys.stringE)
                        (\Self.stringF, CodingKeys.stringF)
                        (\Self.stringG, CodingKeys.stringG)
                    }
                    #else
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<CodableType, CodingKeys> {
                        var collection = KeyPathCodingKeyCollection<CodableType, CodingKeys>()
                        collection.addPair(keyPath: \.stringA, codingKey: .stringA)
                        collection.addPair(keyPath: \.stringB, codingKey: .stringB)
                        collection.addPair(keyPath: \.stringC, codingKey: .stringC)
                        collection.addPair(keyPath: \.stringD, codingKey: .stringD)
                        collection.addPair(keyPath: \.stringE, codingKey: .stringE)
                        collection.addPair(keyPath: \.stringF, codingKey: .stringF)
                        collection.addPair(keyPath: \.stringG, codingKey: .stringG)
                        return collection
                    }
                    #endif

                    let stringA: String
                    let stringB: String
                    let stringC: String
                    let stringD: String
                    let stringE: String
                    let stringF: String
                    let stringG: String
                }

                var partial: Partial<CodableType>!

                beforeEach {
                    partial = Partial()
                }

                context("with complete value") {
                    beforeEach {
                        partial.setValue("Value A", for: \.stringA)
                        partial.setValue("Value B", for: \.stringB)
                        partial.setValue("Value C", for: \.stringC)
                        partial.setValue("Value D", for: \.stringD)
                        partial.setValue("Value E", for: \.stringE)
                        partial.setValue("Value F", for: \.stringF)
                        partial.setValue("Value G", for: \.stringG)
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

                                expect(decodedValue.stringA) == "Value A"
                                expect(decodedValue.stringB) == "Value B"
                                expect(decodedValue.stringC) == "Value C"
                                expect(decodedValue.stringD) == "Value D"
                                expect(decodedValue.stringE) == "Value E"
                                expect(decodedValue.stringF) == "Value F"
                                expect(decodedValue.stringG) == "Value G"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }

                        it("should be usable to decode Partial<Wrapped>") {
                            do {
                                let decoder = JSONDecoder()
                                let decodedValue = try decoder.decode(Partial<CodableType>.self, from: encodedData)

                                expect(try? decodedValue.value(for: \.stringA)) == "Value A"
                                expect(try? decodedValue.value(for: \.stringB)) == "Value B"
                                expect(try? decodedValue.value(for: \.stringC)) == "Value C"
                                expect(try? decodedValue.value(for: \.stringD)) == "Value D"
                                expect(try? decodedValue.value(for: \.stringE)) == "Value E"
                                expect(try? decodedValue.value(for: \.stringF)) == "Value F"
                                expect(try? decodedValue.value(for: \.stringG)) == "Value G"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }
                    }
                }
            }
            context("with 8 property") {
                struct CodableType: Codable, PartialCodable, Hashable {
                    #if swift(>=5.1)
                    @KeyPathCodingKeyCollectionBuilder<Self, CodingKeys>
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<Self, CodingKeys> {
                        (\Self.stringA, CodingKeys.stringA)
                        (\Self.stringB, CodingKeys.stringB)
                        (\Self.stringC, CodingKeys.stringC)
                        (\Self.stringD, CodingKeys.stringD)
                        (\Self.stringE, CodingKeys.stringE)
                        (\Self.stringF, CodingKeys.stringF)
                        (\Self.stringG, CodingKeys.stringG)
                        (\Self.stringH, CodingKeys.stringH)
                    }
                    #else
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<CodableType, CodingKeys> {
                        var collection = KeyPathCodingKeyCollection<CodableType, CodingKeys>()
                        collection.addPair(keyPath: \.stringA, codingKey: .stringA)
                        collection.addPair(keyPath: \.stringB, codingKey: .stringB)
                        collection.addPair(keyPath: \.stringC, codingKey: .stringC)
                        collection.addPair(keyPath: \.stringD, codingKey: .stringD)
                        collection.addPair(keyPath: \.stringE, codingKey: .stringE)
                        collection.addPair(keyPath: \.stringF, codingKey: .stringF)
                        collection.addPair(keyPath: \.stringG, codingKey: .stringG)
                        collection.addPair(keyPath: \.stringH, codingKey: .stringH)
                        return collection
                    }
                    #endif

                    let stringA: String
                    let stringB: String
                    let stringC: String
                    let stringD: String
                    let stringE: String
                    let stringF: String
                    let stringG: String
                    let stringH: String
                }

                var partial: Partial<CodableType>!

                beforeEach {
                    partial = Partial()
                }

                context("with complete value") {
                    beforeEach {
                        partial.setValue("Value A", for: \.stringA)
                        partial.setValue("Value B", for: \.stringB)
                        partial.setValue("Value C", for: \.stringC)
                        partial.setValue("Value D", for: \.stringD)
                        partial.setValue("Value E", for: \.stringE)
                        partial.setValue("Value F", for: \.stringF)
                        partial.setValue("Value G", for: \.stringG)
                        partial.setValue("Value H", for: \.stringH)
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

                                expect(decodedValue.stringA) == "Value A"
                                expect(decodedValue.stringB) == "Value B"
                                expect(decodedValue.stringC) == "Value C"
                                expect(decodedValue.stringD) == "Value D"
                                expect(decodedValue.stringE) == "Value E"
                                expect(decodedValue.stringF) == "Value F"
                                expect(decodedValue.stringG) == "Value G"
                                expect(decodedValue.stringH) == "Value H"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }

                        it("should be usable to decode Partial<Wrapped>") {
                            do {
                                let decoder = JSONDecoder()
                                let decodedValue = try decoder.decode(Partial<CodableType>.self, from: encodedData)

                                expect(try? decodedValue.value(for: \.stringA)) == "Value A"
                                expect(try? decodedValue.value(for: \.stringB)) == "Value B"
                                expect(try? decodedValue.value(for: \.stringC)) == "Value C"
                                expect(try? decodedValue.value(for: \.stringD)) == "Value D"
                                expect(try? decodedValue.value(for: \.stringE)) == "Value E"
                                expect(try? decodedValue.value(for: \.stringF)) == "Value F"
                                expect(try? decodedValue.value(for: \.stringG)) == "Value G"
                                expect(try? decodedValue.value(for: \.stringH)) == "Value H"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }
                    }
                }
            }
            context("with 9 property") {
                struct CodableType: Codable, PartialCodable, Hashable {
                    #if swift(>=5.1)
                    @KeyPathCodingKeyCollectionBuilder<Self, CodingKeys>
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<Self, CodingKeys> {
                        (\Self.stringA, CodingKeys.stringA)
                        (\Self.stringB, CodingKeys.stringB)
                        (\Self.stringC, CodingKeys.stringC)
                        (\Self.stringD, CodingKeys.stringD)
                        (\Self.stringE, CodingKeys.stringE)
                        (\Self.stringF, CodingKeys.stringF)
                        (\Self.stringG, CodingKeys.stringG)
                        (\Self.stringH, CodingKeys.stringH)
                        (\Self.stringI, CodingKeys.stringI)
                    }
                    #else
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<CodableType, CodingKeys> {
                        var collection = KeyPathCodingKeyCollection<CodableType, CodingKeys>()
                        collection.addPair(keyPath: \.stringA, codingKey: .stringA)
                        collection.addPair(keyPath: \.stringB, codingKey: .stringB)
                        collection.addPair(keyPath: \.stringC, codingKey: .stringC)
                        collection.addPair(keyPath: \.stringD, codingKey: .stringD)
                        collection.addPair(keyPath: \.stringE, codingKey: .stringE)
                        collection.addPair(keyPath: \.stringF, codingKey: .stringF)
                        collection.addPair(keyPath: \.stringG, codingKey: .stringG)
                        collection.addPair(keyPath: \.stringH, codingKey: .stringH)
                        collection.addPair(keyPath: \.stringI, codingKey: .stringI)
                        return collection
                    }
                    #endif

                    let stringA: String
                    let stringB: String
                    let stringC: String
                    let stringD: String
                    let stringE: String
                    let stringF: String
                    let stringG: String
                    let stringH: String
                    let stringI: String
                }

                var partial: Partial<CodableType>!

                beforeEach {
                    partial = Partial()
                }

                context("with complete value") {
                    beforeEach {
                        partial.setValue("Value A", for: \.stringA)
                        partial.setValue("Value B", for: \.stringB)
                        partial.setValue("Value C", for: \.stringC)
                        partial.setValue("Value D", for: \.stringD)
                        partial.setValue("Value E", for: \.stringE)
                        partial.setValue("Value F", for: \.stringF)
                        partial.setValue("Value G", for: \.stringG)
                        partial.setValue("Value H", for: \.stringH)
                        partial.setValue("Value I", for: \.stringI)
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

                                expect(decodedValue.stringA) == "Value A"
                                expect(decodedValue.stringB) == "Value B"
                                expect(decodedValue.stringC) == "Value C"
                                expect(decodedValue.stringD) == "Value D"
                                expect(decodedValue.stringE) == "Value E"
                                expect(decodedValue.stringF) == "Value F"
                                expect(decodedValue.stringG) == "Value G"
                                expect(decodedValue.stringH) == "Value H"
                                expect(decodedValue.stringI) == "Value I"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }

                        it("should be usable to decode Partial<Wrapped>") {
                            do {
                                let decoder = JSONDecoder()
                                let decodedValue = try decoder.decode(Partial<CodableType>.self, from: encodedData)

                                expect(try? decodedValue.value(for: \.stringA)) == "Value A"
                                expect(try? decodedValue.value(for: \.stringB)) == "Value B"
                                expect(try? decodedValue.value(for: \.stringC)) == "Value C"
                                expect(try? decodedValue.value(for: \.stringD)) == "Value D"
                                expect(try? decodedValue.value(for: \.stringE)) == "Value E"
                                expect(try? decodedValue.value(for: \.stringF)) == "Value F"
                                expect(try? decodedValue.value(for: \.stringG)) == "Value G"
                                expect(try? decodedValue.value(for: \.stringH)) == "Value H"
                                expect(try? decodedValue.value(for: \.stringI)) == "Value I"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }
                    }
                }
            }
            context("with 10 property") {
                struct CodableType: Codable, PartialCodable, Hashable {
                    #if swift(>=5.1)
                    @KeyPathCodingKeyCollectionBuilder<Self, CodingKeys>
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<Self, CodingKeys> {
                        (\Self.stringA, CodingKeys.stringA)
                        (\Self.stringB, CodingKeys.stringB)
                        (\Self.stringC, CodingKeys.stringC)
                        (\Self.stringD, CodingKeys.stringD)
                        (\Self.stringE, CodingKeys.stringE)
                        (\Self.stringF, CodingKeys.stringF)
                        (\Self.stringG, CodingKeys.stringG)
                        (\Self.stringH, CodingKeys.stringH)
                        (\Self.stringI, CodingKeys.stringI)
                        (\Self.stringJ, CodingKeys.stringJ)
                    }
                    #else
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<CodableType, CodingKeys> {
                        var collection = KeyPathCodingKeyCollection<CodableType, CodingKeys>()
                        collection.addPair(keyPath: \.stringA, codingKey: .stringA)
                        collection.addPair(keyPath: \.stringB, codingKey: .stringB)
                        collection.addPair(keyPath: \.stringC, codingKey: .stringC)
                        collection.addPair(keyPath: \.stringD, codingKey: .stringD)
                        collection.addPair(keyPath: \.stringE, codingKey: .stringE)
                        collection.addPair(keyPath: \.stringF, codingKey: .stringF)
                        collection.addPair(keyPath: \.stringG, codingKey: .stringG)
                        collection.addPair(keyPath: \.stringH, codingKey: .stringH)
                        collection.addPair(keyPath: \.stringI, codingKey: .stringI)
                        collection.addPair(keyPath: \.stringJ, codingKey: .stringJ)
                        return collection
                    }
                    #endif

                    let stringA: String
                    let stringB: String
                    let stringC: String
                    let stringD: String
                    let stringE: String
                    let stringF: String
                    let stringG: String
                    let stringH: String
                    let stringI: String
                    let stringJ: String
                }

                var partial: Partial<CodableType>!

                beforeEach {
                    partial = Partial()
                }

                context("with complete value") {
                    beforeEach {
                        partial.setValue("Value A", for: \.stringA)
                        partial.setValue("Value B", for: \.stringB)
                        partial.setValue("Value C", for: \.stringC)
                        partial.setValue("Value D", for: \.stringD)
                        partial.setValue("Value E", for: \.stringE)
                        partial.setValue("Value F", for: \.stringF)
                        partial.setValue("Value G", for: \.stringG)
                        partial.setValue("Value H", for: \.stringH)
                        partial.setValue("Value I", for: \.stringI)
                        partial.setValue("Value J", for: \.stringJ)
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

                                expect(decodedValue.stringA) == "Value A"
                                expect(decodedValue.stringB) == "Value B"
                                expect(decodedValue.stringC) == "Value C"
                                expect(decodedValue.stringD) == "Value D"
                                expect(decodedValue.stringE) == "Value E"
                                expect(decodedValue.stringF) == "Value F"
                                expect(decodedValue.stringG) == "Value G"
                                expect(decodedValue.stringH) == "Value H"
                                expect(decodedValue.stringI) == "Value I"
                                expect(decodedValue.stringJ) == "Value J"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }

                        it("should be usable to decode Partial<Wrapped>") {
                            do {
                                let decoder = JSONDecoder()
                                let decodedValue = try decoder.decode(Partial<CodableType>.self, from: encodedData)

                                expect(try? decodedValue.value(for: \.stringA)) == "Value A"
                                expect(try? decodedValue.value(for: \.stringB)) == "Value B"
                                expect(try? decodedValue.value(for: \.stringC)) == "Value C"
                                expect(try? decodedValue.value(for: \.stringD)) == "Value D"
                                expect(try? decodedValue.value(for: \.stringE)) == "Value E"
                                expect(try? decodedValue.value(for: \.stringF)) == "Value F"
                                expect(try? decodedValue.value(for: \.stringG)) == "Value G"
                                expect(try? decodedValue.value(for: \.stringH)) == "Value H"
                                expect(try? decodedValue.value(for: \.stringI)) == "Value I"
                                expect(try? decodedValue.value(for: \.stringJ)) == "Value J"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }
                    }
                }
            }
            context("with 11 property") {
                struct CodableType: Codable, PartialCodable, Hashable {
                    #if swift(>=5.1)
                    @KeyPathCodingKeyCollectionBuilder<Self, CodingKeys>
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<Self, CodingKeys> {
                        (\Self.stringA, CodingKeys.stringA)
                        (\Self.stringB, CodingKeys.stringB)
                        (\Self.stringC, CodingKeys.stringC)
                        (\Self.stringD, CodingKeys.stringD)
                        (\Self.stringE, CodingKeys.stringE)
                        (\Self.stringF, CodingKeys.stringF)
                        (\Self.stringG, CodingKeys.stringG)
                        (\Self.stringH, CodingKeys.stringH)
                        (\Self.stringI, CodingKeys.stringI)
                        (\Self.stringJ, CodingKeys.stringJ)
                        (\Self.stringK, CodingKeys.stringK)
                    }
                    #else
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<CodableType, CodingKeys> {
                        var collection = KeyPathCodingKeyCollection<CodableType, CodingKeys>()
                        collection.addPair(keyPath: \.stringA, codingKey: .stringA)
                        collection.addPair(keyPath: \.stringB, codingKey: .stringB)
                        collection.addPair(keyPath: \.stringC, codingKey: .stringC)
                        collection.addPair(keyPath: \.stringD, codingKey: .stringD)
                        collection.addPair(keyPath: \.stringE, codingKey: .stringE)
                        collection.addPair(keyPath: \.stringF, codingKey: .stringF)
                        collection.addPair(keyPath: \.stringG, codingKey: .stringG)
                        collection.addPair(keyPath: \.stringH, codingKey: .stringH)
                        collection.addPair(keyPath: \.stringI, codingKey: .stringI)
                        collection.addPair(keyPath: \.stringJ, codingKey: .stringJ)
                        collection.addPair(keyPath: \.stringK, codingKey: .stringK)
                        return collection
                    }
                    #endif

                    let stringA: String
                    let stringB: String
                    let stringC: String
                    let stringD: String
                    let stringE: String
                    let stringF: String
                    let stringG: String
                    let stringH: String
                    let stringI: String
                    let stringJ: String
                    let stringK: String
                }

                var partial: Partial<CodableType>!

                beforeEach {
                    partial = Partial()
                }

                context("with complete value") {
                    beforeEach {
                        partial.setValue("Value A", for: \.stringA)
                        partial.setValue("Value B", for: \.stringB)
                        partial.setValue("Value C", for: \.stringC)
                        partial.setValue("Value D", for: \.stringD)
                        partial.setValue("Value E", for: \.stringE)
                        partial.setValue("Value F", for: \.stringF)
                        partial.setValue("Value G", for: \.stringG)
                        partial.setValue("Value H", for: \.stringH)
                        partial.setValue("Value I", for: \.stringI)
                        partial.setValue("Value J", for: \.stringJ)
                        partial.setValue("Value K", for: \.stringK)
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

                                expect(decodedValue.stringA) == "Value A"
                                expect(decodedValue.stringB) == "Value B"
                                expect(decodedValue.stringC) == "Value C"
                                expect(decodedValue.stringD) == "Value D"
                                expect(decodedValue.stringE) == "Value E"
                                expect(decodedValue.stringF) == "Value F"
                                expect(decodedValue.stringG) == "Value G"
                                expect(decodedValue.stringH) == "Value H"
                                expect(decodedValue.stringI) == "Value I"
                                expect(decodedValue.stringJ) == "Value J"
                                expect(decodedValue.stringK) == "Value K"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }

                        it("should be usable to decode Partial<Wrapped>") {
                            do {
                                let decoder = JSONDecoder()
                                let decodedValue = try decoder.decode(Partial<CodableType>.self, from: encodedData)

                                expect(try? decodedValue.value(for: \.stringA)) == "Value A"
                                expect(try? decodedValue.value(for: \.stringB)) == "Value B"
                                expect(try? decodedValue.value(for: \.stringC)) == "Value C"
                                expect(try? decodedValue.value(for: \.stringD)) == "Value D"
                                expect(try? decodedValue.value(for: \.stringE)) == "Value E"
                                expect(try? decodedValue.value(for: \.stringF)) == "Value F"
                                expect(try? decodedValue.value(for: \.stringG)) == "Value G"
                                expect(try? decodedValue.value(for: \.stringH)) == "Value H"
                                expect(try? decodedValue.value(for: \.stringI)) == "Value I"
                                expect(try? decodedValue.value(for: \.stringJ)) == "Value J"
                                expect(try? decodedValue.value(for: \.stringK)) == "Value K"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }
                    }
                }
            }
            context("with 12 property") {
                struct CodableType: Codable, PartialCodable, Hashable {
                    #if swift(>=5.1)
                    @KeyPathCodingKeyCollectionBuilder<Self, CodingKeys>
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<Self, CodingKeys> {
                        (\Self.stringA, CodingKeys.stringA)
                        (\Self.stringB, CodingKeys.stringB)
                        (\Self.stringC, CodingKeys.stringC)
                        (\Self.stringD, CodingKeys.stringD)
                        (\Self.stringE, CodingKeys.stringE)
                        (\Self.stringF, CodingKeys.stringF)
                        (\Self.stringG, CodingKeys.stringG)
                        (\Self.stringH, CodingKeys.stringH)
                        (\Self.stringI, CodingKeys.stringI)
                        (\Self.stringJ, CodingKeys.stringJ)
                        (\Self.stringK, CodingKeys.stringK)
                        (\Self.stringL, CodingKeys.stringL)
                    }
                    #else
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<CodableType, CodingKeys> {
                        var collection = KeyPathCodingKeyCollection<CodableType, CodingKeys>()
                        collection.addPair(keyPath: \.stringA, codingKey: .stringA)
                        collection.addPair(keyPath: \.stringB, codingKey: .stringB)
                        collection.addPair(keyPath: \.stringC, codingKey: .stringC)
                        collection.addPair(keyPath: \.stringD, codingKey: .stringD)
                        collection.addPair(keyPath: \.stringE, codingKey: .stringE)
                        collection.addPair(keyPath: \.stringF, codingKey: .stringF)
                        collection.addPair(keyPath: \.stringG, codingKey: .stringG)
                        collection.addPair(keyPath: \.stringH, codingKey: .stringH)
                        collection.addPair(keyPath: \.stringI, codingKey: .stringI)
                        collection.addPair(keyPath: \.stringJ, codingKey: .stringJ)
                        collection.addPair(keyPath: \.stringK, codingKey: .stringK)
                        collection.addPair(keyPath: \.stringL, codingKey: .stringL)
                        return collection
                    }
                    #endif

                    let stringA: String
                    let stringB: String
                    let stringC: String
                    let stringD: String
                    let stringE: String
                    let stringF: String
                    let stringG: String
                    let stringH: String
                    let stringI: String
                    let stringJ: String
                    let stringK: String
                    let stringL: String
                }

                var partial: Partial<CodableType>!

                beforeEach {
                    partial = Partial()
                }

                context("with complete value") {
                    beforeEach {
                        partial.setValue("Value A", for: \.stringA)
                        partial.setValue("Value B", for: \.stringB)
                        partial.setValue("Value C", for: \.stringC)
                        partial.setValue("Value D", for: \.stringD)
                        partial.setValue("Value E", for: \.stringE)
                        partial.setValue("Value F", for: \.stringF)
                        partial.setValue("Value G", for: \.stringG)
                        partial.setValue("Value H", for: \.stringH)
                        partial.setValue("Value I", for: \.stringI)
                        partial.setValue("Value J", for: \.stringJ)
                        partial.setValue("Value K", for: \.stringK)
                        partial.setValue("Value L", for: \.stringL)
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

                                expect(decodedValue.stringA) == "Value A"
                                expect(decodedValue.stringB) == "Value B"
                                expect(decodedValue.stringC) == "Value C"
                                expect(decodedValue.stringD) == "Value D"
                                expect(decodedValue.stringE) == "Value E"
                                expect(decodedValue.stringF) == "Value F"
                                expect(decodedValue.stringG) == "Value G"
                                expect(decodedValue.stringH) == "Value H"
                                expect(decodedValue.stringI) == "Value I"
                                expect(decodedValue.stringJ) == "Value J"
                                expect(decodedValue.stringK) == "Value K"
                                expect(decodedValue.stringL) == "Value L"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }

                        it("should be usable to decode Partial<Wrapped>") {
                            do {
                                let decoder = JSONDecoder()
                                let decodedValue = try decoder.decode(Partial<CodableType>.self, from: encodedData)

                                expect(try? decodedValue.value(for: \.stringA)) == "Value A"
                                expect(try? decodedValue.value(for: \.stringB)) == "Value B"
                                expect(try? decodedValue.value(for: \.stringC)) == "Value C"
                                expect(try? decodedValue.value(for: \.stringD)) == "Value D"
                                expect(try? decodedValue.value(for: \.stringE)) == "Value E"
                                expect(try? decodedValue.value(for: \.stringF)) == "Value F"
                                expect(try? decodedValue.value(for: \.stringG)) == "Value G"
                                expect(try? decodedValue.value(for: \.stringH)) == "Value H"
                                expect(try? decodedValue.value(for: \.stringI)) == "Value I"
                                expect(try? decodedValue.value(for: \.stringJ)) == "Value J"
                                expect(try? decodedValue.value(for: \.stringK)) == "Value K"
                                expect(try? decodedValue.value(for: \.stringL)) == "Value L"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }
                    }
                }
            }
            context("with 13 property") {
                struct CodableType: Codable, PartialCodable, Hashable {
                    #if swift(>=5.1)
                    @KeyPathCodingKeyCollectionBuilder<Self, CodingKeys>
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<Self, CodingKeys> {
                        (\Self.stringA, CodingKeys.stringA)
                        (\Self.stringB, CodingKeys.stringB)
                        (\Self.stringC, CodingKeys.stringC)
                        (\Self.stringD, CodingKeys.stringD)
                        (\Self.stringE, CodingKeys.stringE)
                        (\Self.stringF, CodingKeys.stringF)
                        (\Self.stringG, CodingKeys.stringG)
                        (\Self.stringH, CodingKeys.stringH)
                        (\Self.stringI, CodingKeys.stringI)
                        (\Self.stringJ, CodingKeys.stringJ)
                        (\Self.stringK, CodingKeys.stringK)
                        (\Self.stringL, CodingKeys.stringL)
                        (\Self.stringM, CodingKeys.stringM)
                    }
                    #else
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<CodableType, CodingKeys> {
                        var collection = KeyPathCodingKeyCollection<CodableType, CodingKeys>()
                        collection.addPair(keyPath: \.stringA, codingKey: .stringA)
                        collection.addPair(keyPath: \.stringB, codingKey: .stringB)
                        collection.addPair(keyPath: \.stringC, codingKey: .stringC)
                        collection.addPair(keyPath: \.stringD, codingKey: .stringD)
                        collection.addPair(keyPath: \.stringE, codingKey: .stringE)
                        collection.addPair(keyPath: \.stringF, codingKey: .stringF)
                        collection.addPair(keyPath: \.stringG, codingKey: .stringG)
                        collection.addPair(keyPath: \.stringH, codingKey: .stringH)
                        collection.addPair(keyPath: \.stringI, codingKey: .stringI)
                        collection.addPair(keyPath: \.stringJ, codingKey: .stringJ)
                        collection.addPair(keyPath: \.stringK, codingKey: .stringK)
                        collection.addPair(keyPath: \.stringL, codingKey: .stringL)
                        collection.addPair(keyPath: \.stringM, codingKey: .stringM)
                        return collection
                    }
                    #endif

                    let stringA: String
                    let stringB: String
                    let stringC: String
                    let stringD: String
                    let stringE: String
                    let stringF: String
                    let stringG: String
                    let stringH: String
                    let stringI: String
                    let stringJ: String
                    let stringK: String
                    let stringL: String
                    let stringM: String
                }

                var partial: Partial<CodableType>!

                beforeEach {
                    partial = Partial()
                }

                context("with complete value") {
                    beforeEach {
                        partial.setValue("Value A", for: \.stringA)
                        partial.setValue("Value B", for: \.stringB)
                        partial.setValue("Value C", for: \.stringC)
                        partial.setValue("Value D", for: \.stringD)
                        partial.setValue("Value E", for: \.stringE)
                        partial.setValue("Value F", for: \.stringF)
                        partial.setValue("Value G", for: \.stringG)
                        partial.setValue("Value H", for: \.stringH)
                        partial.setValue("Value I", for: \.stringI)
                        partial.setValue("Value J", for: \.stringJ)
                        partial.setValue("Value K", for: \.stringK)
                        partial.setValue("Value L", for: \.stringL)
                        partial.setValue("Value M", for: \.stringM)
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

                                expect(decodedValue.stringA) == "Value A"
                                expect(decodedValue.stringB) == "Value B"
                                expect(decodedValue.stringC) == "Value C"
                                expect(decodedValue.stringD) == "Value D"
                                expect(decodedValue.stringE) == "Value E"
                                expect(decodedValue.stringF) == "Value F"
                                expect(decodedValue.stringG) == "Value G"
                                expect(decodedValue.stringH) == "Value H"
                                expect(decodedValue.stringI) == "Value I"
                                expect(decodedValue.stringJ) == "Value J"
                                expect(decodedValue.stringK) == "Value K"
                                expect(decodedValue.stringL) == "Value L"
                                expect(decodedValue.stringM) == "Value M"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }

                        it("should be usable to decode Partial<Wrapped>") {
                            do {
                                let decoder = JSONDecoder()
                                let decodedValue = try decoder.decode(Partial<CodableType>.self, from: encodedData)

                                expect(try? decodedValue.value(for: \.stringA)) == "Value A"
                                expect(try? decodedValue.value(for: \.stringB)) == "Value B"
                                expect(try? decodedValue.value(for: \.stringC)) == "Value C"
                                expect(try? decodedValue.value(for: \.stringD)) == "Value D"
                                expect(try? decodedValue.value(for: \.stringE)) == "Value E"
                                expect(try? decodedValue.value(for: \.stringF)) == "Value F"
                                expect(try? decodedValue.value(for: \.stringG)) == "Value G"
                                expect(try? decodedValue.value(for: \.stringH)) == "Value H"
                                expect(try? decodedValue.value(for: \.stringI)) == "Value I"
                                expect(try? decodedValue.value(for: \.stringJ)) == "Value J"
                                expect(try? decodedValue.value(for: \.stringK)) == "Value K"
                                expect(try? decodedValue.value(for: \.stringL)) == "Value L"
                                expect(try? decodedValue.value(for: \.stringM)) == "Value M"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }
                    }
                }
            }
            context("with 14 property") {
                struct CodableType: Codable, PartialCodable, Hashable {
                    #if swift(>=5.1)
                    @KeyPathCodingKeyCollectionBuilder<Self, CodingKeys>
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<Self, CodingKeys> {
                        (\Self.stringA, CodingKeys.stringA)
                        (\Self.stringB, CodingKeys.stringB)
                        (\Self.stringC, CodingKeys.stringC)
                        (\Self.stringD, CodingKeys.stringD)
                        (\Self.stringE, CodingKeys.stringE)
                        (\Self.stringF, CodingKeys.stringF)
                        (\Self.stringG, CodingKeys.stringG)
                        (\Self.stringH, CodingKeys.stringH)
                        (\Self.stringI, CodingKeys.stringI)
                        (\Self.stringJ, CodingKeys.stringJ)
                        (\Self.stringK, CodingKeys.stringK)
                        (\Self.stringL, CodingKeys.stringL)
                        (\Self.stringM, CodingKeys.stringM)
                        (\Self.stringN, CodingKeys.stringN)
                    }
                    #else
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<CodableType, CodingKeys> {
                        var collection = KeyPathCodingKeyCollection<CodableType, CodingKeys>()
                        collection.addPair(keyPath: \.stringA, codingKey: .stringA)
                        collection.addPair(keyPath: \.stringB, codingKey: .stringB)
                        collection.addPair(keyPath: \.stringC, codingKey: .stringC)
                        collection.addPair(keyPath: \.stringD, codingKey: .stringD)
                        collection.addPair(keyPath: \.stringE, codingKey: .stringE)
                        collection.addPair(keyPath: \.stringF, codingKey: .stringF)
                        collection.addPair(keyPath: \.stringG, codingKey: .stringG)
                        collection.addPair(keyPath: \.stringH, codingKey: .stringH)
                        collection.addPair(keyPath: \.stringI, codingKey: .stringI)
                        collection.addPair(keyPath: \.stringJ, codingKey: .stringJ)
                        collection.addPair(keyPath: \.stringK, codingKey: .stringK)
                        collection.addPair(keyPath: \.stringL, codingKey: .stringL)
                        collection.addPair(keyPath: \.stringM, codingKey: .stringM)
                        collection.addPair(keyPath: \.stringN, codingKey: .stringN)
                        return collection
                    }
                    #endif

                    let stringA: String
                    let stringB: String
                    let stringC: String
                    let stringD: String
                    let stringE: String
                    let stringF: String
                    let stringG: String
                    let stringH: String
                    let stringI: String
                    let stringJ: String
                    let stringK: String
                    let stringL: String
                    let stringM: String
                    let stringN: String
                }

                var partial: Partial<CodableType>!

                beforeEach {
                    partial = Partial()
                }

                context("with complete value") {
                    beforeEach {
                        partial.setValue("Value A", for: \.stringA)
                        partial.setValue("Value B", for: \.stringB)
                        partial.setValue("Value C", for: \.stringC)
                        partial.setValue("Value D", for: \.stringD)
                        partial.setValue("Value E", for: \.stringE)
                        partial.setValue("Value F", for: \.stringF)
                        partial.setValue("Value G", for: \.stringG)
                        partial.setValue("Value H", for: \.stringH)
                        partial.setValue("Value I", for: \.stringI)
                        partial.setValue("Value J", for: \.stringJ)
                        partial.setValue("Value K", for: \.stringK)
                        partial.setValue("Value L", for: \.stringL)
                        partial.setValue("Value M", for: \.stringM)
                        partial.setValue("Value N", for: \.stringN)
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

                                expect(decodedValue.stringA) == "Value A"
                                expect(decodedValue.stringB) == "Value B"
                                expect(decodedValue.stringC) == "Value C"
                                expect(decodedValue.stringD) == "Value D"
                                expect(decodedValue.stringE) == "Value E"
                                expect(decodedValue.stringF) == "Value F"
                                expect(decodedValue.stringG) == "Value G"
                                expect(decodedValue.stringH) == "Value H"
                                expect(decodedValue.stringI) == "Value I"
                                expect(decodedValue.stringJ) == "Value J"
                                expect(decodedValue.stringK) == "Value K"
                                expect(decodedValue.stringL) == "Value L"
                                expect(decodedValue.stringM) == "Value M"
                                expect(decodedValue.stringN) == "Value N"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }

                        it("should be usable to decode Partial<Wrapped>") {
                            do {
                                let decoder = JSONDecoder()
                                let decodedValue = try decoder.decode(Partial<CodableType>.self, from: encodedData)

                                expect(try? decodedValue.value(for: \.stringA)) == "Value A"
                                expect(try? decodedValue.value(for: \.stringB)) == "Value B"
                                expect(try? decodedValue.value(for: \.stringC)) == "Value C"
                                expect(try? decodedValue.value(for: \.stringD)) == "Value D"
                                expect(try? decodedValue.value(for: \.stringE)) == "Value E"
                                expect(try? decodedValue.value(for: \.stringF)) == "Value F"
                                expect(try? decodedValue.value(for: \.stringG)) == "Value G"
                                expect(try? decodedValue.value(for: \.stringH)) == "Value H"
                                expect(try? decodedValue.value(for: \.stringI)) == "Value I"
                                expect(try? decodedValue.value(for: \.stringJ)) == "Value J"
                                expect(try? decodedValue.value(for: \.stringK)) == "Value K"
                                expect(try? decodedValue.value(for: \.stringL)) == "Value L"
                                expect(try? decodedValue.value(for: \.stringM)) == "Value M"
                                expect(try? decodedValue.value(for: \.stringN)) == "Value N"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }
                    }
                }
            }
            context("with 15 property") {
                struct CodableType: Codable, PartialCodable, Hashable {
                    #if swift(>=5.1)
                    @KeyPathCodingKeyCollectionBuilder<Self, CodingKeys>
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<Self, CodingKeys> {
                        (\Self.stringA, CodingKeys.stringA)
                        (\Self.stringB, CodingKeys.stringB)
                        (\Self.stringC, CodingKeys.stringC)
                        (\Self.stringD, CodingKeys.stringD)
                        (\Self.stringE, CodingKeys.stringE)
                        (\Self.stringF, CodingKeys.stringF)
                        (\Self.stringG, CodingKeys.stringG)
                        (\Self.stringH, CodingKeys.stringH)
                        (\Self.stringI, CodingKeys.stringI)
                        (\Self.stringJ, CodingKeys.stringJ)
                        (\Self.stringK, CodingKeys.stringK)
                        (\Self.stringL, CodingKeys.stringL)
                        (\Self.stringM, CodingKeys.stringM)
                        (\Self.stringN, CodingKeys.stringN)
                        (\Self.stringO, CodingKeys.stringO)
                    }
                    #else
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<CodableType, CodingKeys> {
                        var collection = KeyPathCodingKeyCollection<CodableType, CodingKeys>()
                        collection.addPair(keyPath: \.stringA, codingKey: .stringA)
                        collection.addPair(keyPath: \.stringB, codingKey: .stringB)
                        collection.addPair(keyPath: \.stringC, codingKey: .stringC)
                        collection.addPair(keyPath: \.stringD, codingKey: .stringD)
                        collection.addPair(keyPath: \.stringE, codingKey: .stringE)
                        collection.addPair(keyPath: \.stringF, codingKey: .stringF)
                        collection.addPair(keyPath: \.stringG, codingKey: .stringG)
                        collection.addPair(keyPath: \.stringH, codingKey: .stringH)
                        collection.addPair(keyPath: \.stringI, codingKey: .stringI)
                        collection.addPair(keyPath: \.stringJ, codingKey: .stringJ)
                        collection.addPair(keyPath: \.stringK, codingKey: .stringK)
                        collection.addPair(keyPath: \.stringL, codingKey: .stringL)
                        collection.addPair(keyPath: \.stringM, codingKey: .stringM)
                        collection.addPair(keyPath: \.stringN, codingKey: .stringN)
                        collection.addPair(keyPath: \.stringO, codingKey: .stringO)
                        return collection
                    }
                    #endif

                    let stringA: String
                    let stringB: String
                    let stringC: String
                    let stringD: String
                    let stringE: String
                    let stringF: String
                    let stringG: String
                    let stringH: String
                    let stringI: String
                    let stringJ: String
                    let stringK: String
                    let stringL: String
                    let stringM: String
                    let stringN: String
                    let stringO: String
                }

                var partial: Partial<CodableType>!

                beforeEach {
                    partial = Partial()
                }

                context("with complete value") {
                    beforeEach {
                        partial.setValue("Value A", for: \.stringA)
                        partial.setValue("Value B", for: \.stringB)
                        partial.setValue("Value C", for: \.stringC)
                        partial.setValue("Value D", for: \.stringD)
                        partial.setValue("Value E", for: \.stringE)
                        partial.setValue("Value F", for: \.stringF)
                        partial.setValue("Value G", for: \.stringG)
                        partial.setValue("Value H", for: \.stringH)
                        partial.setValue("Value I", for: \.stringI)
                        partial.setValue("Value J", for: \.stringJ)
                        partial.setValue("Value K", for: \.stringK)
                        partial.setValue("Value L", for: \.stringL)
                        partial.setValue("Value M", for: \.stringM)
                        partial.setValue("Value N", for: \.stringN)
                        partial.setValue("Value O", for: \.stringO)
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

                                expect(decodedValue.stringA) == "Value A"
                                expect(decodedValue.stringB) == "Value B"
                                expect(decodedValue.stringC) == "Value C"
                                expect(decodedValue.stringD) == "Value D"
                                expect(decodedValue.stringE) == "Value E"
                                expect(decodedValue.stringF) == "Value F"
                                expect(decodedValue.stringG) == "Value G"
                                expect(decodedValue.stringH) == "Value H"
                                expect(decodedValue.stringI) == "Value I"
                                expect(decodedValue.stringJ) == "Value J"
                                expect(decodedValue.stringK) == "Value K"
                                expect(decodedValue.stringL) == "Value L"
                                expect(decodedValue.stringM) == "Value M"
                                expect(decodedValue.stringN) == "Value N"
                                expect(decodedValue.stringO) == "Value O"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }

                        it("should be usable to decode Partial<Wrapped>") {
                            do {
                                let decoder = JSONDecoder()
                                let decodedValue = try decoder.decode(Partial<CodableType>.self, from: encodedData)

                                expect(try? decodedValue.value(for: \.stringA)) == "Value A"
                                expect(try? decodedValue.value(for: \.stringB)) == "Value B"
                                expect(try? decodedValue.value(for: \.stringC)) == "Value C"
                                expect(try? decodedValue.value(for: \.stringD)) == "Value D"
                                expect(try? decodedValue.value(for: \.stringE)) == "Value E"
                                expect(try? decodedValue.value(for: \.stringF)) == "Value F"
                                expect(try? decodedValue.value(for: \.stringG)) == "Value G"
                                expect(try? decodedValue.value(for: \.stringH)) == "Value H"
                                expect(try? decodedValue.value(for: \.stringI)) == "Value I"
                                expect(try? decodedValue.value(for: \.stringJ)) == "Value J"
                                expect(try? decodedValue.value(for: \.stringK)) == "Value K"
                                expect(try? decodedValue.value(for: \.stringL)) == "Value L"
                                expect(try? decodedValue.value(for: \.stringM)) == "Value M"
                                expect(try? decodedValue.value(for: \.stringN)) == "Value N"
                                expect(try? decodedValue.value(for: \.stringO)) == "Value O"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }
                    }
                }
            }
            context("with 16 property") {
                struct CodableType: Codable, PartialCodable, Hashable {
                    #if swift(>=5.1)
                    @KeyPathCodingKeyCollectionBuilder<Self, CodingKeys>
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<Self, CodingKeys> {
                        (\Self.stringA, CodingKeys.stringA)
                        (\Self.stringB, CodingKeys.stringB)
                        (\Self.stringC, CodingKeys.stringC)
                        (\Self.stringD, CodingKeys.stringD)
                        (\Self.stringE, CodingKeys.stringE)
                        (\Self.stringF, CodingKeys.stringF)
                        (\Self.stringG, CodingKeys.stringG)
                        (\Self.stringH, CodingKeys.stringH)
                        (\Self.stringI, CodingKeys.stringI)
                        (\Self.stringJ, CodingKeys.stringJ)
                        (\Self.stringK, CodingKeys.stringK)
                        (\Self.stringL, CodingKeys.stringL)
                        (\Self.stringM, CodingKeys.stringM)
                        (\Self.stringN, CodingKeys.stringN)
                        (\Self.stringO, CodingKeys.stringO)
                        (\Self.stringP, CodingKeys.stringP)
                    }
                    #else
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<CodableType, CodingKeys> {
                        var collection = KeyPathCodingKeyCollection<CodableType, CodingKeys>()
                        collection.addPair(keyPath: \.stringA, codingKey: .stringA)
                        collection.addPair(keyPath: \.stringB, codingKey: .stringB)
                        collection.addPair(keyPath: \.stringC, codingKey: .stringC)
                        collection.addPair(keyPath: \.stringD, codingKey: .stringD)
                        collection.addPair(keyPath: \.stringE, codingKey: .stringE)
                        collection.addPair(keyPath: \.stringF, codingKey: .stringF)
                        collection.addPair(keyPath: \.stringG, codingKey: .stringG)
                        collection.addPair(keyPath: \.stringH, codingKey: .stringH)
                        collection.addPair(keyPath: \.stringI, codingKey: .stringI)
                        collection.addPair(keyPath: \.stringJ, codingKey: .stringJ)
                        collection.addPair(keyPath: \.stringK, codingKey: .stringK)
                        collection.addPair(keyPath: \.stringL, codingKey: .stringL)
                        collection.addPair(keyPath: \.stringM, codingKey: .stringM)
                        collection.addPair(keyPath: \.stringN, codingKey: .stringN)
                        collection.addPair(keyPath: \.stringO, codingKey: .stringO)
                        collection.addPair(keyPath: \.stringP, codingKey: .stringP)
                        return collection
                    }
                    #endif

                    let stringA: String
                    let stringB: String
                    let stringC: String
                    let stringD: String
                    let stringE: String
                    let stringF: String
                    let stringG: String
                    let stringH: String
                    let stringI: String
                    let stringJ: String
                    let stringK: String
                    let stringL: String
                    let stringM: String
                    let stringN: String
                    let stringO: String
                    let stringP: String
                }

                var partial: Partial<CodableType>!

                beforeEach {
                    partial = Partial()
                }

                context("with complete value") {
                    beforeEach {
                        partial.setValue("Value A", for: \.stringA)
                        partial.setValue("Value B", for: \.stringB)
                        partial.setValue("Value C", for: \.stringC)
                        partial.setValue("Value D", for: \.stringD)
                        partial.setValue("Value E", for: \.stringE)
                        partial.setValue("Value F", for: \.stringF)
                        partial.setValue("Value G", for: \.stringG)
                        partial.setValue("Value H", for: \.stringH)
                        partial.setValue("Value I", for: \.stringI)
                        partial.setValue("Value J", for: \.stringJ)
                        partial.setValue("Value K", for: \.stringK)
                        partial.setValue("Value L", for: \.stringL)
                        partial.setValue("Value M", for: \.stringM)
                        partial.setValue("Value N", for: \.stringN)
                        partial.setValue("Value O", for: \.stringO)
                        partial.setValue("Value P", for: \.stringP)
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

                                expect(decodedValue.stringA) == "Value A"
                                expect(decodedValue.stringB) == "Value B"
                                expect(decodedValue.stringC) == "Value C"
                                expect(decodedValue.stringD) == "Value D"
                                expect(decodedValue.stringE) == "Value E"
                                expect(decodedValue.stringF) == "Value F"
                                expect(decodedValue.stringG) == "Value G"
                                expect(decodedValue.stringH) == "Value H"
                                expect(decodedValue.stringI) == "Value I"
                                expect(decodedValue.stringJ) == "Value J"
                                expect(decodedValue.stringK) == "Value K"
                                expect(decodedValue.stringL) == "Value L"
                                expect(decodedValue.stringM) == "Value M"
                                expect(decodedValue.stringN) == "Value N"
                                expect(decodedValue.stringO) == "Value O"
                                expect(decodedValue.stringP) == "Value P"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }

                        it("should be usable to decode Partial<Wrapped>") {
                            do {
                                let decoder = JSONDecoder()
                                let decodedValue = try decoder.decode(Partial<CodableType>.self, from: encodedData)

                                expect(try? decodedValue.value(for: \.stringA)) == "Value A"
                                expect(try? decodedValue.value(for: \.stringB)) == "Value B"
                                expect(try? decodedValue.value(for: \.stringC)) == "Value C"
                                expect(try? decodedValue.value(for: \.stringD)) == "Value D"
                                expect(try? decodedValue.value(for: \.stringE)) == "Value E"
                                expect(try? decodedValue.value(for: \.stringF)) == "Value F"
                                expect(try? decodedValue.value(for: \.stringG)) == "Value G"
                                expect(try? decodedValue.value(for: \.stringH)) == "Value H"
                                expect(try? decodedValue.value(for: \.stringI)) == "Value I"
                                expect(try? decodedValue.value(for: \.stringJ)) == "Value J"
                                expect(try? decodedValue.value(for: \.stringK)) == "Value K"
                                expect(try? decodedValue.value(for: \.stringL)) == "Value L"
                                expect(try? decodedValue.value(for: \.stringM)) == "Value M"
                                expect(try? decodedValue.value(for: \.stringN)) == "Value N"
                                expect(try? decodedValue.value(for: \.stringO)) == "Value O"
                                expect(try? decodedValue.value(for: \.stringP)) == "Value P"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }
                    }
                }
            }
        }
    }
}
