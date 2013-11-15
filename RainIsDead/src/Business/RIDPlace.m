//
//  RIDPlace.m
//  RainIsDead
//
//  Created by Jean-Jacques Mérillon on 11/11/2013.
//  Copyright (c) 2013 Jean-Jacques Mérillon. All rights reserved.
//

#import "RIDPlace.h"

@interface  RIDPlace () <NSCoding>

@end


@implementation RIDPlace

-(NSString *)description{
    return [NSString stringWithFormat:@"%@  %@ %@ %@ (pluie ? %@)", [super description], self.nom, self.indicatif, self.codePostal, self.couvertPluie?@"oui":@"non"];
}

-(NSUInteger)hash{
    return [self.indicatif hash];
}

-(BOOL)isEqual:(id)object{
    if ([object isKindOfClass:[self class]]) {
        return [self.indicatif isEqualToString:((RIDPlace *)object).indicatif];
    }
    return NO;
}

+ (NSInteger)version{
    return 1;
}


- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.nom = [decoder decodeObjectForKey:@"nom"];
    self.indicatif = [decoder decodeObjectForKey:@"indicatif"];
    self.codePostal = [decoder decodeObjectForKey:@"codePostal"];
    self.couvertPluie = [decoder decodeBoolForKey:@"couvertPluie"];

    self.rainPeriods = nil;
    self.lastUpdate = 0;
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.nom forKey:@"nom"];
    [encoder encodeObject:self.indicatif forKey:@"indicatif"];
    [encoder encodeObject:self.codePostal forKey:@"codePostal"];
    [encoder encodeBool:self.couvertPluie forKey:@"couvertPluie"];
}


@end


