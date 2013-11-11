//
//  RIDPlace.m
//  RainIsDead
//
//  Created by Jean-Jacques Mérillon on 11/11/2013.
//  Copyright (c) 2013 Jean-Jacques Mérillon. All rights reserved.
//

#import "RIDPlace.h"

@implementation RIDPlace

-(NSString *)description{
    return [NSString stringWithFormat:@"%@  %@ %@ %@ (pluie ? %@)", [super description], self.nom, self.indicatif, self.codePostal, self.couvertPluie?@"oui":@"non"];
}

@end
