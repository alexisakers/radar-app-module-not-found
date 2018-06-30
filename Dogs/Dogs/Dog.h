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

@import UIKit;

/**
 * The cutest thing on earth.
 */

@interface Dog : NSObject

/// The name of the image representing the dog.
@property (nonatomic, copy) NSString *imageName;

/// The image representing the dog.
@property (nonatomic, strong) UIImage *image;

/// The size of the dog's image.
@property (nonatomic) CGSize imageSize;

/**
 * Creates the dog using the image at the given url.
 * @param fileURL The URL of the file.
 */

+ (Dog *)dogWithFileAtURL:(NSURL *)fileURL NS_SWIFT_NAME(init(url:));

@end
