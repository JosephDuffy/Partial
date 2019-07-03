import Quick
import Nimble

@testable
import Partial

final class PartialBuilderSubscriptionTests: QuickSpec {

    override func spec() {
        describe("PartialBuilder") {
            struct Wrapped {
                let string: String
                let optionalString: String?
                let partialConvertible: PartialConvertibleType
                let optionalPartialConvertible: PartialConvertibleType?
            }
            struct PartialConvertibleType: Equatable, ExpressibleByStringLiteral, PartialConvertible {
                let string: String

                init(string: String) {
                    self.string = string
                }

                init(stringLiteral string: String) {
                    self.string = string
                }

                init(partial: Partial<PartialConvertibleType>) throws {
                    string = try partial.value(for: \.string)
                }
            }

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

                context("when a non-optional key path is set") {
                    var setKeyPath: KeyPath<Wrapped, String>!

                    beforeEach {
                        setKeyPath = \.string
                        builder.setValue("new value", for: setKeyPath)
                    }

                    it("should call the subscriber with the set key path") {
                        expect(lastUpdate?.keyPath) == setKeyPath
                    }

                    it("should call the subscriber with the builder") {
                        expect(lastUpdate?.builder) === lastUpdate?.builder
                    }
                }

                context("when an optional key path is set to nil") {
                    var setKeyPath: KeyPath<Wrapped, String?>!

                    beforeEach {
                        setKeyPath = \.optionalString
                        builder.setValue(nil, for: setKeyPath)
                    }

                    it("should call the subscriber with the set key path") {
                        expect(lastUpdate?.keyPath) == setKeyPath
                    }

                    it("should call the subscriber with the builder") {
                        expect(lastUpdate?.builder) === lastUpdate?.builder
                    }
                }

                context("when an optional key path is set to a non-optional value") {
                    var setKeyPath: KeyPath<Wrapped, String?>!

                    beforeEach {
                        setKeyPath = \.optionalString
                        builder.setValue("new value", for: setKeyPath)
                    }

                    it("should call the subscriber with the set key path") {
                        expect(lastUpdate?.keyPath) == setKeyPath
                    }

                    it("should call the subscriber with the builder") {
                        expect(lastUpdate?.builder) === lastUpdate?.builder
                    }
                }

                context("when a PartialConvertible value is set to an incomplete partial") {
                    beforeEach {
                        try? builder.setValue(Partial<PartialConvertibleType>(), for: \.partialConvertible)
                    }

                    it("should not call update listener") {
                        expect(lastUpdate).to(beNil())
                    }
                }

                context("when a PartialConvertible value is set to a complete partial") {
                    var setKeyPath: KeyPath<Wrapped, PartialConvertibleType>!

                    beforeEach {
                        setKeyPath = \.partialConvertible
                        var partial = Partial<PartialConvertibleType>()
                        partial[\.string] = "new value"
                        try? builder.setValue(partial, for: setKeyPath)
                    }

                    it("should call the subscriber with the set key path") {
                        expect(lastUpdate?.keyPath) == setKeyPath
                    }

                    it("should call the subscriber with the builder") {
                        expect(lastUpdate?.builder) === lastUpdate?.builder
                    }
                }

                context("when an optional PartialConvertible value is set to an incomplete partial") {
                    beforeEach {
                        try? builder.setValue(Partial<PartialConvertibleType>(), for: \.optionalPartialConvertible)
                    }

                    it("should not call update listener") {
                        expect(lastUpdate).to(beNil())
                    }
                }

                context("when an optional PartialConvertible value is set to a complete partial") {
                    var setKeyPath: KeyPath<Wrapped, PartialConvertibleType?>!

                    beforeEach {
                        setKeyPath = \.optionalPartialConvertible
                        var partial = Partial<PartialConvertibleType>()
                        partial[\.string] = "new value"
                        try? builder.setValue(partial, for: setKeyPath)
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
                            builder.setValue("new value", for: \.string)
                        }

                        it("should not call update listener") {
                            expect(lastUpdate).to(beNil())
                        }
                    }
                }
            }

