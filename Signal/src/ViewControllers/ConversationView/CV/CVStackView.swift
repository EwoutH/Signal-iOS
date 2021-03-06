//
//  Copyright (c) 2021 Open Whisper Systems. All rights reserved.
//

import Foundation

public typealias CVStackViewConfig = OWSStackView.Config

// MARK: -

class CVStackView {

    public static func measure(config: CVStackViewConfig,
                               subviewSizes: [CGSize],
                               verboseLogging: Bool = false) -> CGSize {

        let spacingCount = max(0, subviewSizes.count - 1)

        var size = CGSize.zero
        switch config.axis {
        case .horizontal:
            size.width = subviewSizes.map { $0.width }.reduce(0, +)
            size.height = subviewSizes.map { $0.height }.reduce(0, max)

            if verboseLogging {
                Logger.verbose("size of subviews: \(size)")
            }

            size.width += CGFloat(spacingCount) * config.spacing

            if verboseLogging {
                Logger.verbose("size of subviews and spacing: \(size)")
            }
        case .vertical:
            size.width = subviewSizes.map { $0.width }.reduce(0, max)
            size.height = subviewSizes.map { $0.height }.reduce(0, +)

            if verboseLogging {
                Logger.verbose("size of subviews: \(size)")
            }

            size.height += CGFloat(spacingCount) * config.spacing

            if verboseLogging {
                Logger.verbose("size of subviews and spacing: \(size)")
            }
        @unknown default:
            owsFailDebug("Unknown axis: \(config.axis)")
        }

        size.width += config.layoutMargins.left + config.layoutMargins.right
        size.height += config.layoutMargins.top + config.layoutMargins.bottom

        if verboseLogging {
            Logger.verbose("size of subviews and spacing and layoutMargins: \(size)")
        }
        return size
    }
}

// MARK: -

// TODO: Can this be moved to UIView+OWS.swift?
public extension CGRect {

    var width: CGFloat {
        get {
            size.width
        }
        set {
            size.width = newValue
        }
    }

    var height: CGFloat {
        get {
            size.height
        }
        set {
            size.height = newValue
        }
    }
}
