#import <XCTest/XCTest.h>
#import "BaseTestCase.h"
#import "DogsTests-Swift.h"

@interface TestSupportTests : BaseTestCase

@end

@implementation TestSupportTests

- (void)testRandom
{
    NSString *text = [Random randomTextWithLength:10];
    XCTAssertEqual(text.length, 10);
}

@end
