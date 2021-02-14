// This file is generated. Do not edit it.
#if swift(>=5.1)
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
                    @KeyPathCodingKeyCollectionBuilder<Self, CodingKeys>
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<Self, CodingKeys> {
                        (\Self.stringA, CodingKeys.stringA)
                    }

                    let stringA: String
                }

                var partial: Partial<CodableType>!

                beforeEach {
                    partial = Partial()
                }

                context("with complete value") {
                    beforeEach {
                        partial.stringA = "Value A"
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

                                expect(decodedValue.stringA) == "Value A"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }
                    }
                }
            }
            context("with 2 property") {
                struct CodableType: Codable, PartialCodable, Hashable {
                    @KeyPathCodingKeyCollectionBuilder<Self, CodingKeys>
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<Self, CodingKeys> {
                        (\Self.stringA, CodingKeys.stringA)
                        (\Self.stringB, CodingKeys.stringB)
                    }

                    let stringA: String
                    let stringB: String
                }

                var partial: Partial<CodableType>!

                beforeEach {
                    partial = Partial()
                }

                context("with complete value") {
                    beforeEach {
                        partial.stringA = "Value A"
                        partial.stringB = "Value B"
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

                                expect(decodedValue.stringA) == "Value A"
                                expect(decodedValue.stringB) == "Value B"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }
                    }
                }
            }
            context("with 3 property") {
                struct CodableType: Codable, PartialCodable, Hashable {
                    @KeyPathCodingKeyCollectionBuilder<Self, CodingKeys>
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<Self, CodingKeys> {
                        (\Self.stringA, CodingKeys.stringA)
                        (\Self.stringB, CodingKeys.stringB)
                        (\Self.stringC, CodingKeys.stringC)
                    }

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
                        partial.stringA = "Value A"
                        partial.stringB = "Value B"
                        partial.stringC = "Value C"
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

                                expect(decodedValue.stringA) == "Value A"
                                expect(decodedValue.stringB) == "Value B"
                                expect(decodedValue.stringC) == "Value C"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }
                    }
                }
            }
            context("with 4 property") {
                struct CodableType: Codable, PartialCodable, Hashable {
                    @KeyPathCodingKeyCollectionBuilder<Self, CodingKeys>
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<Self, CodingKeys> {
                        (\Self.stringA, CodingKeys.stringA)
                        (\Self.stringB, CodingKeys.stringB)
                        (\Self.stringC, CodingKeys.stringC)
                        (\Self.stringD, CodingKeys.stringD)
                    }

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
                        partial.stringA = "Value A"
                        partial.stringB = "Value B"
                        partial.stringC = "Value C"
                        partial.stringD = "Value D"
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

                                expect(decodedValue.stringA) == "Value A"
                                expect(decodedValue.stringB) == "Value B"
                                expect(decodedValue.stringC) == "Value C"
                                expect(decodedValue.stringD) == "Value D"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }
                    }
                }
            }
            context("with 5 property") {
                struct CodableType: Codable, PartialCodable, Hashable {
                    @KeyPathCodingKeyCollectionBuilder<Self, CodingKeys>
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<Self, CodingKeys> {
                        (\Self.stringA, CodingKeys.stringA)
                        (\Self.stringB, CodingKeys.stringB)
                        (\Self.stringC, CodingKeys.stringC)
                        (\Self.stringD, CodingKeys.stringD)
                        (\Self.stringE, CodingKeys.stringE)
                    }

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
                        partial.stringA = "Value A"
                        partial.stringB = "Value B"
                        partial.stringC = "Value C"
                        partial.stringD = "Value D"
                        partial.stringE = "Value E"
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

                                expect(decodedValue.stringA) == "Value A"
                                expect(decodedValue.stringB) == "Value B"
                                expect(decodedValue.stringC) == "Value C"
                                expect(decodedValue.stringD) == "Value D"
                                expect(decodedValue.stringE) == "Value E"
                            } catch {
                                fail("Should not throw: \(error)")
                            }
                        }
                    }
                }
            }
            context("with 6 property") {
                struct CodableType: Codable, PartialCodable, Hashable {
                    @KeyPathCodingKeyCollectionBuilder<Self, CodingKeys>
                    static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<Self, CodingKeys> {
                        (\Self.stringA, CodingKeys.stringA)
                        (\Self.stringB, CodingKeys.stringB)
                        (\Self.stringC, CodingKeys.stringC)
                        (\Self.stringD, CodingKeys.stringD)
                        (\Self.stringE, CodingKeys.stringE)
                        (\Self.stringF, CodingKeys.stringF)
                    }

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
                        partial.stringA = "Value A"
                        partial.stringB = "Value B"
                        partial.stringC = "Value C"
                        partial.stringD = "Value D"
                        partial.stringE = "Value E"
                        partial.stringF = "Value F"
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
                    }
                }
            }
            context("with 7 property") {
                struct CodableType: Codable, PartialCodable, Hashable {
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
                        partial.stringA = "Value A"
                        partial.stringB = "Value B"
                        partial.stringC = "Value C"
                        partial.stringD = "Value D"
                        partial.stringE = "Value E"
                        partial.stringF = "Value F"
                        partial.stringG = "Value G"
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
                    }
                }
            }
            context("with 8 property") {
                struct CodableType: Codable, PartialCodable, Hashable {
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
                        partial.stringA = "Value A"
                        partial.stringB = "Value B"
                        partial.stringC = "Value C"
                        partial.stringD = "Value D"
                        partial.stringE = "Value E"
                        partial.stringF = "Value F"
                        partial.stringG = "Value G"
                        partial.stringH = "Value H"
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
                    }
                }
            }
            context("with 9 property") {
                struct CodableType: Codable, PartialCodable, Hashable {
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
                        partial.stringA = "Value A"
                        partial.stringB = "Value B"
                        partial.stringC = "Value C"
                        partial.stringD = "Value D"
                        partial.stringE = "Value E"
                        partial.stringF = "Value F"
                        partial.stringG = "Value G"
                        partial.stringH = "Value H"
                        partial.stringI = "Value I"
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
                    }
                }
            }
            context("with 10 property") {
                struct CodableType: Codable, PartialCodable, Hashable {
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
                        partial.stringA = "Value A"
                        partial.stringB = "Value B"
                        partial.stringC = "Value C"
                        partial.stringD = "Value D"
                        partial.stringE = "Value E"
                        partial.stringF = "Value F"
                        partial.stringG = "Value G"
                        partial.stringH = "Value H"
                        partial.stringI = "Value I"
                        partial.stringJ = "Value J"
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
                    }
                }
            }
            context("with 11 property") {
                struct CodableType: Codable, PartialCodable, Hashable {
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
                        partial.stringA = "Value A"
                        partial.stringB = "Value B"
                        partial.stringC = "Value C"
                        partial.stringD = "Value D"
                        partial.stringE = "Value E"
                        partial.stringF = "Value F"
                        partial.stringG = "Value G"
                        partial.stringH = "Value H"
                        partial.stringI = "Value I"
                        partial.stringJ = "Value J"
                        partial.stringK = "Value K"
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
                    }
                }
            }
            context("with 12 property") {
                struct CodableType: Codable, PartialCodable, Hashable {
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
                        partial.stringA = "Value A"
                        partial.stringB = "Value B"
                        partial.stringC = "Value C"
                        partial.stringD = "Value D"
                        partial.stringE = "Value E"
                        partial.stringF = "Value F"
                        partial.stringG = "Value G"
                        partial.stringH = "Value H"
                        partial.stringI = "Value I"
                        partial.stringJ = "Value J"
                        partial.stringK = "Value K"
                        partial.stringL = "Value L"
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
                    }
                }
            }
            context("with 13 property") {
                struct CodableType: Codable, PartialCodable, Hashable {
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
                        partial.stringA = "Value A"
                        partial.stringB = "Value B"
                        partial.stringC = "Value C"
                        partial.stringD = "Value D"
                        partial.stringE = "Value E"
                        partial.stringF = "Value F"
                        partial.stringG = "Value G"
                        partial.stringH = "Value H"
                        partial.stringI = "Value I"
                        partial.stringJ = "Value J"
                        partial.stringK = "Value K"
                        partial.stringL = "Value L"
                        partial.stringM = "Value M"
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
                    }
                }
            }
            context("with 14 property") {
                struct CodableType: Codable, PartialCodable, Hashable {
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
                        partial.stringA = "Value A"
                        partial.stringB = "Value B"
                        partial.stringC = "Value C"
                        partial.stringD = "Value D"
                        partial.stringE = "Value E"
                        partial.stringF = "Value F"
                        partial.stringG = "Value G"
                        partial.stringH = "Value H"
                        partial.stringI = "Value I"
                        partial.stringJ = "Value J"
                        partial.stringK = "Value K"
                        partial.stringL = "Value L"
                        partial.stringM = "Value M"
                        partial.stringN = "Value N"
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
                    }
                }
            }
            context("with 15 property") {
                struct CodableType: Codable, PartialCodable, Hashable {
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
                        partial.stringA = "Value A"
                        partial.stringB = "Value B"
                        partial.stringC = "Value C"
                        partial.stringD = "Value D"
                        partial.stringE = "Value E"
                        partial.stringF = "Value F"
                        partial.stringG = "Value G"
                        partial.stringH = "Value H"
                        partial.stringI = "Value I"
                        partial.stringJ = "Value J"
                        partial.stringK = "Value K"
                        partial.stringL = "Value L"
                        partial.stringM = "Value M"
                        partial.stringN = "Value N"
                        partial.stringO = "Value O"
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
                    }
                }
            }
            context("with 16 property") {
                struct CodableType: Codable, PartialCodable, Hashable {
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
                        partial.stringA = "Value A"
                        partial.stringB = "Value B"
                        partial.stringC = "Value C"
                        partial.stringD = "Value D"
                        partial.stringE = "Value E"
                        partial.stringF = "Value F"
                        partial.stringG = "Value G"
                        partial.stringH = "Value H"
                        partial.stringI = "Value I"
                        partial.stringJ = "Value J"
                        partial.stringK = "Value K"
                        partial.stringL = "Value L"
                        partial.stringM = "Value M"
                        partial.stringN = "Value N"
                        partial.stringO = "Value O"
                        partial.stringP = "Value P"
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
                    }
                }
            }
        }
    }
}
#endif
