//
//  EngKarenDic.m
//  EngKarenDictionary
//
//  Created by Ehkalu Moo on 11/11/14.
//  Copyright (c) 2014 Ehkalu Moo. All rights reserved.
//

#import "EngKarenDic.h"

@implementation EngKarenDic
@synthesize category;
@synthesize name;

+ (id)WordsOfCategory:(NSString *)category name:(NSString *)name
{
    EngKarenDic *newWords = [[self alloc] init];
    newWords.category = category;
    newWords.name = name;
    return newWords;
}
@end
