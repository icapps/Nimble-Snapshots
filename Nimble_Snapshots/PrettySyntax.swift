import Nimble

// MARK: - Nicer syntax using == operator

public struct Snapshot {
    let name: String?
    let record: Bool
    let usesDrawRect: Bool

    init(name: String?, record: Bool, usesDrawRect: Bool) {
        self.name = name
        self.record = record
        self.usesDrawRect = usesDrawRect
    }
}

public func snapshot(_ name: String? = nil,
                     usesDrawRect: Bool = false) -> Snapshot {
    return Snapshot(name: name, record: false, usesDrawRect: usesDrawRect)
}

public func recordSnapshot(_ name: String? = nil,
                           usesDrawRect: Bool = false) -> Snapshot {
    return Snapshot(name: name, record: true, usesDrawRect: usesDrawRect)
}

public func == (lhs: Expectation<Snapshotable>, rhs: Snapshot) {
    if let name = rhs.name {
        if rhs.record {
            lhs.to(recordSnapshot(named: name, usesDrawRect: rhs.usesDrawRect))
        } else {
            lhs.to(haveValidSnapshot(named: name, usesDrawRect: rhs.usesDrawRect))
        }

    } else {
        if rhs.record {
            lhs.to(recordSnapshot(usesDrawRect: rhs.usesDrawRect))
        } else {
            lhs.to(haveValidSnapshot(usesDrawRect: rhs.usesDrawRect))
        }
    }
}
