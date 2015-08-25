//
//  JMHomeModel.m
//  HomePlaces
//
//  Created by Fiseha Wondimu on 7/22/14.
//  Copyright (c) 2014 JoffreyMann. All rights reserved.
//

#define api_key @"8f4hsgmepwt6ybh4z2exefrr"

#import "ATMModel.h"

@interface ATMModel()
{
    NSMutableData *retrievedData;
}
@end

@implementation ATMModel

- (void)getItems
{
    NSString *urlString = @"https://m.chase.com/PSRWeb/location/list.action?lat=33.748995&lng=-84.387982";
    NSLog(@"%@", urlString);
    // Download the json file
    NSURL *jsonFileUrl = [NSURL URLWithString:urlString];
    // Create the request
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] init];
    //[urlRequest setHTTPMethod:@"GET"];
    [urlRequest setURL:jsonFileUrl];
    // Create the NSURLConnection
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    [self.delegate loadingOverlay];
}

#pragma mark NSURLConnectionDataProtocol Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // Initialize the data object
    retrievedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the newly downloaded data
    [retrievedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self.delegate itemsRetrieved:retrievedData];
    [self.delegate hideOverlay];
}

@end
