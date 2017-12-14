import Foundation

/// Public API for review comments on different entities.
public class ReviewsService {
    let repository: ReviewsRepository

    /// Initializes a new `ReviewsService` instance with a repository.
    public init(withRepository repository: ReviewsRepository) {
        self.repository = repository
    }
}

extension ReviewsService: ReviewsServiceCallable {
    public func createReview(withData data: ReviewData) throws -> Review {
        if data.comment.isEmpty {
            throw ReviewsError.invalidComment
        }

        return try repository.createReview(data: data)
    }

    public func getReviews(forAttribute attrId: UUID) throws -> [Review] {
        return try repository.getReviews(forAttribute: attrId)
    }

    public func updateReview(id: UUID, data: ReviewPatch) throws -> Review {
        var reviewData = try repository.getReviewData(forId: id)
        if let rating = data.rating {
            reviewData.rating = rating
        }

        if let comment = data.comment {
            if comment.isEmpty {
                throw ReviewsError.invalidComment
            }

            reviewData.comment = comment
        }

        return try repository.updateReviewData(id: id, data: reviewData)
    }
}
