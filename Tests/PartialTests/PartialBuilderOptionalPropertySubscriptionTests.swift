import Quick
import Nimble

@testable
import Partial

final class PartialBuilderOptionalPropertySubscriptionTests: QuickSpec {

    override func spec() {
        describe("PartialBuilder") {
            context("wrapping a type with an optional property") {
                struct Wrapped {
                    struct Embedded: Equatable {
                        let string: String
                        init(string: String) {
                            self.string = string
                        }
                    }
                    let embedded: Embedded?
                    let otherEmbedded: Embedded?
                }

                context("initialised without a backing value") {
                    var builder: PartialBuilder<Wrapped>!

                    beforeEach {
                        builder = PartialBuilder()
                    }

                    context("subscribeForChanges(to:updateListener:)") {
                        var lastUpdate: PartialBuilder<Wrapped>.PropertyUpdate<Wrapped.Embedded?>?
                        var cancellable: Cancellable?

                        beforeEach {
                            cancellable = builder.subscribeForChanges(to: \.embedded, updateListener: { _, update in
                                lastUpdate = update
                            })
                        }

                        afterEach {
                            cancellable?.cancel()
                            lastUpdate = nil
                        }

                        it("should not call the subscriber") {
                            expect(lastUpdate).to(beNil())
                        }

                        context("when subscribed key path is set") {
                            var valueSet: Wrapped.Embedded!
                            beforeEach {
                                valueSet = Wrapped.Embedded(string: "embedded-string")
                                builder.setValue(valueSet, for: \.embedded)
                            }

                            it("should call the subscriber with the value") {
                                let expectedUpdate = PartialBuilder<Wrapped>.PropertyUpdate<Wrapped.Embedded?>.valueSet(valueSet)
                                expect(lastUpdate) == expectedUpdate
                            }
                        }

                        context("when subscribed key path is set to nil") {
                            beforeEach {
                                builder.setValue(nil, for: \.embedded)
                            }

                            it("should call the subscriber with the value") {
                                let expectedUpdate = PartialBuilder<Wrapped>.PropertyUpdate<Wrapped.Embedded?>.valueSet(nil)
                                expect(lastUpdate) == expectedUpdate
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
