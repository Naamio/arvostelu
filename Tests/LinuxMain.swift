import XCTest

@testable import ArvosteluCoreTests

XCTMain([
    testCase(ArvosteluCoreTests.allTests),
    testCase(RepositoryTests.allTests),
    testCase(ServiceTests.allTests),
])
