public protocol PartialProtocol {
    
    associatedtype Wrapped
    
    func value<Value>(for key: KeyPath<Wrapped, Value>) throws -> Value
    
    func value<Value>(for key: KeyPath<Wrapped, Value?>) throws -> Value?

    func value<Value>(for key: KeyPath<Wrapped, Value>) -> Value?
    
    func value<Value>(for key: KeyPath<Wrapped, Value>) throws -> Value where Value: PartialConvertible
    
    func value<Value>(for key: KeyPath<Wrapped, Value?>) throws -> Value? where Value: PartialConvertible
    
    func partialValue<Value>(for key: KeyPath<Wrapped, Value>) throws -> Partial<Value> where Value: PartialConvertible
    
    func partialValue<Value>(for key: KeyPath<Wrapped, Value?>) throws -> Partial<Value> where Value: PartialConvertible
    
    mutating func set<Value>(value: Value, for key: KeyPath<Wrapped, Value>)
    
    mutating func set<Value>(value: Value?, for key: KeyPath<Wrapped, Value?>)
    
    mutating func set<Value>(value: Partial<Value>, for key: KeyPath<Wrapped, Value>) where Value: PartialConvertible
    
    mutating func set<Value>(value: Partial<Value>, for key: KeyPath<Wrapped, Value?>) where Value: PartialConvertible
    
    mutating func removeValue<Value>(for key: KeyPath<Wrapped, Value>)
    
    subscript<Value>(key: KeyPath<Wrapped, Value>) -> Value? { get set }
    
    subscript<Value>(key: KeyPath<Wrapped, Value>) -> Partial<Value> where Value: PartialConvertible { get set }
    
    subscript<Value>(key: KeyPath<Wrapped, Value?>) -> Partial<Value> where Value: PartialConvertible { get set }
    
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
                return try self.partialValue(for: key)
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
                return try self.partialValue(for: key)
            } catch {
                return Partial<Value>()
            }
        }
        set {
            set(value: newValue, for: key)
        }
    }

}
