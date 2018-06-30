import XCTest
@testable import Dogs

class VerticalColumnCollectionViewLayoutTests: BaseTestCase {

    let items: [ColorItem] = [
        // square, downscale
        ColorItem(color: .red, size: CGSize(width: 1000, height: 1000)),
        // square, upscale
        ColorItem(color: .purple, size: CGSize(width: 10, height: 10)),
        // portrait, downscale
        ColorItem(color: .yellow, size: CGSize(width: 1000, height: 1500)),
        // portrait, upscale
        ColorItem(color: .green, size: CGSize(width: 10, height: 15)),
        // landscape, downscale
        ColorItem(color: .blue, size: CGSize(width: 1500, height: 1000)),
        // landscape, upscale
        ColorItem(color: .orange, size: CGSize(width: 15, height: 10)),
        // add 4 more to test multiline
        ColorItem(color: .gray, size: CGSize(width: 1000, height: 1000)),
        ColorItem(color: .brown, size: CGSize(width: 10, height: 10)),
        ColorItem(color: .red, size: CGSize(width: 1000, height: 1500)),
        ColorItem(color: .purple, size: CGSize(width: 10, height: 15))
    ]

    override func setUp() {
        super.setUp()
        recordMode = true
    }

    func testColumns_iPhone() {
        let sut = ColorViewController(dataSource: items, testEnvironment: .phone)
        sut.loadView()
        XCTAssertNotNil(sut.collectionView)
        XCTAssertTrue(sut.collectionViewLayout is VerticalColumnCollectionViewLayout)
        // verifyInAllIPhoneSizes(view: sut.view)
    }

    func testColumns_iPad() {
        let sut = ColorViewController(dataSource: items, testEnvironment: .tablet)
        sut.loadView()
        XCTAssertNotNil(sut.collectionView)
        XCTAssertTrue(sut.collectionViewLayout is VerticalColumnCollectionViewLayout)
        // verifyInAllTabletWidths(view: sut.view)
    }

}