            context("subscribeForChanges(to:updateListener:) for a non-optional property") {
                let subscribedKeyPath = \Wrapped.string
                var lastUpdate: (keyPath: KeyPath<Wrapped, String>, update: PartialBuilder<Wrapped>.PropertyUpdate<String>)?
                var cancellable: Cancellable?

                beforeEach {
                    cancellable = builder.subscribeForChanges(to: subscribedKeyPath, updateListener: { keyPath, update in
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
                    var valueSet: String!

                    beforeEach {
                        valueSet = "set value"
                        builder.setValue(valueSet, for: subscribedKeyPath)
                    }

                    it("should call the subscriber with a `valueSet` update containing the new value") {
                        expect(lastUpdate?.update) == .valueSet(valueSet)
                    }

                    it("should call the subscriber with the subscribed key path") {
                        expect(lastUpdate?.keyPath) == subscribedKeyPath
                    }
                }

                context("when subscribed key path is removed") {
                    beforeEach {
                        builder.removeValue(for: subscribedKeyPath)
                    }

                    it("should call the subscriber with a `valueRemoved` update") {
                        expect(lastUpdate?.update) == .valueRemoved
                    }

                    it("should call the subscriber with the subscribed key path") {
                        expect(lastUpdate?.keyPath) == subscribedKeyPath
                    }
                }

                context("when a key path other than the subscribed key path is set") {
                    beforeEach {
                        builder.setValue("set value", for: \.optionalString)
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
                        beforeEach {
                            builder.setValue("set value", for: subscribedKeyPath)
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
                        beforeEach {
                            builder.setValue("set value", for: subscribedKeyPath)
                        }

                        it("should not call update listener") {
                            expect(lastUpdate).to(beNil())
                        }
                    }
                }
            }

            context("subscribeForChanges(to:updateListener:) for an optional property") {
                let subscribedKeyPath = \Wrapped.optionalString
                var lastUpdate: (keyPath: KeyPath<Wrapped, String?>, update: PartialBuilder<Wrapped>.PropertyUpdate<String?>)?
                var cancellable: Cancellable?

                beforeEach {
                    cancellable = builder.subscribeForChanges(to: subscribedKeyPath, updateListener: { keyPath, update in
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

                context("when subscribed key path is set to a non-optional value") {
                    var valueSet: String!

                    beforeEach {
                        valueSet = "set value"
                        builder.setValue(valueSet, for: subscribedKeyPath)
                    }

                    it("should call the subscriber with a `valueSet` update containing the new value") {
                        expect(lastUpdate?.update) == .valueSet(valueSet)
                    }

                    it("should call the subscriber with the subscribed key path") {
                        expect(lastUpdate?.keyPath) == subscribedKeyPath
                    }
                }

                context("when subscribed key path is set to nil") {
                    beforeEach {
                        builder.setValue(nil, for: subscribedKeyPath)
                    }

                    it("should call the subscriber with a `valueSet` update containing nil") {
                        expect(lastUpdate?.update) == .valueSet(nil)
                    }

                    it("should call the subscriber with the subscribed key path") {
                        expect(lastUpdate?.keyPath) == subscribedKeyPath
                    }
                }

                context("when subscribed key path is removed") {
                    beforeEach {
                        builder.removeValue(for: subscribedKeyPath)
                    }

                    it("should call the subscriber with a `valueRemoved` update") {
                        expect(lastUpdate?.update) == .valueRemoved
                    }

                    it("should call the subscriber with the subscribed key path") {
                        expect(lastUpdate?.keyPath) == subscribedKeyPath
                    }
                }

                context("when a key path other than the subscribed key path is set") {
                    beforeEach {
                        builder.setValue("set value", for: \.string)
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
                        beforeEach {
                            builder.setValue("set value", for: subscribedKeyPath)
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
                        beforeEach {
                            builder.setValue("set value", for: subscribedKeyPath)
                        }

                        it("should not call update listener") {
                            expect(lastUpdate).to(beNil())
                        }
                    }
                }
            }

            context("subscribeForChanges(to:updateListener:) for a non-optional PartialConvertible property") {
                let subscribedKeyPath = \Wrapped.partialConvertible
                var lastUpdate: (keyPath: KeyPath<Wrapped, PartialConvertibleType>, update: PartialBuilder<Wrapped>.PropertyUpdate<PartialConvertibleType>)?
                var cancellable: Cancellable?

                beforeEach {
                    cancellable = builder.subscribeForChanges(to: subscribedKeyPath, updateListener: { keyPath, update in
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
                    var valueSet: PartialConvertibleType!

                    beforeEach {
                        valueSet = "set value"
                        builder.setValue(valueSet, for: subscribedKeyPath)
                    }

                    it("should call the subscriber with a `valueSet` update containing the new value") {
                        expect(lastUpdate?.update) == .valueSet(valueSet)
                    }

                    it("should call the subscriber with the subscribed key path") {
                        expect(lastUpdate?.keyPath) == subscribedKeyPath
                    }
                }

                context("when subscribed key path is removed") {
                    beforeEach {
                        builder.removeValue(for: subscribedKeyPath)
                    }

                    it("should call the subscriber with a `valueRemoved` update") {
                        expect(lastUpdate?.update) == .valueRemoved
                    }

                    it("should call the subscriber with the subscribed key path") {
                        expect(lastUpdate?.keyPath) == subscribedKeyPath
                    }
                }

                context("when subscribed key path is set to an incomplete partial") {
                    beforeEach {
                        try? builder.setValue(Partial<PartialConvertibleType>(), for: subscribedKeyPath)
                    }

                    it("should not call update listener") {
                        expect(lastUpdate).to(beNil())
                    }
                }

                context("when subscribed key path is set to a complete partial") {
                    var unwrappedValueSet: PartialConvertibleType!

                    beforeEach {
                        var partial = Partial<PartialConvertibleType>()
                        partial[\.string] = "new value"
                        unwrappedValueSet = "new value"
                        try? builder.setValue(partial, for: subscribedKeyPath)
                    }

                    it("should call the subscriber with a `valueSet` update containing the unwrapped value") {
                        expect(lastUpdate?.update) == .valueSet(unwrappedValueSet)
                    }

                    it("should call the subscriber with the subscribed key path") {
                        expect(lastUpdate?.keyPath) == subscribedKeyPath
                    }
                }

                context("when a key path other than the subscribed key path is set") {
                    beforeEach {
                        builder.setValue("set value", for: \.string)
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
                        beforeEach {
                            builder.setValue("set value", for: subscribedKeyPath)
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
                        beforeEach {
                            builder.setValue("set value", for: subscribedKeyPath)
                        }

                        it("should not call update listener") {
                            expect(lastUpdate).to(beNil())
                        }
                    }
                }
            }

            context("subscribeForChanges(to:updateListener:) for an optional PartialConvertible property") {
                let subscribedKeyPath = \Wrapped.optionalPartialConvertible
                var lastUpdate: (keyPath: KeyPath<Wrapped, PartialConvertibleType?>, update: PartialBuilder<Wrapped>.PropertyUpdate<PartialConvertibleType?>)?
                var cancellable: Cancellable?

                beforeEach {
                    cancellable = builder.subscribeForChanges(to: subscribedKeyPath, updateListener: { keyPath, update in
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

                context("when subscribed key path is set to a non-optional value") {
                    var valueSet: PartialConvertibleType!

                    beforeEach {
                        valueSet = "set value"
                        builder.setValue(valueSet, for: subscribedKeyPath)
                    }

                    it("should call the subscriber with a `valueSet` update containing the new value") {
                        expect(lastUpdate?.update) == .valueSet(valueSet)
                    }

                    it("should call the subscriber with the subscribed key path") {
                        expect(lastUpdate?.keyPath) == subscribedKeyPath
                    }
                }

                context("when subscribed key path is set to nil") {
                    beforeEach {
                        builder.setValue(nil, for: subscribedKeyPath)
                    }

                    it("should call the subscriber with a `valueSet` update containing nil") {
                        expect(lastUpdate?.update) == .valueSet(nil)
                    }

                    it("should call the subscriber with the subscribed key path") {
                        expect(lastUpdate?.keyPath) == subscribedKeyPath
                    }
                }

                context("when subscribed key path is removed") {
                    beforeEach {
                        builder.removeValue(for: subscribedKeyPath)
                    }

                    it("should call the subscriber with a `valueRemoved` update") {
                        expect(lastUpdate?.update) == .valueRemoved
                    }

                    it("should call the subscriber with the subscribed key path") {
                        expect(lastUpdate?.keyPath) == subscribedKeyPath
                    }
                }

                context("when subscribed key path is set to an incomplete partial") {
                    beforeEach {
                        try? builder.setValue(Partial<PartialConvertibleType>(), for: subscribedKeyPath)
                    }

                    it("should not call update listener") {
                        expect(lastUpdate).to(beNil())
                    }
                }

                context("when subscribed key path is set to a complete partial") {
                    var unwrappedValueSet: PartialConvertibleType!

                    beforeEach {
                        var partial = Partial<PartialConvertibleType>()
                        partial[\.string] = "new value"
                        unwrappedValueSet = "new value"
                        try? builder.setValue(partial, for: subscribedKeyPath)
                    }

                    it("should call the subscriber with a `valueSet` update containing the unwrapped value") {
                        expect(lastUpdate?.update) == .valueSet(unwrappedValueSet)
                    }

                    it("should call the subscriber with the subscribed key path") {
                        expect(lastUpdate?.keyPath) == subscribedKeyPath
                    }
                }

                context("when a key path other than the subscribed key path is set") {
                    beforeEach {
                        builder.setValue("set value", for: \.string)
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
                        beforeEach {
                            builder.setValue("set value", for: subscribedKeyPath)
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
                        beforeEach {
                            builder.setValue("set value", for: subscribedKeyPath)
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
