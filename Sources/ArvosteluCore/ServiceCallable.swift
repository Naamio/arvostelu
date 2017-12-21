import Foundation

public protocol ReviewsServiceCallable {
    /// Create a review comment for some entity with the given data.
    func createReview(withData data: ReviewData) throws -> Review

    /// Get reviews for an attribute ID.
    func getReviews(forAttribute id: UUID) throws -> [Review]

    /// Update the review associated with a review ID.
    func updateReview(id: UUID, data: ReviewPatch) throws -> Review
}
