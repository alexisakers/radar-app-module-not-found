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
