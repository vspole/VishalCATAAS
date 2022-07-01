//
//  SlideShowViewModelTests.swift
//  VishalCATAASTests
//
//  Created by Vishal Polepalli on 7/1/22.
//

@testable import VishalCATAAS
import XCTest

class CryptoDetailViewModelTests: XCTestCase {
    var container: DependencyContainer!
    var catNetworkingService: MockCatNetworkingService!
    var sut: SlideShowView.ViewModel!

    override func setUpWithError() throws {
        container = DependencyContainer()
        catNetworkingService = MockCatNetworkingService(entity: container)
        container.components = [
            catNetworkingService
        ]
        sut = .init(container: container)
    }

    override func tearDownWithError() throws {
        container = nil
        catNetworkingService = nil
        sut = nil
    }
    
    func test_init_slideShowVM_fetchesCatsWithLimit() {
        // Arrange
        let view = SlideShowView(viewModel: self.sut)

        // Act
        sut.viewDidAppear(view)

        // Assert
        XCTAssertEqual(catNetworkingService.fetchCatsWithLimitCount, 1)
    }
    
    func test_init_slideShowVM_fetchesCatsWithTag() {
        // Arrange
        sut = .init(container: container, tag: "cute")
        let view = SlideShowView(viewModel: self.sut)

        // Act
        sut.viewDidAppear(view)

        // Assert
        XCTAssertEqual(catNetworkingService.fetchCatsWithTagCount, 1)
    }
}
