import Foundation
import XCTest

@testable import ArvosteluCore

class RepositoryTests: XCTestCase {
    static var allTests: [(String, (RepositoryTests) -> () throws -> Void)] = [
        ("Test review creation", testReviewCreation),
        ("Test review update", testReviewUpdate),
        ("Test store calls", testStoreCalls),
    ]

    func testReviewCreation() {
        let store = TestStore()
        let repository = ReviewsRepository(withStore: store)
        let reviewData = ReviewData(forUser: UUID(), attributeId: UUID())
        let data = try! repository.createReview(data: reviewData)
        // These two timestamps should be the same in creation
        XCTAssertEqual(data.createdOn, data.updatedAt)
        XCTAssertTrue(store.createCalled)       // store has been called for creation
        XCTAssertNotNil(repository.reviews[data.id])    // repository has the review
    }

    func testReviewUpdate() {
        let store = TestStore()
        let repository = ReviewsRepository(withStore: store)
        var reviewData = ReviewData(forUser: UUID(), attributeId: UUID())
        let data = try! repository.createReview(data: reviewData)
        reviewData.comment = "foobar"
        let updatedData = try! repository.updateReviewData(id: data.id, data: reviewData)
        // We're just testing the function calls (extensive testing is done in service)
        XCTAssertEqual(updatedData.data.comment, "foobar")
        XCTAssertTrue(store.updateCalled)
    }

    func testStoreCalls() {
        let store = TestStore()
        let repository = ReviewsRepository(withStore: store)
        let reviewData = ReviewData(forUser: UUID(), attributeId: UUID())
        let data = try! repository.createReview(data: reviewData)
        repository.reviews = [:]        // clear the repository
        let _ = try? repository.getReview(forId: data.id)
        XCTAssertTrue(store.getCalled)  // this should've called the store
        store.getCalled = false         // now, pretend that we've never called the store
        let _ = try? repository.getReview(forId: data.id)
        // store shouldn't be called, because the data was recently fetched by the repository
        XCTAssertFalse(store.getCalled)
    }
}
