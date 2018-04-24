//
//  issue339Tests.m
//  issue339Tests
//
//  Created by Tomer Shalom on 24/04/2018.
//  Copyright © 2018 Autodesk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "ADMyEntity.h"

@interface issue339Tests : XCTestCase

@end

@implementation issue339Tests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)test_issue339_fix {

    // Create NSManagedObjectModel mock
    NSString *testingTargetBundlePath = [[NSBundle bundleForClass:[ADMyEntity class]] bundlePath];
    
    NSBundle* s_resourceBundle = [NSBundle bundleWithPath:testingTargetBundlePath];
    
    NSManagedObjectModel *mom = [NSManagedObjectModel mergedModelFromBundles:[NSArray arrayWithObjects:s_resourceBundle, nil]];
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    
    [psc addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:NULL];
    
    NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    moc.persistentStoreCoordinator = psc;
    
    // Create managed object mock
    ADMyEntity* entity = [NSEntityDescription insertNewObjectForEntityForName:@"MyEntity" inManagedObjectContext:moc];
    
    // Crash here
    id mockEntity = OCMPartialMock(entity);

    // Verify
    XCTAssertTrue(mockEntity != nil);
}

@end
