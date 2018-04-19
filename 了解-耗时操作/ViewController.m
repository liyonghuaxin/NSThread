//
//  ViewController.m
//  了解-耗时操作
//
//  Created by fenggao on 2018/4/17.
//  Copyright © 2018年 com.zhonglu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取主线程
    NSThread *mainThread = [NSThread mainThread];
    NSLog(@"%@",mainThread);
    
    //获取当前线程 执行当前任务的线程
    NSThread *currentThread = [NSThread currentThread];
    NSLog(@"%@",currentThread);
    
    //常识 通常情况下.几乎所有的方法都在主线程中执行.除非人为创建
    
    //判断线程是否是主线程
    //1.打印 查看number ==1是主线程 否则是子线程
    //2.通过类方法判断
    BOOL isMain = [NSThread isMainThread];
    //3.通过对象方法判断
    NSLog(@"%zd",[currentThread isMainThread]);
    
    
}




@end
