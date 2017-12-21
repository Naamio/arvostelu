import Foundation
import XCTest

@testable import ArvosteluCore

class ServiceTests: XCTestCase {
    static var allTests: [(String, (ServiceTests) -> () throws -> Void)] = [
        ("Test review creation", testReviewCreation),
        ("Test invalid review comment", testInvalidComment),
        ("Test review update", testReviewUpdate),
    ]

    func testReviewCreation() {
        let store = TestStore()
        let repository = ReviewsRepository(withStore: store)
        let service = ReviewsService(withRepository: repository)
        var reviewData = ReviewData(forUser: UUID(), attributeId: UUID())
        reviewData.comment = "You suck!"

        let data = try! service.createReview(withData: reviewData)
        XCTAssertEqual(data.createdOn, data.updatedAt)
    }

    func testInvalidComment() {
        let store = TestStore()
        let repository = ReviewsRepository(withStore: store)
        let service = ReviewsService(withRepository: repository)
        let reviewData = ReviewData(forUser: UUID(), attributeId: UUID())
        do {    // comment is checked first
            let _ = try service.createReview(withData: reviewData)
            XCTFail()
        } catch let err {
            XCTAssertTrue(err as! ReviewsError == ReviewsError.invalidComment)
        }
    }

    func testReviewUpdate() {
        let store = TestStore()
        let repository = ReviewsRepository(withStore: store)
        let service = ReviewsService(withRepository: repository)
        var reviewData = ReviewData(forUser: UUID(), attributeId: UUID())
        reviewData.comment = "You suck!"

        let data = try! service.createReview(withData: reviewData)
        XCTAssertEqual(data.data.rating, .worse)
        XCTAssertEqual(data.data.comment, "You suck!")
        XCTAssertEqual(data.createdOn, data.updatedAt)

        var patch = ReviewPatch()
        patch.rating = .good    // change rating
        let update1 = try! service.updateReview(id: data.id, data: patch)
        XCTAssertEqual(update1.data.rating, .good)
        XCTAssertTrue(update1.createdOn != update1.updatedAt)

        patch.comment = "This is amazing!"      // change comment
        let update2 = try! service.updateReview(id: data.id, data: patch)
        XCTAssertEqual(update2.data.comment, "This is amazing!")

        patch.comment = ""      // invalid comment
        do {
            let _ = try service.updateReview(id: data.id, data: patch)
            XCTFail()
        } catch let err {
            XCTAssertEqual(err as! ReviewsError, ReviewsError.invalidComment)
        }
    }
}
