//
//  GCDViewController.m
//  了解-耗时操作
//
//  Created by fenggao on 2018/4/18.
//  Copyright © 2018年 com.zhonglu. All rights reserved.
//

#import "GCDViewController.h"

@interface GCDViewController ()

@end

@implementation GCDViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

//异步函数 并发队列 会开多条子线程 线程并发执行
//注意: 开几条线程并不是由任务的数量决定的,是由GCD内部自动决定
- (void)asyncConcurrent
{
    //创建队列
    /*
     参数说明
     *第一个参数  C语言字符串 给队列起个名字 (建议:com.公司域名反写)
     *第二个参数  类型 DISPATCH_QUEUE_CONCURRENT 并发队列
                    DISPATCH_QUEUE_SERIAL      串行队列
     */
    dispatch_queue_t queue = dispatch_queue_create("com.520it.www.downloadQueue", DISPATCH_QUEUE_CONCURRENT);
    
    //封装任务 把任务添加到队列
    dispatch_async(queue, ^{
       
        NSLog(@"1-------%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        
        NSLog(@"2-------%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        
        NSLog(@"3-------%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        
        NSLog(@"4-------%@",[NSThread currentThread]);
    });
}

//异步函数 + 串行队列  会开启一条子线程.所有的任务在该子线程中串行执行
-(void)asyncSerial
{
    //创建队列
    /*
     参数说明
     *第一个参数  C语言字符串 给队列起个名字 (建议:com.公司域名反写)
     *第二个参数  类型 DISPATCH_QUEUE_CONCURRENT 并发队列
     DISPATCH_QUEUE_SERIAL      串行队列
     */
    dispatch_queue_t queue = dispatch_queue_create("com.520it.www.downloadQueue", DISPATCH_QUEUE_SERIAL);
    
    //封装任务 把任务添加到队列
    dispatch_async(queue, ^{
        
        NSLog(@"1-------%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        
        NSLog(@"2-------%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        
        NSLog(@"3-------%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        
        NSLog(@"4-------%@",[NSThread currentThread]);
    });
}

//同步函数 + 并发队列   不会开启子线程 所有的任务都在当前线程中串行知悉
- (void)syncConcurrent
{
    //创建队列
    /*
     参数说明
     *第一个参数  C语言字符串 给队列起个名字 (建议:com.公司域名反写)
     *第二个参数  类型 DISPATCH_QUEUE_CONCURRENT 并发队列
     DISPATCH_QUEUE_SERIAL      串行队列
     */
    dispatch_queue_t queue = dispatch_queue_create("com.520it.www.downloadQueue", DISPATCH_QUEUE_CONCURRENT);
    
    //封装任务 把任务添加到队列
    dispatch_sync(queue, ^{
        
        NSLog(@"1-------%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        
        NSLog(@"2-------%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        
        NSLog(@"3-------%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        
        NSLog(@"4-------%@",[NSThread currentThread]);
    });
}

//同步函数 + 串行队列  不会开启线程 所有的任务都在当前线程中串行执行
-(void)syncSerial
{
    //创建队列
    /*
     参数说明
     *第一个参数  C语言字符串 给队列起个名字 (建议:com.公司域名反写)
     *第二个参数  类型 DISPATCH_QUEUE_CONCURRENT 并发队列
     DISPATCH_QUEUE_SERIAL      串行队列
     */
    dispatch_queue_t queue = dispatch_queue_create("com.520it.www.downloadQueue", DISPATCH_QUEUE_SERIAL);
    
    //封装任务 把任务添加到队列
    dispatch_sync(queue, ^{
        
        NSLog(@"1-------%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        
        NSLog(@"2-------%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        
        NSLog(@"3-------%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        
        NSLog(@"4-------%@",[NSThread currentThread]);
    });
    
    
}

//异步函数 +主队列  不会开启线程 所有的任务都在主线程中串行执行
-(void)asyncMain
{
    //获取主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    //封装任务 把队列放到队列中
    dispatch_async(queue, ^{
        
        NSLog(@"1-------%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        
        NSLog(@"2-------%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        
        NSLog(@"3-------%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        
        NSLog(@"4-------%@",[NSThread currentThread]);
    });
}


//同步函数 +主队列  不会开启线程 死锁
-(void)syncMain
{
    //获取主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    //封装任务 把队列放到队列中
    dispatch_sync(queue, ^{
        
        NSLog(@"1-------%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        
        NSLog(@"2-------%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        
        NSLog(@"3-------%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        
        NSLog(@"4-------%@",[NSThread currentThread]);
    });
}









@end
