//
//  JMHomeModel.h
//  HomePlaces
//
//  Created by Fiseha Wondimu on 7/22/14.
//  Copyright (c) 2014 JoffreyMann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"

@protocol ATMModelDelegate <NSObject>

//- (void)itemsRetrieved:(NSArray *)items;

-(void)loadingOverlay;

-(void)hideOverlay;

- (void)itemsRetrieved:(NSData *)itemData;

@end

@interface ATMModel : NSObject<NSURLConnectionDataDelegate,NSURLConnectionDelegate>

@property (nonatomic, weak) id<ATMModelDelegate> delegate;

- (void)getItems;

@property (strong, nonatomic) Location *myLocation;

@end
