//
//  RIDPlace.h
//  RainIsDead
//
//  Created by Jean-Jacques Mérillon on 11/11/2013.
//  Copyright (c) 2013 Jean-Jacques Mérillon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RIDPlace : NSObject

@property (nonatomic, strong) NSString *indicatif;
@property (nonatomic, strong) NSString *nom;
@property (nonatomic, strong) NSString *codePostal;
@property (nonatomic, assign) BOOL couvertPluie;
@property (nonatomic, strong) NSArray *rainPeriods;

@end
