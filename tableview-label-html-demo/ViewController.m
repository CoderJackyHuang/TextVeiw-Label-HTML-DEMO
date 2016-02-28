//
//  ViewController.m
//  tableview-label-html-demo
//
//  Created by huangyibiao on 16/2/26.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "ViewController.h"
#import "HYBTestCell.h"
#import "HYBTestModel.h"
#import <UITableViewCell+HYBMasonryAutoCellHeight.h>

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UITableView *tableView = [[UITableView alloc] init];
  tableView.frame = self.view.bounds;
  tableView.delegate = self;
  tableView.dataSource = self;
  [self.view addSubview:tableView];
  
  NSString *html = @"<h1>关注我</h1><table> \
  <thead>  \
  <tr>  \
  <th>关注</th>  \
  <th>账号</th>  \
  <th>备注</th>  \
  </tr>  \
  </thead>  \
  <tbody>  \
  <tr>  \
  <td>Swift/ObjC技术群一</td>  \
  <td>324400294</td>  \
  <td>群一若已满，请申请群二</td>  \
  </tr>  \
  <tr>  \
  <td>Swift/ObjC技术群二</td>  \
  <td>494669518</td>  \
  <td>群二若已满，请申请群三</td>  \
  </tr>  \
  <tr> \
  <td>Swift/ObjC技术群三</td> \
  <td>461252383</td> \
  <td>群三若已满，会有提示信息</td> \
  </tr> \
  <tr> \
  <td>关注微信公众号</td> \
  <td>iOSDevShares</td> \
  <td>关注微信公众号，会定期地推送好文章</td> \
  </tr> \
  <tr> \
  <td>关注新浪微博账号</td> \
  <td><a href=\"http://weibo.com/u/5384637337\">标哥Jacky</a></td> \
  <td>关注微博，每次发布文章都会分享到新浪微博</td> \
  </tr> \
  <tr> \
  <td>关注标哥的GitHub</td> \
  <td><a href=\"https://github.com/CoderJackyHuang\">CoderJackyHuang</a></td> \
  <td>这里有很多的Demo和开源组件</td> \
  </tr> \
  <tr> \
  <td>关于我</td> \
  <td><a href=\"http://www.henishuo.com/about-biaoge/\">进一步了解标哥</a></td> \
  <td>如果觉得文章对您很有帮助，可捐助我！</td> \
  </tr> \
  </tbody> \
  </table> \
  <div class=\"postcopyright\" style=\"margin-top:30px;margin-bottom:30px;\"> \
  <strong>版权声明：</strong>本文为<a href=\"http://www.henishuo.com\">【标哥的技术博客】</a>原创出品，欢迎转载，转载时请注明出处！ \
  </div>";
  
  for (NSUInteger i = 0; i < 6; ++i) {
    HYBTestModel *model = [[HYBTestModel alloc] init];
    model.title = @"标哥的技术博客";
    model.desc = @"学习如何通过UILabel加载HTML以及如何通过UIWebView加载HTML并且动态在Cell上计算出UIWebView的实际高度";
    model.headImage = @"head";
    model.html = html;
    if (i % 2 != 0) {
//      model.webURL = @"http://www.henishuo.com/ios-interview-entrance/";
    }
    model.modelId = i + 1;
    
    [self.dataSource addObject:model];
  }
  
  [tableView reloadData];
}

- (NSMutableArray *)dataSource {
  if (_dataSource == nil) {
    _dataSource = [[NSMutableArray alloc] init];
  }
  
  return _dataSource;
}

#pragma mark - Delegate
#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  HYBTestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
  
  if (!cell) {
    cell = [[HYBTestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
  }
  
  if (indexPath.row < self.dataSource.count) {
    HYBTestModel *model = [self.dataSource objectAtIndex:indexPath.row];
    [cell configCellWithModel:model];
  }
  
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  HYBTestModel *model = [self.dataSource objectAtIndex:indexPath.row];
  CGFloat h = [HYBTestCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
    HYBTestCell *cell = (HYBTestCell *)sourceCell;
    [cell configCellWithModel:model];
  } cache:^NSDictionary *{
    NSDictionary *dict = @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%ld", model.modelId],
                           kHYBCacheForTableViewKey: tableView,
                           kHYBCacheStateKey: @"1",
                           kHYBRecalculateForStateKey:  @(NO)};
    return dict;
  }];
  return h;
}

@end
