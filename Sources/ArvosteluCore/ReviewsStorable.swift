import Foundation

/// Methods required for a reviews store.
public protocol ReviewsStorable {
    /// Create a review with data from the repository.
    func createReview(data: Review) throws -> ()

    /// Update a review associated with an ID.
    func updateReview(data: Review) throws -> ()

    /// Get the review corresponding to an ID.
    func getReview(forId id: UUID) throws -> Review

    /// Get the reviews belonging to a product.
    // FIXME: Support pagination
    func getReviews(forAttribute id: UUID) throws -> [Review]
}
