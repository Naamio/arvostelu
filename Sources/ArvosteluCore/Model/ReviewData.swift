import Foundation

/// Rating for this review. Rating is mandatory for all review comments.
public enum Rating: UInt8, Codable {
    case worse = 1
    case bad   = 2
    case okay  = 3
    case good  = 4
    case best  = 5
}

/// User-supplied data for a review.
public struct ReviewData: Codable {
    /// ID of the user who posted this review.
    public var createdBy: UUID

    /// ID of the attribute to which this review should be mapped to.
    /// (coffee, movies, application, etc.)
    public let attributeId: UUID

    /// Rating given for this product.
    public var rating: Rating = .worse

    /// Review comment for the product.
    public var comment: String = ""

    // FIXME: Add auth role

    public init(forUser id: UUID, attributeId attrId: UUID) {
        createdBy = id
        attributeId = attrId
    }
}
