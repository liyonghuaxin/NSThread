//
//  GCDDownLoadViewController.m
//  了解-耗时操作
//
//  Created by fenggao on 2018/4/18.
//  Copyright © 2018年 com.zhonglu. All rights reserved.
//

#import "GCDDownLoadViewController.h"

@interface GCDDownLoadViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation GCDDownLoadViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //创建队列 串行队列 并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //封装下载图片的任务 并且添加到队列
    dispatch_async(queue, ^{
       
        //url
        NSURL *url = [NSURL URLWithString:@""];
        //下载图片的二进制数据到本地
        NSDate *imageData = [NSData dataWithContentsOfURL:url];
        //转换格式
        UIImage *image = [UIImage imageWithData:imageData];
        //第一个方法
        [image performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];
        //第二个方法
        dispatch_async(dispatch_get_main_queue(), ^{
           
            self.imageView.image = image;
        });
    });
}

@end
