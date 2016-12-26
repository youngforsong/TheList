//
//  ViewController.m
//  NewList
//
//  Created by 杨松 on 2016/12/23.
//  Copyright © 2016年 杨松. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"
#import "ListModel.h"
#import "ListCell.h"
#import "AFNetworking.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    UITableView * _tableView;
    NSMutableArray * _dataArray;
    NSMutableArray *_ADArr;
    ListModel * _model;
    
    BOOL _isUp;//YES向上滑动,加载  NO下拉,刷新
    
}


@end

@implementation ViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_tableView.mj_header beginRefreshing];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _isUp=NO;
    
    [self downloadData];
    [self initUI];
   
  
   
}
-(void)initData
{
    _dataArray =[[NSMutableArray alloc]init];
    _isUp=NO;
    
}
-(void)initUI
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.estimatedRowHeight = 80; //估计一个高度
    _tableView.rowHeight = UITableViewAutomaticDimension; // 自适应单元格高度
    
    [self.view addSubview:_tableView];
    // 注册cell
    [_tableView registerNib:[UINib nibWithNibName:@"ListCell" bundle:nil] forCellReuseIdentifier:@"ListCell"];
    [self addHeaderAndFooterRefresh];
    
}
#pragma mark 刷新

-(void)addHeaderAndFooterRefresh{
    
    _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //下拉
        _isUp=NO;
        [self downloadData];
        
    }];
    [_tableView.mj_header beginRefreshing];
    _tableView.mj_footer=[MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
        _isUp=YES;
        [self downloadData];
        
    }];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    ListModel * model = _dataArray[indexPath.row];

    [cell refreshNewsCellWithModel:model];
    return cell;
    
    
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    ListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell"];
//    
//    return cell.cellHeight;
//}
#pragma 数据
-(void)downloadData
{
    NSString * urlStr=@"http://thoughtworks-ios.herokuapp.com/facts.json";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"请求成功");
        NSArray * resultArr = [responseObject objectForKey:@"rows"];
       

         _dataArray =[[NSMutableArray alloc]init];
        for (NSDictionary*videoDic in resultArr) {
            ListModel * model=[ListModel parseModelWithDic:videoDic];
            model.title= videoDic[@"title"];
            model.dis =videoDic[@"description"];
            model._image_url =videoDic[@"imageHref"];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"请求失败");
    }];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
