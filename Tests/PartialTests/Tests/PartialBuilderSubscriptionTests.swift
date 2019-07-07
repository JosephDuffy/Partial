import Quick
import Nimble

@testable
import Partial

final class PartialBuilderSubscriptionTests: QuickSpec {

    override func spec() {
        describe("PartialBuilder") {
            var builder: PartialBuilder<StringWrapperWrapper>!

            beforeEach {
                builder = PartialBuilder()
            }

            context("subscribers to all changes") {
                var lastUpdate: (keyPath: PartialKeyPath<StringWrapperWrapper>, builder: PartialBuilder<StringWrapperWrapper>)?
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

                it("should not be called when being added") {
                    expect(lastUpdate).to(beNil())
                }

                context("when a non-optional key path is set") {
                    var newValue: StringWrapper!
                    var setKeyPath: KeyPath<StringWrapperWrapper, StringWrapper>!

                    beforeEach {
                        setKeyPath = \.stringWrapper
                        newValue = "new value"
                        builder.setValue(newValue, for: setKeyPath)
                    }

                    it("should be called with the set key path") {
                        expect(lastUpdate?.keyPath) == setKeyPath
                    }

                    it("should be called with the builder") {
                        expect(lastUpdate?.builder) === lastUpdate?.builder
                    }
                }

                context("when an optional key path is set to nil") {
                    var setKeyPath: KeyPath<StringWrapperWrapper, StringWrapper?>!

                    beforeEach {
                        setKeyPath = \.optionalStringWrapper
                        builder.setValue(nil, for: setKeyPath)
                    }

                    it("should be called with the set key path") {
                        expect(lastUpdate?.keyPath) == setKeyPath
                    }

                    it("should be called with the builder") {
                        expect(lastUpdate?.builder) === lastUpdate?.builder
                    }
                }

                context("when an optional key path is set to a non-optional value") {
                    var setKeyPath: KeyPath<StringWrapperWrapper, StringWrapper?>!

                    beforeEach {
                        setKeyPath = \.optionalStringWrapper
                        builder.setValue("new value", for: setKeyPath)
                    }

                    it("should be called with the set key path") {
                        expect(lastUpdate?.keyPath) == setKeyPath
                    }

                    it("should be called with the builder") {
                        expect(lastUpdate?.builder) === lastUpdate?.builder
                    }
                }

                context("when a PartialConvertible value is set to an incomplete partial") {
                    beforeEach {
                        try? builder.setValue(Partial<StringWrapper>(), for: \.optionalStringWrapper)
                    }

                    it("should not be called") {
                        expect(lastUpdate).to(beNil())
                    }
                }

                context("when a PartialConvertible value is set to a complete partial") {
                    var setKeyPath: KeyPath<StringWrapperWrapper, StringWrapper>!

                    beforeEach {
                        setKeyPath = \.stringWrapper
                        var partial = Partial<StringWrapper>()
                        partial[\.string] = "new value"
                        try? builder.setValue(partial, for: setKeyPath)
                    }

                    it("should be called with the set key path") {
                        expect(lastUpdate?.keyPath) == setKeyPath
                    }

                    it("should be called with the builder") {
                        expect(lastUpdate?.builder) === lastUpdate?.builder
                    }
                }

                context("when an optional PartialConvertible value is set to an incomplete partial") {
                    beforeEach {
                        try? builder.setValue(Partial<StringWrapper>(), for: \.optionalStringWrapper)
                    }

                    it("should not be called") {
                        expect(lastUpdate).to(beNil())
                    }
                }

                context("when an optional PartialConvertible value is set to a complete partial") {
                    var setKeyPath: KeyPath<StringWrapperWrapper, StringWrapper?>!

                    beforeEach {
                        setKeyPath = \.optionalStringWrapper
                        var partial = Partial<StringWrapper>()
                        partial[\.string] = "new value"
                        try? builder.setValue(partial, for: setKeyPath)
                    }

                    it("should be called with the set key path") {
                        expect(lastUpdate?.keyPath) == setKeyPath
                    }

                    it("should be called with the builder") {
                        expect(lastUpdate?.builder) === lastUpdate?.builder
                    }
                }

                context("after the subscription has been deallocated") {
                    beforeEach {
                        subscription = nil
                    }

                    context("when a key path is set") {
                        beforeEach {
                            builder.setValue("new value", for: \.stringWrapper)
                        }

                        it("should not be called") {
                            expect(lastUpdate).to(beNil())
                        }
                    }
                }
            }

            context("subscribers of a non-optional PartialConvertible property") {
                let subscribedKeyPath = \StringWrapperWrapper.stringWrapper
                var lastUpdate: PartialBuilder<StringWrapperWrapper>.KeyPathUpdate<StringWrapper>?
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

                it("should not be called when being added") {
                    expect(lastUpdate).to(beNil())
                }

                context("when subscribed key path does not have a value") {
                    context("setting a value for the subscribed key path") {
                        var newValue: StringWrapper!

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
                            try? builder.setValue(Partial<StringWrapper>(), for: subscribedKeyPath)
                        }

                        it("should not call update listener") {
                            expect(lastUpdate).to(beNil())
                        }
                    }

                    context("setting subscribed key path to a complete partial") {
                        var unwrappedValueSet: StringWrapper!

                        beforeEach {
                            var partial = Partial<StringWrapper>()
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
                    var firstValue: StringWrapper!

                    beforeEach {
                        firstValue = "first value"
                        builder.setValue(firstValue, for: subscribedKeyPath)
                        lastUpdate = nil
                    }

                    context("setting a value for the subscribed key path") {
                        var secondValue: StringWrapper!

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
                            try? builder.setValue(Partial<StringWrapper>(), for: subscribedKeyPath)
                        }

                        it("should not call update listener") {
                            expect(lastUpdate).to(beNil())
                        }
                    }

                    context("setting subscribed key path to a complete partial") {
                        var unwrappedValueSet: StringWrapper!

                        beforeEach {
                            var partial = Partial<StringWrapper>()
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
            }

            context("subscribers of for an optional PartialConvertible property") {
                let subscribedKeyPath = \StringWrapperWrapper.optionalStringWrapper
                var lastUpdate: PartialBuilder<StringWrapperWrapper>.KeyPathUpdate<StringWrapper?>?
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

                it("should not be called when being added") {
                    expect(lastUpdate).to(beNil())
                }

                context("when subscribed key path does not have a value") {
                    context("setting the subscribed key path to a non-nil value") {
                        var newValue: StringWrapper!

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

                    context("setting the subscribed key path to `nil`") {
                        beforeEach {
                            builder.setValue(nil, for: subscribedKeyPath)
                        }

                        it("should call the subscriber with a `valueSet` update containing `nil`") {
                            expect(lastUpdate?.kind) == .valueSet(nil)
                        }

                        it("should call the subscriber with the subscribed key path") {
                            expect(lastUpdate?.keyPath) == subscribedKeyPath
                        }

                        it("should call the subscriber with a new value of `nil` wrapped in an `Optional`") {
                            expect(lastUpdate?.newValue).to(beNilWrappedInOptional())
                        }

                        it("should call the subscriber with an old value of `nil`") {
                            expect(lastUpdate?.oldValue).to(beNil())
                        }
                    }

                    context("setting subscribed key path to an incomplete partial") {
                        beforeEach {
                            try? builder.setValue(Partial<StringWrapper>(), for: subscribedKeyPath)
                        }

                        it("should not call update listener") {
                            expect(lastUpdate).to(beNil())
                        }
                    }

                    context("setting subscribed key path to a complete partial") {
                        var unwrappedValueSet: StringWrapper!

                        beforeEach {
                            var partial = Partial<StringWrapper>()
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
                    var firstValue: StringWrapper!

                    beforeEach {
                        firstValue = "first value"
                        builder.setValue(firstValue, for: subscribedKeyPath)
                        lastUpdate = nil
                    }

                    context("setting the subscribed key path to a non-nil value") {
                        var secondValue: StringWrapper!

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

                    context("setting the subscribed key path to `nil`") {
                        beforeEach {
                            builder.setValue(nil, for: subscribedKeyPath)
                        }

                        it("should call the subscriber with a `valueSet` update containing `nil`") {
                            expect(lastUpdate?.kind) == .valueSet(nil)
                        }

                        it("should call the subscriber with the subscribed key path") {
                            expect(lastUpdate?.keyPath) == subscribedKeyPath
                        }

                        it("should call the subscriber with a new value of `nil` wrapped in an `Optional`") {
                            expect(lastUpdate?.newValue).to(beNilWrappedInOptional())
                        }

                        it("should call the subscriber with the old value") {
                            expect(lastUpdate?.oldValue) == firstValue
                        }
                    }

                    context("setting subscribed key path to an incomplete partial") {
                        beforeEach {
                            try? builder.setValue(Partial<StringWrapper>(), for: subscribedKeyPath)
                        }

                        it("should not call update listener") {
                            expect(lastUpdate).to(beNil())
                        }
                    }

                    context("setting subscribed key path to a complete partial") {
                        var unwrappedValueSet: StringWrapper!

                        beforeEach {
                            var partial = Partial<StringWrapper>()
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
            }
        }
    }
}
