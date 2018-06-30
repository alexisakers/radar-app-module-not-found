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
