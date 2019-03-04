//
//  ViewController.m
//  Movements
//
//  Created by 李 on 2019/3/4.
//  Copyright © 2019年 Tanrui. All rights reserved.
//

#import "ViewController.h"
#import "MovementsView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"福彩3D走势图";
    
    NSString * plistPath = [[NSBundle mainBundle] pathForResource:@"PropertyList" ofType:@"plist"];
    
    NSArray * dataArray = [NSArray arrayWithContentsOfFile:plistPath];
    
    MovementsView * movenment = [[MovementsView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:movenment];
    
    movenment.dataArray = dataArray;
    
}


@end
