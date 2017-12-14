import Foundation

/// This has most of the fields from `ReviewData`, but everything's optional.
/// It's used for an update request, where one or more of these properties
/// could be updated for a review comment.
public struct ReviewPatch: Codable {
    public var rating: Rating? = nil
    public var comment: String? = nil

    public init() {}
}
