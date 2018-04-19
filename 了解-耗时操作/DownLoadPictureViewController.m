//
//  DownLoadPictureViewController.m
//  了解-耗时操作
//
//  Created by fenggao on 2018/4/18.
//  Copyright © 2018年 com.zhonglu. All rights reserved.
//

#import "DownLoadPictureViewController.h"

@interface DownLoadPictureViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation DownLoadPictureViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [NSThread detachNewThreadSelector:@selector(download) toTarget:self withObject:nil];
}

- (void)download
{
    //确定url地址
    NSURL *url = [NSURL URLWithString:@""];
    
    //获取当前时间
    NSDate *start = [NSDate date];
    
    //把图片的二进制数据下载到本地
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    
    //获取当前时间
    NSDate *end = [NSDate date];
    NSLog(@"%f",[end timeIntervalSinceDate:start]);
    
    //把图片的二进制格式转换成image
    UIImage *image = [UIImage imageWithData:imageData];
    //显示图片
    //回到主线程 显示图片
    //waitUntilDone 是否等待改方法执行完毕才继续往下执行
    [self performSelectorOnMainThread:@selector(showImage:) withObject:image waitUntilDone:YES];
    //第二种方法
    [self performSelector:@selector(showImage:) onThread:[NSThread mainThread] withObject:image waitUntilDone:YES];
    
    //第三种方法 简便方法
    [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];
}

- (void)showImage:(UIImage *)image
{
   self.imageView.image = image;
}
- (void)timer
{
    CFTimeInterval start = CFAbsoluteTimeGetCurrent();//获取当前时间(相对时间)
    /* absolute time is the time interval since the reference date */
    /* the reference date (epoch) is 00:00:00 1 January 2001. */
    //相对于2001年的时间
    
   
}
@end
