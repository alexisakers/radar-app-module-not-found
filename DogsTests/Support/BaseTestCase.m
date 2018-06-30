#import "BaseTestCase.h"

@implementation BaseTestCase

- (void)setUp {
    [super setUp];
    if (self.recordMode) {
        NSLog(@"***** Recording snapshots *****");
    }
}

@end
