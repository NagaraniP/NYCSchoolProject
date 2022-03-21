//
//  _0220320_NagaraniParapelly_NYCSchoolsUITestsLaunchTests.m
//  20220320-NagaraniParapelly-NYCSchoolsUITests
//
//  Created by raniraja on 3/20/22.
//

#import <XCTest/XCTest.h>

@interface _0220320_NagaraniParapelly_NYCSchoolsUITestsLaunchTests : XCTestCase

@end

@implementation _0220320_NagaraniParapelly_NYCSchoolsUITestsLaunchTests

+ (BOOL)runsForEachTargetApplicationUIConfiguration {
    return YES;
}

- (void)setUp {
    self.continueAfterFailure = NO;
}

- (void)testLaunch {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app launch];

    // Insert steps here to perform after app launch but before taking a screenshot,
    // such as logging into a test account or navigating somewhere in the app

    XCTAttachment *attachment = [XCTAttachment attachmentWithScreenshot:XCUIScreen.mainScreen.screenshot];
    attachment.name = @"Launch Screen";
    attachment.lifetime = XCTAttachmentLifetimeKeepAlways;
    [self addAttachment:attachment];
}

@end
