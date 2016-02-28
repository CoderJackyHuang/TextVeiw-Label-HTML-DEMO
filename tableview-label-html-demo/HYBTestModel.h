//
//  HYBTestModel.h
//  tableview-label-html-demo
//
//  Created by huangyibiao on 16/2/26.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HYBTestModel : NSObject

@property (nonatomic, assign) long modelId;
@property (nonatomic, copy) NSString *headImage;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *html;
@property (nonatomic, copy) NSString *webURL;

@end
