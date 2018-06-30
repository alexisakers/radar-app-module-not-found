//
// Wire
// Copyright (C) 2018 Wire Swiss GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//

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
