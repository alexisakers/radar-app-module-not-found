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

import UIKit
@testable import Dogs

struct ColorItem {
    let color: UIColor
    let size: CGSize
}

/*
 * This is the class definition that we think is creating the compilation error.
 *
 * `VerticalColumnCollectionViewController` is imported from the `Dogs` app
 * module. If you make this class a subclass of `UICollectionViewController`
 * instead, the compilation error will not occur.
 *
 * Comment out line 37 and uncomment line 38 to compile the tests successfully.
 * Reverse to see the compilation error again.
 *
 * See comments at lines 54, 58 and 85 to see which parts of the code you need to
 * comment out after this.
 */

class ColorViewController: VerticalColumnCollectionViewController {
// class ColorViewController: UICollectionViewController {

    enum TestEnvironment {
        case phone, tablet
    }

    let dataSource: [ColorItem]
    var testEnvironment: TestEnvironment

    init(dataSource: [ColorItem], testEnvironment: TestEnvironment) {
        self.dataSource = dataSource
        self.testEnvironment = testEnvironment

        // Uncomment these two lines when subclassing VerticalColumnCollectionViewController
        let columnLayout = AdaptiveColumnLayout(compact: 2, regular: 3, large: 4)
        super.init(interItemSpacing: 2, interColumnSpacing: 4, columnLayout: columnLayout)

        // Uncomment these three lines when sublassing UICollectionViewController
        //let layout = UICollectionViewFlowLayout()
        //layout.itemSize = CGSize(width: 100, height: 100)
        //super.init(collectionViewLayout: layout)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = dataSource[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.contentView.backgroundColor = item.color
        return cell
    }

    // Uncomment the lines between the two markers when subclassing VerticalColumnCollectionViewController
    // VerticalColumnCollectionViewController-start

    override func collectionView(_ collectionView: UICollectionView, sizeOfItemAt indexPath: IndexPath) -> CGSize {
        return dataSource[indexPath.row].size
    }

    override var isRegularLayout: Bool {
        return testEnvironment == .tablet
    }

    // VerticalColumnCollectionViewController-end

}
