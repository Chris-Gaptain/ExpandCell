//
//  SectionModel.h
//  ExpandCell
//
//  Created by peidong on 16/8/31.
//  Copyright © 2016年 wolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SectionModel : NSObject

// 是否展开
@property (nonatomic, assign) BOOL isExpanded;

@property (nonatomic, copy) NSString *sectionTitle;

@property (nonatomic, strong) NSMutableArray *cellModels;

@end
