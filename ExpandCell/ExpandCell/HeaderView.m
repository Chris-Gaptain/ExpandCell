//
//  HeaderView.m
//  ExpandCell
//
//  Created by peidong on 16/8/31.
//  Copyright © 2016年 wolf. All rights reserved.
//

#import "HeaderView.h"

@interface HeaderView ()

@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation HeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat w = [UIScreen mainScreen].bounds.size.width;
        
        self.arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"expanded"]];
        self.arrowImageView.frame = CGRectMake(10, (44 - 8) / 2, 15, 8);
        [self.contentView addSubview:self.arrowImageView];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(onExpand:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        button.frame = CGRectMake(0, 0, w, 44);
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, 200, 44)];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.titleLabel];
        self.contentView.backgroundColor = [UIColor redColor];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 44 - 0.5, w, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:line];
        
    }
    return self;
}

- (void)setModel:(SectionModel *)model {
    if (_model != model) {
        _model = model;
    }
    
    if (model.isExpanded) {
        self.arrowImageView.transform = CGAffineTransformIdentity;
    } else {
        self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
    }
    
    self.titleLabel.text = model.sectionTitle;
}

- (void)onExpand:(UIButton *)sender {
    self.model.isExpanded = !self.model.isExpanded;
    
    [UIView animateWithDuration:0.25 animations:^{
        if (self.model.isExpanded) {
            self.arrowImageView.transform = CGAffineTransformIdentity;
        } else {
            self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
        }
    }];
    
    if (self.expandCallback) {
        self.expandCallback(self.model.isExpanded);
    }
}


@end
