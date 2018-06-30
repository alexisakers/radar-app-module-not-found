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
import Security

@objc public class Random: NSObject {

    @objc public static func randomText(length: Int) -> String {

        let randomLength = length / 2

        var buffer = UnsafeMutableRawPointer.allocate(byteCount: randomLength,
                                                      alignment: MemoryLayout<UInt8>.alignment)

        defer {
            buffer.deallocate()
        }

        _ = SecRandomCopyBytes(kSecRandomDefault, randomLength, buffer)

        let data = Data(bytes: buffer, count: randomLength)

        return data.reduce("") { current, byte in

            var digitString = String(byte, radix: 16)

            if digitString.count == 1 {
                digitString.insert("0", at: digitString.startIndex)
            }

            return current + digitString

        }

    }

}
