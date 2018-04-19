//
//  GCDUseViewController.m
//  了解-耗时操作
//
//  Created by fenggao on 2018/4/18.
//  Copyright © 2018年 com.zhonglu. All rights reserved.
//

#import "GCDUseViewController.h"

@interface GCDUseViewController ()

@end

@implementation GCDUseViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

//一次性代码 整个程序过程中只会执行一次 是线程安全
-(void)once
{
    //内部实现原理 判断onceToken的值 ==0 来决定是否执行block中的任务
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    });
}
//延迟执行
-(void)delay
{
    //延迟执行
    [self performSelector:@selector(run) withObject:nil afterDelay:2.0];
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    
    //GCD延迟执行
    /*
     参数说明
     *第一个参数 设置时间(GCD中的时间单位是纳秒)
     *第二个参数 队列 (决定block中的任务在哪个线程中执行.如果是主队列就是主线程,否则就是在子线程)
     *第三个参数 设置任务
     */
    /*
     原理
     先等2秒 再把任务提交到队列
     */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //设置任务
    });
}
@end
















