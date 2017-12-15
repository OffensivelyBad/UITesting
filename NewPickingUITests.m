//
//  NewPickingUITests.m
//  QAUITests
//
//  Created by Shawn Roller on 12/15/17.
//

#import "NewPickingUITests.h"
#import "constants.h"

@implementation NewPickingUITests

#pragma mark - Test functions

- (void)testPicksMatchAfterUnassigning {
    /* Preconditions:
     Run on iPhone device (new pick tool is not available on iPad)
     Assumes no picks are assigned to the user
     Assumes Pick Types menu has these 3 levels of menus, ex. Web Orders -> LPN -> Multis
     Assumes a pick will be assigned
     */
    
    // Tap into the side menu
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [[[[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeButton].element tap];
    
    // Select the new Pick tool
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery.staticTexts[@"Outbound"];
     [tablesQuery.staticTexts[@"Pick (New)"];
    
    // Wait for the Pick Types modal to appear
    XCUIElement *pickTypesModal = app.staticTexts[@"Pick Types"];
    [self waitForElementToAppear:pickTypesModal withTimeout:60];
    
    // Select the first pick type
    [tablesQuery.cells.firstMatch tap];
    [tablesQuery.cells.firstMatch tap];
    [tablesQuery.cells.firstMatch tap];
    
    // Wait for the Pick card to appear and get the LPN
    XCUIElement *pickLabel = app.staticTexts[PICKING_LPN_LABEL];
    [self waitForElementToAppear:pickLabel withTimeout:20];
    NSString *firstLPN = app.staticTexts[PICKING_LPN_LABEL].label;
    
    // Open a different tool
    [[[[[[[[[[[[[XCUIApplication alloc] init] childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeButton] elementBoundByIndex:0] tap];
    [tablesQuery.staticTexts[@"Inbound"] tap];
    [tablesQuery.staticTexts[@"ASN Receive"] tap];
    
    // Reopen the Pick tool
    [[[[[[[[[[[[[XCUIApplication alloc] init] childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeButton] elementBoundByIndex:0] tap];
    [tablesQuery.staticTexts[@"Outbound"] tap];
    [tablesQuery.staticTexts[@"Pick (New)"] tap];
    
    // Wait for the pick to be loaded
    [self waitForElementToAppear:pickLabel withTimeout:20];
    NSString *newLPN = app.staticTexts[PICKING_LPN_LABEL].label;
    
    // Unassign picks
    [[[[[[[[[[[[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:4] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeButton] elementBoundByIndex:0] tap];
    [app.sheets[@"Options"].collectionViews.buttons[@"Done Picking"] tap];
    [app.alerts[@"Done Picking"].collectionViews.buttons[@"Done Picking"] tap];
    
    // Ensure the new LPN matches the one that was previously assigned
    XCTAssertTrue([firstLPN isEqualToString:newLPN]);
    
    // Ensure the tap to select picks button appears
    XCUIElement *tapToSelectPicksButton = app.staticTexts[@"Tap Here to select Pick Types"];
    XCTAssert(tapToSelectPicksButton.exists);
}

- (void)testUnassigningPicks {
    /* Preconditions:
     Run on iPhone device (new pick tool is not available on iPad)
     Assumes no picks are assigned to the user
     Assumes Pick Types menu has these 3 levels of menus, ex. Web Orders -> LPN -> Multis
     Assumes a pick will be assigned
     */
    
    // Tap into the side menu
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [[[[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeButton].element tap];
    
    // Select the new Pick tool
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery.staticTexts[@"Outbound"];
     [tablesQuery.staticTexts[@"Pick (New)"];
    
    // Wait for the Pick Types modal to appear
    XCUIElement *pickTypesModal = app.staticTexts[@"Pick Types"];
    [self waitForElementToAppear:pickTypesModal withTimeout:60];
    
    // Select a pick type
    [tablesQuery.cells.firstMatch tap];
    [tablesQuery.cells.firstMatch tap];
    [tablesQuery.cells.firstMatch tap];
    
    // Wait for the Pick card to appear and get the LPN
    XCUIElement *pickLabel = app.staticTexts[PICKING_LPN_LABEL];
    [self waitForElementToAppear:pickLabel withTimeout:20];
    
    // Unassign picks
    [[[[[[[[[[[[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:4] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeButton] elementBoundByIndex:0] tap];
    [app.sheets[@"Options"].collectionViews.buttons[@"Done Picking"] tap];
    [app.alerts[@"Done Picking"].collectionViews.buttons[@"Done Picking"] tap];
    
    // Wait for the tap picks button appears
    XCUIElement *tapToSelectPicksButton = app.staticTexts[@"Tap Here to select Pick Types"];
    [self waitForElementToAppear:tapToSelectPicksButton withTimeout:60];
    
    // Wait for the menubutton to be hittable and open a new tool
    XCUIElement *menuButton = [[[[[[[[[[[[XCUIApplication alloc] init] childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeButton] elementBoundByIndex:0];
    [self waitForButtonElementToAppear:menuButton withTimeout:60];
    [tablesQuery.staticTexts[@"Inbound"] tap];
    [tablesQuery.staticTexts[@"ASN Receive"] tap];
    
    // Reopen the Pick tool
    [[[[[[[[[[[[[XCUIApplication alloc] init] childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeButton] elementBoundByIndex:0] tap];
    [tablesQuery.staticTexts[@"Outbound"] tap];
    [tablesQuery.staticTexts[@"Pick (New)"] tap];
    
    // Wait for the pick modal to reappear, confirming that we have no picks assigned
    [self waitForElementToAppear:pickTypesModal withTimeout:60];
    
}

@end
