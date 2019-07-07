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
                var subscription: Subscription?

                beforeEach {
                    subscription = builder.subscribeToAllChanges(updateListener: { keyPath, builder in
                        lastUpdate = (keyPath, builder)
                    })
                }

                afterEach {
                    subscription?.cancel()
                    subscription = nil
                    lastUpdate = nil
                }

                it("should not call the subscriber") {
                    expect(lastUpdate).to(beNil())
                }

                context("when a non-optional key path is set") {
                    var newValue: String!
                    var setKeyPath: KeyPath<Wrapped, String>!

                    beforeEach {
                        setKeyPath = \.string
                        newValue = "new value"
                        builder.setValue(newValue, for: setKeyPath)
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

                context("after the subscription has been deallocated") {
                    beforeEach {
                        subscription = nil
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
                var lastUpdate: PartialBuilder<Wrapped>.KeyPathUpdate<String>?
                var subscription: Subscription?

                beforeEach {
                    subscription = builder.subscribeForChanges(to: subscribedKeyPath, updateListener: { update in
                        lastUpdate = update
                    })
                }

                afterEach {
                    subscription?.cancel()
                    subscription = nil
                    lastUpdate = nil
                }

                it("should not call the subscriber") {
                    expect(lastUpdate).to(beNil())
                }

                context("when subscribed key path does not have a value") {
                    context("setting a value for the subscribed key path") {
                        var newValue: String!

                        beforeEach {
                            newValue = "new value"
                            builder.setValue(newValue, for: subscribedKeyPath)
                        }

                        it("should call the subscriber with a `valueSet` update containing the new value") {
                            expect(lastUpdate?.kind) == .valueSet(newValue)
                        }

                        it("should call the subscriber with the subscribed key path") {
                            expect(lastUpdate?.keyPath) == subscribedKeyPath
                        }

                        it("should call the subscriber with the new value") {
                            expect(lastUpdate?.newValue) == newValue
                        }

                        it("should call the subscriber with an old value of `nil`") {
                            expect(lastUpdate?.oldValue).to(beNil())
                        }
                    }

                    context("removing the value for the subscribed key path") {
                        beforeEach {
                            builder.removeValue(for: subscribedKeyPath)
                        }

                        it("should call the subscriber with a `valueRemoved` update") {
                            expect(lastUpdate?.kind) == .valueRemoved
                        }

                        it("should call the subscriber with the subscribed key path") {
                            expect(lastUpdate?.keyPath) == subscribedKeyPath
                        }

                        it("should call the subscriber with a new value of `nil`") {
                            expect(lastUpdate?.newValue).to(beNil())
                        }

                        it("should call the subscriber with an old value of `nil`") {
                            expect(lastUpdate?.oldValue).to(beNil())
                        }
                    }
                }

                context("when subscribed key path has a value") {
                    context("setting a value for the subscribed key path") {
                        var firstValue: String!
                        var secondValue: String!

                        beforeEach {
                            firstValue = "first value"
                            secondValue = "second value"
                            builder.setValue(firstValue, for: subscribedKeyPath)
                            builder.setValue(secondValue, for: subscribedKeyPath)
                        }

                        it("should call the subscriber with a `valueSet` update containing the new value") {
                            expect(lastUpdate?.kind) == .valueSet(secondValue)
                        }

                        it("should call the subscriber with the subscribed key path") {
                            expect(lastUpdate?.keyPath) == subscribedKeyPath
                        }

                        it("should call the subscriber with the new value") {
                            expect(lastUpdate?.newValue) == secondValue
                        }

                        it("should call the subscriber with the old value") {
                            expect(lastUpdate?.oldValue) == firstValue
                        }
                    }

                    context("removing the value for the subscribed key path") {
                        beforeEach {
                            builder.removeValue(for: subscribedKeyPath)
                        }

                        it("should call the subscriber with a `valueRemoved` update") {
                            expect(lastUpdate?.kind) == .valueRemoved
                        }

                        it("should call the subscriber with the subscribed key path") {
                            expect(lastUpdate?.keyPath) == subscribedKeyPath
                        }

                        it("should call the subscriber with a new value of `nil`") {
                            expect(lastUpdate?.newValue).to(beNil())
                        }

                        it("should call the subscriber with an old value of `nil`") {
                            expect(lastUpdate?.oldValue).to(beNil())
                        }
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
                        subscription?.cancel()
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

                context("after the subscription has been deallocated") {
                    beforeEach {
                        subscription = nil
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
                var lastUpdate: PartialBuilder<Wrapped>.KeyPathUpdate<String?>?
                var subscription: Subscription?

                beforeEach {
                    subscription = builder.subscribeForChanges(to: subscribedKeyPath, updateListener: { update in
                        lastUpdate = update
                    })
                }

                afterEach {
                    subscription?.cancel()
                    subscription = nil
                    lastUpdate = nil
                }

                it("should not call the subscriber") {
                    expect(lastUpdate).to(beNil())
                }

                context("when subscribed key path does not have a value") {
                    context("setting the subscribed key path to a non-optional value") {
                        var newValue: String!

                        beforeEach {
                            newValue = "new value"
                            builder.setValue(newValue, for: subscribedKeyPath)
                        }

                        it("should call the subscriber with a `valueSet` update containing the new value") {
                            expect(lastUpdate?.kind) == .valueSet(newValue)
                        }

                        it("should call the subscriber with the subscribed key path") {
                            expect(lastUpdate?.keyPath) == subscribedKeyPath
                        }

                        it("should call the subscriber with the new value") {
                            expect(lastUpdate?.newValue).to(equal(newValue))
                        }

                        it("should call the subscriber with an old value of `nil`") {
                            expect(lastUpdate?.oldValue).to(beNil())
                        }
                    }

                    context("setting the subscribed key path to nil") {
                        beforeEach {
                            builder.setValue(nil, for: subscribedKeyPath)
                        }

                        it("should call the subscriber with a `valueSet` update containing nil") {
                            expect(lastUpdate?.kind) == .valueSet(nil)
                        }

                        it("should call the subscriber with the subscribed key path") {
                            expect(lastUpdate?.keyPath) == subscribedKeyPath
                        }

                        it("should call the subscriber with a new value of `nil` wrapped in an optional") {
                            expect(lastUpdate?.newValue).to(beNilWrappedInOptional())
                        }

                        it("should call the subscriber with an old value of `nil`") {
                            expect(lastUpdate?.oldValue).to(beNil())
                        }
                    }

                    context("removing the subscribed key path") {
                        beforeEach {
                            builder.removeValue(for: subscribedKeyPath)
                        }

                        it("should call the subscriber with a `valueRemoved` update") {
                            expect(lastUpdate?.kind) == .valueRemoved
                        }

                        it("should call the subscriber with the subscribed key path") {
                            expect(lastUpdate?.keyPath) == subscribedKeyPath
                        }

                        it("should call the subscriber with a new value of `nil`") {
                            expect(lastUpdate?.newValue).to(beNil())
                        }

                        it("should call the subscriber with an old value of `nil`") {
                            expect(lastUpdate?.oldValue).to(beNil())
                        }
                    }
                }

                context("when subscribed key path has a value of `nil`") {
                    beforeEach {
                        builder.setValue(nil, for: subscribedKeyPath)
                    }

                    context("setting the subscribed key path to a non-optional value") {
                        var newValue: String!

                        beforeEach {
                            newValue = "new value"
                            builder.setValue(newValue, for: subscribedKeyPath)
                        }

                        it("should call the subscriber with a `valueSet` update containing the new value") {
                            expect(lastUpdate?.kind) == .valueSet(newValue)
                        }

                        it("should call the subscriber with the subscribed key path") {
                            expect(lastUpdate?.keyPath) == subscribedKeyPath
                        }

                        it("should call the subscriber with the new value") {
                            expect(lastUpdate?.newValue).to(equal(newValue))
                        }

                        it("should call the subscriber with an old value of `nil` wrapped in an Optional") {
                            expect(lastUpdate?.oldValue).to(beNilWrappedInOptional())
                        }
                    }

                    context("setting the subscribed key path to nil") {
                        beforeEach {
                            builder.setValue(nil, for: subscribedKeyPath)
                        }

                        it("should call the subscriber with a `valueSet` update containing nil") {
                            expect(lastUpdate?.kind) == .valueSet(nil)
                        }

                        it("should call the subscriber with the subscribed key path") {
                            expect(lastUpdate?.keyPath) == subscribedKeyPath
                        }

                        it("should call the subscriber with a new value of `nil` wrapped in an optional") {
                            expect(lastUpdate?.newValue).to(beNilWrappedInOptional())
                        }

                        it("should call the subscriber with an old value of `nil` wrapped in an Optional") {
                            expect(lastUpdate?.oldValue).to(beNilWrappedInOptional())
                        }
                    }

                    context("removing the subscribed key path") {
                        beforeEach {
                            builder.removeValue(for: subscribedKeyPath)
                        }

                        it("should call the subscriber with a `valueRemoved` update") {
                            expect(lastUpdate?.kind) == .valueRemoved
                        }

                        it("should call the subscriber with the subscribed key path") {
                            expect(lastUpdate?.keyPath) == subscribedKeyPath
                        }

                        it("should call the subscriber with a new value of `nil`") {
                            expect(lastUpdate?.newValue).to(beNil())
                        }

                        it("should call the subscriber with an old value of `nil` wrapped in an Optional") {
                            expect(lastUpdate?.oldValue).to(beNilWrappedInOptional())
                        }
                    }
                }

                context("when subscribed key path has a non-nil value") {
                    var previousValue: String!

                    beforeEach {
                        previousValue = "first value"
                        builder.setValue(previousValue, for: subscribedKeyPath)
                    }

                    context("setting the subscribed key path to a non-optional value") {
                        var newValue: String!

                        beforeEach {
                            newValue = "new value"
                            builder.setValue(newValue, for: subscribedKeyPath)
                        }

                        it("should call the subscriber with a `valueSet` update containing the new value") {
                            expect(lastUpdate?.kind) == .valueSet(newValue)
                        }

                        it("should call the subscriber with the subscribed key path") {
                            expect(lastUpdate?.keyPath) == subscribedKeyPath
                        }

                        it("should call the subscriber with the new value") {
                            expect(lastUpdate?.newValue) == newValue
                        }

                        it("should call the subscriber with the old value") {
                            expect(lastUpdate?.oldValue) == previousValue
                        }
                    }

                    context("setting the subscribed key path to nil") {
                        beforeEach {
                            builder.setValue(nil, for: subscribedKeyPath)
                        }

                        it("should call the subscriber with a `valueSet` update containing nil") {
                            expect(lastUpdate?.kind) == .valueSet(nil)
                        }

                        it("should call the subscriber with the subscribed key path") {
                            expect(lastUpdate?.keyPath) == subscribedKeyPath
                        }

                        it("should call the subscriber with a new value of `nil` wrapped in an optional") {
                            expect(lastUpdate?.newValue).to(beNilWrappedInOptional())
                        }

                        it("should call the subscriber with the old value") {
                            expect(lastUpdate?.oldValue) == previousValue
                        }
                    }

                    context("removing the subscribed key path") {
                        beforeEach {
                            builder.removeValue(for: subscribedKeyPath)
                        }

                        it("should call the subscriber with a `valueRemoved` update") {
                            expect(lastUpdate?.kind) == .valueRemoved
                        }

                        it("should call the subscriber with the subscribed key path") {
                            expect(lastUpdate?.keyPath) == subscribedKeyPath
                        }

                        it("should call the subscriber with a new value of `nil`") {
                            expect(lastUpdate?.newValue).to(beNil())
                        }

                        it("should call the subscriber with the old value") {
                            expect(lastUpdate?.oldValue) == previousValue
                        }
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
                        subscription?.cancel()
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

                context("after the subscription has been deallocated") {
                    beforeEach {
                        subscription = nil
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
                var lastUpdate: PartialBuilder<Wrapped>.KeyPathUpdate<PartialConvertibleType>?
                var subscription: Subscription?

                beforeEach {
                    subscription = builder.subscribeForChanges(to: subscribedKeyPath, updateListener: { update in
                        lastUpdate = update
                    })
                }

                afterEach {
                    subscription?.cancel()
                    subscription = nil
                    lastUpdate = nil
                }

                it("should not call the subscriber") {
                    expect(lastUpdate).to(beNil())
                }

                context("when subscribed key path does not have a value") {
                    context("setting a value for the subscribed key path") {
                        var newValue: PartialConvertibleType!

                        beforeEach {
                            newValue = "new value"
                            builder.setValue(newValue, for: subscribedKeyPath)
                        }

                        it("should call the subscriber with a `valueSet` update containing the new value") {
                            expect(lastUpdate?.kind) == .valueSet(newValue)
                        }

                        it("should call the subscriber with the subscribed key path") {
                            expect(lastUpdate?.keyPath) == subscribedKeyPath
                        }

                        it("should call the subscriber with the new value") {
                            expect(lastUpdate?.newValue) == newValue
                        }

                        it("should call the subscriber with an old value of `nil`") {
                            expect(lastUpdate?.oldValue).to(beNil())
                        }
                    }

                    context("setting subscribed key path to an incomplete partial") {
                        beforeEach {
                            try? builder.setValue(Partial<PartialConvertibleType>(), for: subscribedKeyPath)
                        }

                        it("should not call update listener") {
                            expect(lastUpdate).to(beNil())
                        }
                    }

                    context("setting subscribed key path to a complete partial") {
                        var unwrappedValueSet: PartialConvertibleType!

                        beforeEach {
                            var partial = Partial<PartialConvertibleType>()
                            partial[\.string] = "new value"
                            unwrappedValueSet = "new value"
                            try? builder.setValue(partial, for: subscribedKeyPath)
                        }

                        it("should call the subscriber with a `valueSet` update containing the unwrapped value") {
                            expect(lastUpdate?.kind) == .valueSet(unwrappedValueSet)
                        }

                        it("should call the subscriber with the subscribed key path") {
                            expect(lastUpdate?.keyPath) == subscribedKeyPath
                        }

                        it("should call the subscriber with the new value") {
                            expect(lastUpdate?.newValue) == unwrappedValueSet
                        }

                        it("should call the subscriber with an old value of `nil`") {
                            expect(lastUpdate?.oldValue).to(beNil())
                        }
                    }

                    context("removing the value for the subscribed key path") {
                        beforeEach {
                            builder.removeValue(for: subscribedKeyPath)
                        }

                        it("should call the subscriber with a `valueRemoved` update") {
                            expect(lastUpdate?.kind) == .valueRemoved
                        }

                        it("should call the subscriber with the subscribed key path") {
                            expect(lastUpdate?.keyPath) == subscribedKeyPath
                        }

                        it("should call the subscriber with a new value of `nil`") {
                            expect(lastUpdate?.newValue).to(beNil())
                        }

                        it("should call the subscriber with an old value of `nil`") {
                            expect(lastUpdate?.oldValue).to(beNil())
                        }
                    }
                }

                context("when subscribed key path has a value") {
                    var firstValue: PartialConvertibleType!

                    beforeEach {
                        firstValue = "first value"
                        builder.setValue(firstValue, for: subscribedKeyPath)
                        lastUpdate = nil
                    }

                    context("setting a value for the subscribed key path") {
                        var secondValue: PartialConvertibleType!

                        beforeEach {
                            secondValue = "second value"
                            builder.setValue(secondValue, for: subscribedKeyPath)
                        }

                        it("should call the subscriber with a `valueSet` update containing the new value") {
                            expect(lastUpdate?.kind) == .valueSet(secondValue)
                        }

                        it("should call the subscriber with the subscribed key path") {
                            expect(lastUpdate?.keyPath) == subscribedKeyPath
                        }

                        it("should call the subscriber with the new value") {
                            expect(lastUpdate?.newValue) == secondValue
                        }

                        it("should call the subscriber with the old value") {
                            expect(lastUpdate?.oldValue) == firstValue
                        }
                    }

                    context("setting subscribed key path to an incomplete partial") {
                        beforeEach {
                            try? builder.setValue(Partial<PartialConvertibleType>(), for: subscribedKeyPath)
                        }

                        it("should not call update listener") {
                            expect(lastUpdate).to(beNil())
                        }
                    }

                    context("setting subscribed key path to a complete partial") {
                        var unwrappedValueSet: PartialConvertibleType!

                        beforeEach {
                            var partial = Partial<PartialConvertibleType>()
                            partial[\.string] = "new value"
                            unwrappedValueSet = "new value"
                            try? builder.setValue(partial, for: subscribedKeyPath)
                        }

                        it("should call the subscriber with a `valueSet` update containing the unwrapped value") {
                            expect(lastUpdate?.kind) == .valueSet(unwrappedValueSet)
                        }

                        it("should call the subscriber with the subscribed key path") {
                            expect(lastUpdate?.keyPath) == subscribedKeyPath
                        }

                        it("should call the subscriber with the new value") {
                            expect(lastUpdate?.newValue) == unwrappedValueSet
                        }

                        it("should call the subscriber with the old value") {
                            expect(lastUpdate?.oldValue) == firstValue
                        }
                    }

                    context("removing the value for the subscribed key path") {
                        beforeEach {
                            builder.removeValue(for: subscribedKeyPath)
                        }

                        it("should call the subscriber with a `valueRemoved` update") {
                            expect(lastUpdate?.kind) == .valueRemoved
                        }

                        it("should call the subscriber with the subscribed key path") {
                            expect(lastUpdate?.keyPath) == subscribedKeyPath
                        }

                        it("should call the subscriber with a new value of `nil`") {
                            expect(lastUpdate?.newValue).to(beNil())
                        }

                        it("should call the subscriber with the old value") {
                            expect(lastUpdate?.oldValue) == firstValue
                        }
                    }
                }

                context("when subscribed key path is set") {
                    var valueSet: PartialConvertibleType!

                    beforeEach {
                        valueSet = "set value"
                        builder.setValue(valueSet, for: subscribedKeyPath)
                    }

                    it("should call the subscriber with a `valueSet` update containing the new value") {
                        expect(lastUpdate?.kind) == .valueSet(valueSet)
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
                        expect(lastUpdate?.kind) == .valueRemoved
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
                        expect(lastUpdate?.kind) == .valueSet(unwrappedValueSet)
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
                        subscription?.cancel()
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

                context("after the subscription has been deallocated") {
                    beforeEach {
                        subscription = nil
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
                var lastUpdate: PartialBuilder<Wrapped>.KeyPathUpdate<PartialConvertibleType?>?
                var subscription: Subscription?

                beforeEach {
                    subscription = builder.subscribeForChanges(to: subscribedKeyPath, updateListener: { update in
                        lastUpdate = update
                    })
                }

                afterEach {
                    subscription?.cancel()
                    subscription = nil
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
                        expect(lastUpdate?.kind) == .valueSet(valueSet)
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
                        expect(lastUpdate?.kind) == .valueSet(nil)
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
                        expect(lastUpdate?.kind) == .valueRemoved
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
                        expect(lastUpdate?.kind) == .valueSet(unwrappedValueSet)
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
                        subscription?.cancel()
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

                context("after the subscription has been deallocated") {
                    beforeEach {
                        subscription = nil
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
