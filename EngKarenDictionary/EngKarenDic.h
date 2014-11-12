//
//  EngKarenDic.h
//  EngKarenDictionary
//
//  Created by Ehkalu Moo on 11/11/14.
//  Copyright (c) 2014 Ehkalu Moo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EngKarenDic : NSObject
 {
    NSString *category;
    NSString *name;
}

@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *name;

+ (id)WordsOfCategory:(NSString*)category name:(NSString*)name;
@end
