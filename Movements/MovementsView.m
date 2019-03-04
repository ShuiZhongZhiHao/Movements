//
//  MovementsView.m
//  Movements
//
//  Created by 浩李 on 2019/3/4.
//  Copyright © 2019年 Tanrui. All rights reserved.
//

#import "MovementsView.h"
#import "MovenmentsTableViewCell.h"


#define  lineHeigh 30 //单元格高度


@interface MovementsView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIScrollView * scrollView;


@property(nonatomic,strong)UITableView * tableView;


/**
 需要绘制的点的坐标
 */
@property(nonatomic,strong)NSMutableArray * pointArray;

@property(nonatomic,strong)CAShapeLayer * shapeLayer;

@property(nonatomic,strong)CAShapeLayer * currentShapeLayer;

@property(nonatomic,strong)UIBezierPath * path;

@end


@implementation MovementsView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        [self addSubview:self.scrollView];
        
        
        self.tableView =[[UITableView alloc] initWithFrame:CGRectMake(0,0, self.frame.size.width, lineHeigh*32) style:UITableViewStylePlain];
        self.tableView.scrollEnabled  = NO;
        self.tableView.rowHeight = lineHeigh;
        self.tableView.separatorInset = UIEdgeInsetsMake(0, -5, 0, 0);
        self.tableView.separatorColor = [UIColor grayColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.scrollView addSubview:self.tableView];
    }
    return self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    MovenmentsTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell =[[MovenmentsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSDictionary * dictionary = self.dataArray[indexPath.row];
    cell.periodsLabel.text = [dictionary objectForKey:@"issueId"];
    NSArray * array = dictionary[@"lostInfo"];
    for (int i = 0; i<10; i++) {
        UIButton * button =[cell viewWithTag:100+i];
        if ([array[i] intValue] == 0) {
            
            CGRect rect1 = [button convertRect:button.frame fromView:cell.contentView];//获取button在contentView的位置
            CGRect rect2 = [button convertRect:rect1 toView:self.tableView];
            [self.pointArray addObject:NSStringFromCGPoint(CGPointMake(rect2.origin.x+(CGRectGetMaxX(button.frame)-CGRectGetMinX(button.frame))/2, indexPath.row*30+15))];
            NSLog(@"%@",NSStringFromCGRect(rect2));
            [button setTitle:array[i] forState:UIControlStateNormal];
            button.backgroundColor = kColorWithHex(0xff3434);
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            button.backgroundColor =[UIColor clearColor];
            [button setTitleColor:kColorWithHex(0x333333) forState:UIControlStateNormal];
            [button setTitle:[NSString stringWithFormat:@"%d",[array[i] intValue]] forState:UIControlStateNormal];
        }
    }
    if (indexPath.row%2 == 0) {
        cell.backgroundColor = kColorWithHex(0xf5f5f5);
    }
    else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    if (self.dataArray.count-1==indexPath.row) {
        
        [self drawLine];
    }
    return cell;
}
-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    self.scrollView.contentSize = CGSizeMake(kScreenWidth, _dataArray.count*30);
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, _dataArray.count*30);
    [self.tableView reloadData];
}
-(void)drawLine{
    
    if (self.pointArray.count<1) {
        return;
    }
    [self.path removeAllPoints];
    [self.path moveToPoint:CGPointFromString(self.pointArray.firstObject)];
    
    NSMutableArray * tempArray = [NSMutableArray arrayWithObjects:@(0),@(11), nil];
    for (int i=1; i<self.pointArray.count; i++) {
        
        CGPoint point = CGPointFromString(self.pointArray[i-1]);
        CGPoint point1 = CGPointFromString(self.pointArray[i]);
        CGFloat deltaX = point.x - point1.x;
        CGFloat deltaY = point.y - point1.y;
        CGFloat longDepth =  sqrt(deltaX*deltaX + deltaY*deltaY);
        [tempArray addObject:@(longDepth-21)];
        [tempArray addObject:@(21)];
        [self.path addLineToPoint:CGPointFromString(self.pointArray[i])];
    }
    // 4. 设置shapeLayer的路径  使球号区域为虚线
    self.shapeLayer.lineDashPattern = tempArray;
    // 4. 设置shapeLayer的路径
    self.shapeLayer.path = self.path.CGPath;
}
#pragma mark---------Lazy
-(UIBezierPath*)path{
    if (!_path) {
        _path = [UIBezierPath bezierPath];
    }
    return _path;
}
-(CAShapeLayer*)shapeLayer{
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        // 2. 设置ShapeLayer样式
        _shapeLayer.borderWidth = 2; // 线宽
        _shapeLayer.strokeColor = kColorWithHex(0xff3434).CGColor; // 线的颜色
        _shapeLayer.fillColor = [UIColor clearColor].CGColor; // 填充色
        // 3. 给画线的视图添加ShapeLayer
        [self.tableView.layer addSublayer:_shapeLayer];
    }
    return _shapeLayer;
}
-(NSMutableArray*)pointArray{
    if (!_pointArray) {
        _pointArray = [NSMutableArray array];
    }
    return _pointArray;
}
@end
