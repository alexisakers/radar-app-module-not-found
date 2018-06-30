#import "Dog.h"

@implementation Dog

+ (Dog *)dogWithFileAtURL:(NSURL *)fileURL
{
    Dog *dog = [[Dog alloc] init];
    dog.imageName = [[fileURL URLByDeletingPathExtension] lastPathComponent];
    dog.image = [UIImage imageWithContentsOfFile:fileURL.path];
    dog.imageSize = dog.image.size;
    return dog;
}

@end
