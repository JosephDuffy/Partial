import Quick
import Nimble

@testable
import Partial

final class PartialBuilderNonOptionalPropertySubscriptionTests: QuickSpec {

    override func spec() {
        describe("PartialBuilder") {
            context("wrapping a type with a non-optional property") {
                struct Wrapped {
                    struct Embedded: Equatable {
                        let string: String
                        init(string: String) {
                            self.string = string
                        }
                    }
                    let embedded: Embedded
                    let otherEmbedded: Embedded
                }

                context("initialised without a backing value") {
                    var builder: PartialBuilder<Wrapped>!

                    beforeEach {
                        builder = PartialBuilder()
                    }

                    context("subscribeToAllChanges(updateListener:)") {
                        var lastUpdate: (keyPath: PartialKeyPath<Wrapped>, builder: PartialBuilder<Wrapped>)?
                        var cancellable: Cancellable?

                        beforeEach {
                            cancellable = builder.subscribeToAllChanges(updateListener: { keyPath, builder in
                                lastUpdate = (keyPath, builder)
                            })
                        }

                        afterEach {
                            cancellable?.cancel()
                            cancellable = nil
                            lastUpdate = nil
                        }

                        it("should not call the subscriber") {
                            expect(lastUpdate).to(beNil())
                        }

                        context("when a key path is set") {
                            var setKeyPath: KeyPath<Wrapped, Wrapped.Embedded>!

                            beforeEach {
                                setKeyPath = \.embedded
                                builder.setValue(Wrapped.Embedded(string: "embedded-string"), for: setKeyPath)
                            }

                            it("should call the subscriber with the set key path") {
                                expect(lastUpdate?.keyPath) == setKeyPath
                            }

                            it("should call the subscriber with the builder") {
                                expect(lastUpdate?.builder) === lastUpdate?.builder
                            }
                        }

                        context("after the cancellable has been deallocated") {
                            beforeEach {
                                cancellable = nil
                            }

                            context("when a key path is set") {
                                beforeEach {
                                    builder.setValue(Wrapped.Embedded(string: "embedded-string"), for: \.embedded)
                                }

                                it("should not call update listener") {
                                    expect(lastUpdate).to(beNil())
                                }
                            }
                        }
                    }

                    context("subscribeForChanges(to:updateListener:)") {
                        var lastUpdate: (keyPath: KeyPath<Wrapped, Wrapped.Embedded>, update: PartialBuilder<Wrapped>.PropertyUpdate<Wrapped.Embedded>)?
                        var cancellable: Cancellable?

                        beforeEach {
                            cancellable = builder.subscribeForChanges(to: \.embedded, updateListener: { keyPath, update in
                                lastUpdate = (keyPath, update)
                            })
                        }

                        afterEach {
                            cancellable?.cancel()
                            cancellable = nil
                            lastUpdate = nil
                        }

                        it("should not call the subscriber") {
                            expect(lastUpdate).to(beNil())
                        }

                        context("when subscribed key path is set") {
                            var valueSet: Wrapped.Embedded!
                            var keyPathSet: KeyPath<Wrapped, Wrapped.Embedded>!

                            beforeEach {
                                keyPathSet = \.embedded
                                valueSet = Wrapped.Embedded(string: "embedded-string")
                                builder.setValue(valueSet, for: keyPathSet)
                            }

                            it("should call the subscriber with a `valueSet` update containing the new value") {
                                let expectedUpdate = PartialBuilder<Wrapped>.PropertyUpdate<Wrapped.Embedded>.valueSet(valueSet)
                                expect(lastUpdate?.update) == expectedUpdate
                            }

                            it("should call the subscriber with the key path set") {
                                expect(lastUpdate?.keyPath) == keyPathSet
                            }
                        }

                        context("when a key path other than the subscribed key path is set") {
                            var valueSet: Wrapped.Embedded!
                            beforeEach {
                                valueSet = Wrapped.Embedded(string: "embedded-string")
                                builder.setValue(valueSet, for: \.otherEmbedded)
                            }

                            it("should not call the subscriber") {
                                expect(lastUpdate).to(beNil())
                            }
                        }

                        context("after being cancelled") {
                            beforeEach {
                                cancellable?.cancel()
                            }

                            context("when subscribed key path is set") {
                                var valueSet: Wrapped.Embedded!
                                beforeEach {
                                    valueSet = Wrapped.Embedded(string: "embedded-string")
                                    builder.setValue(valueSet, for: \.embedded)
                                }

                                it("should not call update listener") {
                                    expect(lastUpdate).to(beNil())
                                }
                            }
                        }

                        context("after the cancellable has been deallocated") {
                            beforeEach {
                                cancellable = nil
                            }

                            context("when subscribed key path is set") {
                                var valueSet: Wrapped.Embedded!
                                beforeEach {
                                    valueSet = Wrapped.Embedded(string: "embedded-string")
                                    builder.setValue(valueSet, for: \.embedded)
                                }

                                it("should not call update listener") {
                                    expect(lastUpdate).to(beNil())
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
