
//
//  TypeView.m
//  AddShoppingCart
//
//  Created by 主用户 on 16/3/23.
//  Copyright © 2016年 江萧. All rights reserved.
//

#import "TypeView.h"
#import "Header.h"
@implementation TypeView
{
    int selectIndex;
    NSArray *typeArray;
}

-(void)initWithDatasource:(NSArray *)arr typeName:(NSString *)typeName selecteIndex:(int)index
{
    while ([self.subviews lastObject] != nil)
    {
        [[self.subviews lastObject] removeFromSuperview];
    }
        selectIndex = index;
        typeArray = arr;
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
        lab.text = typeName;
        lab.textColor = [UIColor blackColor];
        lab.font = [UIFont systemFontOfSize:14];
        [self addSubview:lab];
        float upX = 10;
        float upY = 40;
        for (int i = 0; i<arr.count; i++) {
            UIButton *btn= [JXUIKit buttonWithBackgroundColor:KLightGrayLinecol titleColorForNormal:[UIColor blackColor] titleForNormal:[arr objectAtIndex:i] titleForSelete:[arr objectAtIndex:i] titleColorForSelete:WhiteColor fontSize:13 font:nil];
            NSDictionary *dic = [NSDictionary dictionaryWithObject:btn.titleLabel.font forKey:NSFontAttributeName];
            CGSize size = [@"ddd" sizeWithAttributes:dic];
            //NSLog(@"%f",size.height);
            //20是左右边距各10，size.width+30是按钮宽度，间隔为10，通过计算x的位置判断是否换行显示按钮
            if ( upX > (self.frame.size.width-20 -size.width-40)) {
                upX = 10;
                upY += 30;
            }
            btn.frame = CGRectMake(upX, upY, size.width+30,24);
            [JXUIKit ViewcornerRadius:12 andColor:WhiteColor andWidth:0 :btn];
            [self addSubview:btn];
            btn.tag = 100+i;
            [btn addTarget:self action:@selector(touchbtn:) forControlEvents:UIControlEventTouchUpInside];
            upX+=size.width+40;
            
            if (selectIndex == i) {
                btn.selected = YES;
                btn.backgroundColor = KBtncol;
            }
        }
        
        upY +=30;
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, upY+10, self.frame.size.width, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
        
        self.height = upY+11;
    
}
-(void)touchbtn:(UIButton *)btn
{
    
    if (btn.selected == NO) {
        selectIndex = (int)btn.tag-100;
    }else
    {
        //取消选中
        selectIndex = -1;
    }
    if (self.selectButton) {
        self.selectButton(selectIndex);
    }
    for (int i = 0; i<typeArray.count; i++) {
        UIButton *button =(UIButton *)[self viewWithTag:100+i];
        button.selected = NO;
        [button setBackgroundColor:KLightGrayLinecol];
        //根据seletIndex 确定用户当前点了那个按钮
        if (selectIndex == i) {
            button.selected = YES;
            button.backgroundColor = KBtncol;
        }
    }
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
