//
//  MovenmentsTableViewCell.m
//  Movements
//
//  Created by 浩李 on 2019/3/4.
//  Copyright © 2019年 Tanrui. All rights reserved.
//

#import "MovenmentsTableViewCell.h"

@implementation MovenmentsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
 
        
        self.periodsLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        self.periodsLabel.font =[UIFont systemFontOfSize:12.0];
        self.periodsLabel.textAlignment = NSTextAlignmentCenter;
        self.periodsLabel.text = @"2013123412期";
        self.periodsLabel.textColor = [UIColor blackColor];
        [self addSubview:self.periodsLabel];
        
        
        CGFloat width = (kScreenWidth-100)/10;
        
        for (int i = 0; i<10; i++) {
            UIButton * button =[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.periodsLabel.frame)+i*width, 30/2-10, 21, 21)];
            button.titleLabel.font =[UIFont systemFontOfSize:10.0];
            button.layer.cornerRadius = 10;
            button.tag = 100+i;
            [self addSubview:button];
            
            UILabel * markLineLabel =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(button.frame)-22-(width-20)/4, 0, 0.5, 30)];
            markLineLabel.backgroundColor = kColorWithHex(0xf5f5f5);
            [self addSubview:markLineLabel];
            
        }
        
    }
    return self;
}
@end
