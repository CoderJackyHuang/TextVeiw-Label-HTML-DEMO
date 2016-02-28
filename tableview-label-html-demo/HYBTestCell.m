//
//  HYBTestCell.m
//  tableview-label-html-demo
//
//  Created by huangyibiao on 16/2/26.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBTestCell.h"
#import <UITableViewCell+HYBMasonryAutoCellHeight.h>
#import <Masonry.h>
#import "HYBTestModel.h"

@interface HYBTestCell ()

@property (nonatomic, strong) UILabel   *htmlLabel;
@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UILabel   *titleLabel;
@property (nonatomic, strong) UILabel   *descLabel;

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, weak) HYBTestModel *model;

@end

@implementation HYBTestCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    self.headImageView = [[UIImageView alloc] init];
    self.headImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.top.mas_equalTo(10);
      make.width.height.mas_equalTo(80);
    }];
    
    // title
    self.titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.preferredMaxLayoutWidth = screenWidth - 90 - 20;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    __weak __typeof(self) weakSelf = self;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(weakSelf.headImageView.mas_right).offset(10);
      make.top.mas_equalTo(weakSelf.headImageView);
      make.right.mas_equalTo(-10);
    }];
    
    // desc
    self.descLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.descLabel];
    self.descLabel.preferredMaxLayoutWidth = screenWidth - 90 - 20;
    self.descLabel.numberOfLines = 0;
    self.descLabel.font = [UIFont systemFontOfSize:13];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.right.mas_equalTo(weakSelf.titleLabel);
      make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).offset(10);
    }];
  
    // HTML Label
    self.htmlLabel = [[UILabel alloc] init];
    self.htmlLabel.numberOfLines = 0;
    self.htmlLabel.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:self.htmlLabel];
    self.htmlLabel.preferredMaxLayoutWidth = screenWidth - 20;
    self.htmlLabel.font = [UIFont systemFontOfSize:13];
    [self.htmlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.right.mas_equalTo(weakSelf.descLabel);
      make.top.mas_equalTo(weakSelf.descLabel.mas_bottom).offset(20);
    }];
    
    self.textView = [[UITextView alloc] init];
    [self.contentView addSubview:self.textView];
    self.textView.backgroundColor = [UIColor blueColor];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.right.mas_equalTo(weakSelf.htmlLabel);
      make.top.mas_equalTo(weakSelf.htmlLabel.mas_bottom).offset(20);
    }];
 
    self.hyb_lastViewInCell = self.textView;
    self.hyb_bottomOffsetToCell = 10;
  }
  
  return self;
}

- (void)configCellWithModel:(HYBTestModel *)model {
  if (model == nil) {
    return;
  }
  
  self.model = model;
  
  self.titleLabel.text = model.title;
  self.descLabel.text = model.desc;
  self.headImageView.image = [UIImage imageNamed:model.headImage];
  
  if (model.html.length > 0) {
    // ios 7.0以后才能使用
    NSData *data = [model.html dataUsingEncoding:NSUnicodeStringEncoding];
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
    NSAttributedString *html = [[NSAttributedString alloc] initWithData:data
                                                                options:options
                                                     documentAttributes:nil
                                                                  error:nil];
    self.htmlLabel.attributedText = html;
    self.textView.attributedText = html;
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
      make.height.mas_equalTo([self.textView sizeThatFits:CGSizeMake(screenWidth - 20, CGFLOAT_MAX)].height);
    }];
  }
}

@end
