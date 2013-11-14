#import <XCTest/XCTestLog.h>
#import <XCTest/XCTestSuiteRun.h>
#import <XCTest/XCTest.h>

// Workaround for XCode 5 bug where __gcov_flush is not called properly when Test Coverage flags are set

@interface RIDTestObserver : XCTestLog
@end

//#ifdef DEBUG
extern void __gcov_flush(void);
//#endif

static NSUInteger sTestCounter = 0;
static id mainSuite = nil;

@implementation RIDTestObserver

+(void)load {
    NSLog(@" ************************   load");
    [[NSUserDefaults standardUserDefaults] setValue:@"RIDTestObserver"
                                             forKey:@"XCTestObserverClass"];
}

- (void)testSuiteDidStart:(XCTestRun *)testRun {
    NSLog(@" ************************   testSuiteDidStart");
    [super testSuiteDidStart:testRun];
    
    XCTestSuiteRun *suite = [[XCTestSuiteRun alloc] init];
    [suite addTestRun:testRun];
    
    sTestCounter++;
    
    if (mainSuite == nil) {
        mainSuite = suite;
    }
}

- (void)testSuiteDidStop:(XCTestRun *)testRun {
    NSLog(@" ************************   testSuiteDidStop");

    sTestCounter--;
    
    [super testSuiteDidStop:testRun];
    
    XCTestSuiteRun *suite = [[XCTestSuiteRun alloc] init];
    [suite addTestRun:testRun];
    
    if (sTestCounter == 0) {
        __gcov_flush();
    }
}

@end