import XCTest
@testable import ArvosteluTests

XCTMain([
    testCase(ServiceTests.allTests),
    testCase(RepositoryTests.allTests),
])
