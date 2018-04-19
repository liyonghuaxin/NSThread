//
//  GCDGroupViewController.m
//  了解-耗时操作
//
//  Created by fenggao on 2018/4/19.
//  Copyright © 2018年 com.zhonglu. All rights reserved.
//

#import "GCDGroupViewController.h"

@interface GCDGroupViewController ()
@property (nonatomic,strong) UIImage *image1;
@property (nonatomic,strong) UIImage *image2;
@end

@implementation GCDGroupViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

- (void)test
{
    //需求 4个任务 在子线程中并发执行
    //添加一个任务“+++”,必须等所有的任务都执行完再执行 可以使用2个栈拦函数
    //添加需求 拦截多个队列中的任务 无法使用栈拦函数
    //获取并发队列
    dispatch_queue_t queue = dispatch_queue_create("Test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue1 = dispatch_queue_create("Test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue2 = dispatch_queue_create("Test", DISPATCH_QUEUE_CONCURRENT);
    //封装任务 并添加到队列中
    dispatch_async(queue, ^{
        
        NSLog(@"1---%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        
        NSLog(@"2---%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        
        NSLog(@"3---%@",[NSThread currentThread]);
    });
    dispatch_async(queue2, ^{
        
        NSLog(@"4---%@",[NSThread currentThread]);
    });
    dispatch_async(queue2, ^{
        
        NSLog(@"5---%@",[NSThread currentThread]);
    });
    
    //    dispatch_barrier_async(queue, ^{
    //
    //        NSLog(@"++++");
    //    });
}

- (void)group
{
    //创建队列组
    dispatch_group_t group dispatch_group_create();
    
    //获取并发队列
    dispatch_queue_t queue = dispatch_queue_create("Test", DISPATCH_QUEUE_CONCURRENT);
    
    
    //封装任务 并添加到队列中
    //监听任务的执行情况
    dispatch_group_async(group, queue, ^{
        
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"1---%@",[NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"2---%@",[NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"3---%@",[NSThread currentThread]);
    });
    
    //拦截通知 当所有的任务都执行完毕后 执行打印操作
    //必须等所有的任务都执行完毕才能执行
    //dispatch_group_notify 内部是异步执行
    dispatch_group_notify(group, queue, ^{
       
        NSLog(@"+++++");
    });
}

- (void)group2
{
    dispatch_group_t group dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("Test", DISPATCH_QUEUE_CONCURRENT);
    
   //在该方法后面的任务会被队列组监听
    //dispatch_group_enter dispatch_group_leave必须成对使用
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
         NSLog(@"1---%@",[NSThread currentThread]);
        //监听到该任务已经执行完毕
        dispatch_group_leave(group);
    });
    NSLog(@"------");
    
    dispatch_group_notify(group, queue, ^{
        
        NSLog(@"+++++");
    });
}

- (void)group3
{
    //需求 开子线程下载2张图片 合成图片 显示出来
    //1.需要开子线程 2.等待图片下载完成才能合成图片
    //创建队列组
    dispatch_group_t group = dispatch_group_create();
    //创建队列
    dispatch_group_t queue = dispatch_get_global_queue(0, 0);
    //下载图片1
    dispatch_group_async(group, queue, ^{
       
        NSURL *url = [NSURL URLWithString:@""];
        NSData *imageDate = [NSData dataWithContentsOfURL:url];
        self.image1 = [UIImage imageWithData:imageDate];
    });
    //下载图片2
    dispatch_group_async(group, queue, ^{
        
        NSURL *url = [NSURL URLWithString:@""];
        NSData *imageDate = [NSData dataWithContentsOfURL:url];
        self.image2 = [UIImage imageWithData:imageDate];
    });
    
    //拦截通知 合成图片
    dispatch_group_notify(group, queue, ^{
        
        //开启图形上下文
        UIGraphicsBeginImageContext(CGSizeMake(300, 300));
        //画图
        [self.image1 drawInRect:CGRectMake(0, 0, 150, 300)];
        [self.image2 drawInRect:CGRectMake(150, 0, 150, 300)];
        //根据上下文得到图片
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        //关闭上下文
        UIGraphicsEndImageContext();
        
        //显示图片
        dispatch_async(dispatch_get_main_queue(), ^{
           
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = image;
        });
    });
    
}

- (void)other
{
    //创建队列组
    dispatch_group_t group dispatch_group_create();
    
    //获取并发队列
    dispatch_queue_t queue = dispatch_queue_create("Test", DISPATCH_QUEUE_CONCURRENT)
    //以模块封装任务
    dispatch_group_async(group, queue, ^{
        NSLog(@"1---%@",[NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"2---%@",[NSThread currentThread]);
    });
   
    //封装任务(函数)
    //以函数封装任务
    dispatch_async_f(queue, NULL, run);
}

void run(void *str)
{
    NSLog(@"3---%@",[NSThread currentThread]);
}
@end
























