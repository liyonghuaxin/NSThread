//
//  NhreadViewController.m
//  了解-耗时操作
//
//  Created by fenggao on 2018/4/17.
//  Copyright © 2018年 com.zhonglu. All rights reserved.
//

#import "NhreadViewController.h"

@interface NhreadViewController ()

@end

@implementation NhreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //线程创建的方法
    //@ 直接alloc     initWith         代码量大|能够拿到线程对象
    //@ 分离出子线程   detachNewThread  无法拿到线程对象进行详细设置
    //@ 开启后台线程   InBackground     无法拿到线程对象进行详细设置
    
    //设置线程属性
    //thread.name = @"线程";
    //设置线程的优先级  范围0.0-1.0,1.0优先级最高,默认是0.5
    //优先级更高的线程被CPU调度到的概率会更高
    //thread.threadPriority
    
    //线程的生命周期 从创建到释放的过程
    //在线程内部的任务执行完毕的时候,线程对象就会释放
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 创建线程对象
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run:) object:@"11"];
    //开启线程
    [thread start];
}

- (void)createThread2
{
    //直接分离出一条子线程
    [NSThread detachNewThreadSelector:@selector(run:) toTarget:self withObject:@"11"];
}

- (void)createThread3
{
    //开启后台线程
    [self performSelectorInBackground:@selector(run:) withObject:@"11"];
}

- (void)run:(NSString *str)
{
    
}
@end
