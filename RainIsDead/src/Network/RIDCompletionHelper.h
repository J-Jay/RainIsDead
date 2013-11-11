//
//  RIDCompletionHelper.h
//  RainIsDead
//
//  Created by Jean-Jacques Mérillon on 11/11/2013.
//  Copyright (c) 2013 Jean-Jacques Mérillon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RIDCompletionHelper : NSObject

-(void)placesWithInput:(NSString *)input completionHandler:(void (^)(NSArray *places, NSError* connectionError))completion;

@end
