//
//  QAUITests.m
//  QAUITests
//
//  Created by Shawn Roller on 12/12/17.
//  Copyright © 2017 JustFab. All rights reserved.
//

#import "QAUITests.h"
#import "constants.h"

@interface QAUITests ()

@property (strong, nonatomic) XCUIApplication *app;

@end

@implementation QAUITests

- (void)setUp {
    [super setUp];
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    
    self.app = [[XCUIApplication alloc] init];
    // Ensure the animations are turned off so we aren't waiting for the app to idle.  UIView animations are turned off based on this key in the Login VC
    self.app.launchEnvironment = @{ UITEST_DISABLE_ANIMATIONS : @"YES" };
    [self.app launch];
    
    // Check to see if login is needed
    XCUIElement *loginButton = self.app.buttons[@"login"];
    BOOL wasNotLoggedIn = NO;
    if (loginButton.hittable) {
        [self login];
        wasNotLoggedIn = YES;
    }
    
    // Get on the QA environment
    [self selectQAAfterLogin:wasNotLoggedIn];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)login
{
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *usernameTextField = app.textFields[@"username"];
    [usernameTextField typeText:@"tfoxuser"];
    
    [app/*@START_MENU_TOKEN@*/.buttons[@"Next:"]/*[[".keyboards",".buttons[@\"Next\"]",".buttons[@\"Next:\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ tap];
    XCUIElement *passwordSecureTextField = app.secureTextFields[@"password"];
    [passwordSecureTextField typeText:@"Testing222"];
    
    XCUIElement *loginButton = app.buttons[@"login"];
    [loginButton tap];
}

- (void)selectQAAfterLogin:(BOOL)wasNotLoggedIn
{
    XCUIApplication *app = [[XCUIApplication alloc] init];
    
    // Wait for login
    XCUIElement *username = app.staticTexts[@"tfoxuser"];
    [self waitForElementToAppear:username withTimeout:20];
    
    // Select the QA1 environment
    XCUIElement *element = [[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1];
    [element.images[@"iWMS Beta Icon"] tap];
    [app.sheets[@"QA"].collectionViews.buttons[@"Select API Server"] tap];
    [app.tables/*@START_MENU_TOKEN@*/.staticTexts[@"QA1"]/*[[".cells.staticTexts[@\"QA1\"]",".staticTexts[@\"QA1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    
    // Select LOU1
    if (wasNotLoggedIn) {
        [[[[[[[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:4] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeImage].element tap];
    }
    else {
        [[[[[[element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:2] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeImage].element tap];
    }
    [app.tables.staticTexts[@"LOU1"] tap];
}

#pragma mark - Helper functions

- (void)waitForElementToAppear:(XCUIElement *)element withTimeout:(NSTimeInterval)timeout
{
    NSUInteger line = __LINE__;
    NSString *file = [NSString stringWithUTF8String:__FILE__];
    NSPredicate *existsPredicate = [NSPredicate predicateWithFormat:@"exists == true"];
    
    [self expectationForPredicate:existsPredicate evaluatedWithObject:element handler:nil];
    
    [self waitForExpectationsWithTimeout:timeout handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSString *message = [NSString stringWithFormat:@"Failed to find %@ after %f seconds",element,timeout];
            [self recordFailureWithDescription:message inFile:file atLine:line expected:YES];
        }
    }];
}

- (void)waitForButtonElementToAppear:(XCUIElement *)element withTimeout:(NSTimeInterval)timeout
{
    NSUInteger line = __LINE__;
    NSString *file = [NSString stringWithUTF8String:__FILE__];
    NSPredicate *hittablePredicate = [NSPredicate predicateWithFormat:@"hittable == true"];
    
    [self expectationForPredicate:hittablePredicate evaluatedWithObject:element handler:nil];
    
    [self waitForExpectationsWithTimeout:timeout handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSString *message = [NSString stringWithFormat:@"Failed to find %@ after %f seconds",element,timeout];
            [self recordFailureWithDescription:message inFile:file atLine:line expected:YES];
        }
        else {
            [element tap];
        }
    }];
}

@end
