//
//  GCDMethodViewController.m
//  了解-耗时操作
//
//  Created by fenggao on 2018/4/19.
//  Copyright © 2018年 com.zhonglu. All rights reserved.
//

#import "GCDMethodViewController.h"

@interface GCDMethodViewController ()

@end

@implementation GCDMethodViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

//快速迭代(遍历)
- (void)apply
{
    //串行执行 在当前线程中串行执行
    for (int i =0; i <10; ++i) {
        NSLog(@"%zd------%@",i,[NSThread currentThread]);
    }
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    /*参数说明
     *第一个参数   遍历的次数
     *第二个参数   队列
     *第三个参数   索引 相当于for循环里面的i
     
    */
    //会开启多条子线程 并发的执行任务
    //并不是都在子线程中执行 主线程也会参加
    //如果使用的队列是主队列 会发生死锁
    //如果是普通的串行队列 和for循环一样
    dispatch_apply(10, queue, ^(size_t i) {
         NSLog(@"%zd------%@",i,[NSThread currentThread]);
    });
}

- (void)test
{
    //获取文件夹的路径
    NSString *from = @"/Users/app/Desktop/icon-ios";
    NSString *to = @"/Users/app/Desktop/暂无视频";
    
    //获取文件夹下面的所有文件
    NSArray *subPaths = [[NSFileManager defaultManager] subpathsAtPath:from];
    NSLog(@"%@",subPaths);
    
    //遍历
    for (int i=0; i <subPaths.count; ++i) {
        
        //拼接文件的全路径
        NSString *fromFullPath = [from stringByAppendingPathComponent:[subPaths objectAtIndex:i]];
        
        NSString *toFullPath = [to stringByAppendingPathComponent:[subPaths objectAtIndex:i]];
        
        //执行文件的剪切操作
        /*参数说明
         *第一个参数   要剪切的文件在哪里
         *第二个参数   要剪切到什么地方去
         *第三个参数   错误信息
         */
        [[NSFileManager defaultManager] moveItemAtPath:fromFullPath toPath:toFullPath error:nil];
        NSLog(@"%@---%@---%@",fromFullPath,toFullPath,[NSThread currentThread]);
    }
}

- (void)test2
{
    //获取文件夹的路径
    NSString *from = @"/Users/app/Desktop/icon-ios";
    NSString *to = @"/Users/app/Desktop/暂无视频";
    
    //获取文件夹下面的所有文件
    NSArray *subPaths = [[NSFileManager defaultManager] subpathsAtPath:from];
    NSLog(@"%@",subPaths);
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_apply(subPaths.count, queue, ^(size_t i) {
       
        //拼接文件的全路径
        NSString *fromFullPath = [from stringByAppendingPathComponent:[subPaths objectAtIndex:i]];
        
        NSString *toFullPath = [to stringByAppendingPathComponent:[subPaths objectAtIndex:i]];
        
        [[NSFileManager defaultManager] moveItemAtPath:fromFullPath toPath:toFullPath error:nil];
        NSLog(@"%@---%@---%@",fromFullPath,toFullPath,[NSThread currentThread]);
    });
}
//栈拦
- (void)barrier
{
    //需求 有4个任务 要求开启多条线程来执行
    //增加需求 新的任务 要求在1 2 之后执行 要保证该任务执行完之后才能执行后面的3 4任务
    //栅栏函数 前面的任务并发执行 后面的任务也是并发执行
    //当前面的任务执行完毕之后执行栅栏函数中的任务 等改任务执行完毕后再执行后面的任务
    //警告: 不能使用全局并发队列 不会出现拦截功能
    //获取队列
    dispatch_queue_t queue = dispatch_queue_create("Test", DISPATCH_QUEUE_CONCURRENT);
    //封装任务 并且添加到队列
    dispatch_async(queue, ^{
        NSLog(@"1---%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"2---%@",[NSThread currentThread]);
    });
    
    dispatch_barrier_async(queue, ^{
       
        NSLog(@"++++++++");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"3---%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"4---%@",[NSThread currentThread]);
    });
}
@end



















