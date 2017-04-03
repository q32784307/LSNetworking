//
//  RightViewController.m
//  Encapsulation
//
//  Created by 丶离人梦 on 2017/1/18.
//  Copyright © 2017年 漠然丶情到深处. All rights reserved.
//

#import "RightViewController.h"
#import "UserModel.h"
#import "Request.h"

@interface RightViewController ()<UITableViewDelegate, UITableViewDataSource, UserModelDelegate>

@property (nonatomic,strong) UITableView *RootTableView;
@property (nonatomic,strong) Request *req1;

@end

@implementation RightViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"数据请求";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    //网络请求的model类
    UserModel *model = [[UserModel alloc]init];
    model.delegate = self;
    [model getRequest];
    //存数据的model类
    
    [self.view addSubview:self.RootTableView];
}

- (void)Request:(NSDictionary *)req {
    self.req1 = [[Request alloc]init];
    [self.req1 setValuesForKeysWithDictionary:[req objectForKey:@"data"]];
    [self.RootTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PatientQueryListTableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"PatientQueryListTableViewCell"];
    }
    cell.selectionStyle = UITableViewCellAccessoryNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.row == 0) {
        cell.textLabel.text = self.req1.phone;
    }
    
    if (indexPath.row == 1) {
        cell.textLabel.text = self.req1.name;
    }
    
    if (indexPath.row == 2) {
        cell.textLabel.text = self.req1.idCard;
    }
    
    return cell;
}

- (UITableView *)RootTableView {
    if (!_RootTableView) {
        self.RootTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        self.RootTableView.delegate = self;
        self.RootTableView.dataSource = self;
    }
    return _RootTableView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
