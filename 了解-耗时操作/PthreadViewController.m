//
//  PthreadViewController.m
//  了解-耗时操作
//
//  Created by fenggao on 2018/4/17.
//  Copyright © 2018年 com.zhonglu. All rights reserved.
//

#import "PthreadViewController.h"
#import <pthread.h>
@interface PthreadViewController ()

@end

@implementation PthreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1 包含头文件
    //2 创建线程对象
    pthread_t thread = nil;
    //3 创建线程
    /* 参数说明
     *
     *第一个参数 线程对象 传地址
     *第二个参数 线程属性（优先级之类的）
     *第三个参数 指向函数的指针
     *第四个参数 传给第三个参数的(参数)
    */
    pthread_create(&thread, NULL, run, NULL);
}

//技巧 第一个圆括号(*)改写成函数名称
void *run(void *str)
{
    NSLog(@"%@",[NSThread currentThread]);
    return NNULL;
}
@end
