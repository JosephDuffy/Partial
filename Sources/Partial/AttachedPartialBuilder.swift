//
//  AttachedPartialBuilder.swift
//  Partial
//
//  Created by David Peterson on 3/10/20.
//  Copyright © 2020 Joseph Duffy. All rights reserved.
//

import Foundation

/// A subclass of `PartialBuilder` which allows a `Subscription` to be linked to it.
public class AttachedPartialBuilder<Wrapped>: PartialBuilder<Wrapped> {
    internal var attachedSubscription: Subscription?

    required public init() {
        super.init()
    }
    
    /// Detaches itself from the attached `Subscription`. It does not `cancel()` the subscription,
    /// so if other references still exist, the subscription will stay active.
    public func detach() {
        attachedSubscription = nil
    }
}
