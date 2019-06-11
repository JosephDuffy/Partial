public protocol PartialProtocol {

    associatedtype Wrapped

    func value<Value>(for key: KeyPath<Wrapped, Value>) throws -> Value

    func value<Value>(for key: KeyPath<Wrapped, Value?>) throws -> Value?

    func value<Value>(for key: KeyPath<Wrapped, Value>) -> Value?

    func value<Value>(for key: KeyPath<Wrapped, Value>) throws -> Value where Value: PartialConvertible

    func value<Value>(for key: KeyPath<Wrapped, Value?>) throws -> Value? where Value: PartialConvertible

    func value<Value>(for key: KeyPath<Wrapped, Value>) -> Value? where Value: PartialConvertible

    func partialValue<Value>(for key: KeyPath<Wrapped, Value>) throws -> Partial<Value>

    func partialValue<Value>(for key: KeyPath<Wrapped, Value?>) throws -> Partial<Value>

    mutating func set<Value>(value: Value, for key: KeyPath<Wrapped, Value>)

    mutating func set<Value>(value: Value?, for key: KeyPath<Wrapped, Value?>)

    mutating func set<Value>(value: Partial<Value>, for key: KeyPath<Wrapped, Value>) where Value: PartialConvertible

    mutating func set<Value>(value: Partial<Value>, for key: KeyPath<Wrapped, Value?>) where Value: PartialConvertible

    mutating func removeValue(for key: PartialKeyPath<Wrapped>)

    subscript<Value>(key: KeyPath<Wrapped, Value>) -> Value? { get set }

    subscript<Value>(key: KeyPath<Wrapped, Value>) -> Partial<Value> { get }

    subscript<Value>(key: KeyPath<Wrapped, Value?>) -> Partial<Value> { get }

    subscript<Value>(key: KeyPath<Wrapped, Value>) -> Partial<Value> where Value: PartialConvertible { get set }

    subscript<Value>(key: KeyPath<Wrapped, Value?>) -> Partial<Value> where Value: PartialConvertible { get set }

    subscript<Value>(key: KeyPath<Wrapped, Value>) -> Value? where Value: PartialConvertible { get set }

}

extension PartialProtocol {

    public func value<Value>(for key: KeyPath<Wrapped, Value>) -> Value? {
        do {
            let value: Value = try self.value(for: key)
            return value
        } catch {
            return nil
        }
    }

    public func value<Value>(for key: KeyPath<Wrapped, Value>) -> Value? where Value: PartialConvertible {
        do {
            let value: Value = try self.value(for: key)
            return value
        } catch {
            return nil
        }
    }

    public subscript<Value>(key: KeyPath<Wrapped, Value>) -> Value? {
        get {
            return value(for: key)
        }
        set {
            if let newValue = newValue {
                set(value: newValue, for: key)
            } else {
                removeValue(for: key)
            }
        }
    }

    public subscript<Value>(key: KeyPath<Wrapped, Value>) -> Partial<Value> where Value: PartialConvertible {
        get {
            do {
                return try partialValue(for: key)
            } catch {
                return Partial<Value>()
            }
        }
        set {
            set(value: newValue, for: key)
        }
    }

    public subscript<Value>(key: KeyPath<Wrapped, Value?>) -> Partial<Value> where Value: PartialConvertible {
        get {
            do {
                return try partialValue(for: key)
            } catch {
                return Partial<Value>()
            }
        }
        set {
            set(value: newValue, for: key)
        }
    }

    public subscript<Value>(key: KeyPath<Wrapped, Value>) -> Partial<Value> {
        do {
            return try partialValue(for: key)
        } catch {
            return Partial<Value>()
        }
    }

    public subscript<Value>(key: KeyPath<Wrapped, Value?>) -> Partial<Value> {
        do {
            return try partialValue(for: key)
        } catch {
            return Partial<Value>()
        }
    }

    public subscript<Value>(key: KeyPath<Wrapped, Value>) -> Value? where Value: PartialConvertible {
        get {
            return value(for: key)
        }
        set {
            if let partialValue = newValue {
                set(value: partialValue, for: key)
            } else {
                removeValue(for: key)
            }
        }
    }

}
