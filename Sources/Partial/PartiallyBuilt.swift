/**
 A property wrapper that projects a `PartialBuilder` for setting and retrieving specific keys and wraps a value of type `Value?` that will
 return a non-optional value when the partial can be unwrapped.
 */
@propertyWrapper
public struct PartiallyBuilt<Value: PartialConvertible> {

    public var wrappedValue: Value? {
        return try? projectedValue.unwrapped()
    }

    public var projectedValue: PartialBuilder<Value>

    public init(builder: PartialBuilder<Value> = PartialBuilder<Value>()) {
        projectedValue = builder
    }

    public init(partial: Partial<Value>) {
        projectedValue = PartialBuilder(partial: partial)
    }

}
