//
//  HeaderView.h
//  ExpandCell
//
//  Created by peidong on 16/8/31.
//  Copyright © 2016年 wolf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SectionModel.h"

typedef void(^HeaderViewExpandCallback)(BOOL isExpanded);

@interface HeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) SectionModel *model;

@property (nonatomic, copy) HeaderViewExpandCallback expandCallback;

@end
