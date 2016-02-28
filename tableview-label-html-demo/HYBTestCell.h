//
//  HYBTestCell.h
//  tableview-label-html-demo
//
//  Created by huangyibiao on 16/2/26.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class HYBTestModel;

@interface HYBTestCell : UITableViewCell

- (void)configCellWithModel:(HYBTestModel *)model;

@end
