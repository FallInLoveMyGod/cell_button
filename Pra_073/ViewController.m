//
//  ViewController.m
//  Pra_073
//
//  Created by 田耀琦 on 2017/7/4.
//  Copyright © 2017年 田耀琦. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *mytable;

@property (nonatomic,strong)UIView *accessoryView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    self.mytable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 350, 600) style:UITableViewStyleGrouped];
    self.mytable.backgroundColor = [UIColor redColor];
    self.mytable.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    self.mytable.delegate = self;
    self.mytable.dataSource = self;
    [self.view addSubview:self.mytable];
}
/*
- (UITableView *)mytable {
    if (!_mytable) {
        _mytable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 350, 600) style:UITableViewStyleGrouped];
        _mytable.backgroundColor = [UIColor redColor];
        _mytable.delegate = self;
        _mytable.dataSource = self;
    }
    return _mytable;
}
 */

- (UIView *)accessoryView {
    
    _accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30 * 3, 30)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 30, 30)];
    [btn setBackgroundColor:[UIColor redColor]];
    btn.tag = 100;
    [btn addTarget:self action:@selector(btnAction:event:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setFrame:CGRectMake(30, 0, 30, 30)];
    [btn1 setBackgroundColor:[UIColor blueColor]];
    [btn1 addTarget:self action:@selector(btnAction:event:) forControlEvents:UIControlEventTouchUpInside];
    btn1.tag = 101;
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setFrame:CGRectMake(60, 0, 30, 30)];
    [btn2 setBackgroundColor:[UIColor magentaColor]];
    [btn2 addTarget:self action:@selector(btnAction:event:) forControlEvents:UIControlEventTouchUpInside];
    btn2.tag = 102;
    
    [_accessoryView addSubview:btn];
    [_accessoryView addSubview:btn1];
    [_accessoryView addSubview:btn2];
    
    return _accessoryView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identify = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
        cell.accessoryView = [self accessoryView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    cell.textLabel.text = [NSString stringWithFormat:@"num: %ld",indexPath.row];
    cell.backgroundColor = [UIColor greenColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)btnAction:(id)btn event:(UIEvent *)event {
    UIButton *temp = btn;
    NSIndexPath *indexpath = [self indexPathForSender:btn event:event];
    UITableViewCell *cell = [self.mytable cellForRowAtIndexPath:indexpath];
    switch (temp.tag) {
        case 100:
            cell.backgroundColor = [UIColor purpleColor];
            break;
        case 101:
            cell.backgroundColor = [UIColor whiteColor];
            break;
        case 102:
            cell.backgroundColor = [UIColor cyanColor];
            break;
            
        default:
            break;
    }
}

- (NSIndexPath *)indexPathForSender:(id)sender event:(UIEvent *)event {
    UIButton *button = (UIButton*)sender;
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if (![button pointInside:[touch locationInView:button] withEvent:event])
    {
        return nil;
    }
    
    CGPoint touchPosition = [touch locationInView:self.mytable];
    
    return [self.mytable indexPathForRowAtPoint:touchPosition];
}


@end
