//
//  QAUITests.h
//  QAUITests
//
//  Created by Shawn Roller on 12/15/17.
//  Copyright © 2017 JustFab. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface QAUITests : XCTestCase

- (void)waitForElementToAppear:(XCUIElement *)element withTimeout:(NSTimeInterval)timeout;
- (void)waitForButtonElementToAppear:(XCUIElement *)element withTimeout:(NSTimeInterval)timeout;

@end
