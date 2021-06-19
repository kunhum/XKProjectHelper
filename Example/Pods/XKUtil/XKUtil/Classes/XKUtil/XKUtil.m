//
//  XKUtil.m
//  MBB
//
//  Created by Nicholas on 2018/12/22.
//  Copyright © 2018 Nicholas. All rights reserved.
//

#import "XKUtil.h"

@implementation XKUtil

#pragma mark 打电话
+ (void)xk_Phone:(NSString *)phoneNumber {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *phone = [NSString stringWithFormat:@"telprompt://%@",phoneNumber];
        NSURL *phoneURL = [NSURL URLWithString:phone];
        [[UIApplication sharedApplication] openURL:phoneURL];
    });
}

#pragma mark 倒计时计算时分秒
+ (void)xk_calculateTime:(NSTimeInterval)timeInterval completed:(nonnull void (^)(NSInteger, NSInteger, NSInteger))completed {
    
    if (timeInterval > 0) {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        NSDate *currentDate = [NSDate date];
        NSDateComponents *components = [calendar components:(NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond) fromDate:currentDate toDate:date options:0];
        !completed ?: completed(components.hour, components.minute, components.second);
    }
    
    
}

#pragma mark 计时器
+ (dispatch_source_t)xk_setTimerWithQueue:(dispatch_queue_t)queue seconds:(double)seconds interval:(NSTimeInterval)interval leeway:(NSTimeInterval)leeway countingHandler:(void (^ _Nullable)(CGFloat))countingHandler cancelHandler:(void (^ _Nullable)(void))cancelHandler {
    
    __block double countingSeconds = seconds;
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, interval * NSEC_PER_SEC, leeway * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (--countingSeconds > 0) {
            !countingHandler ?: countingHandler(countingSeconds);
        }
        else {
            dispatch_cancel(timer);
        }
    });
    dispatch_source_set_cancel_handler(timer, ^{
        !cancelHandler ?: cancelHandler();
    });
    dispatch_resume(timer);
    
    return timer;
}

//MARK: 获取APP缓存
+ (NSString *)xk_appCacheSize {
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject;
    path = [path stringByAppendingPathComponent:@"Caches"];
    long long size = [self folderSizeAtPath:path];
    if (size < 1000.0) {
        return [NSString stringWithFormat:@"%lldB", size];
    }
    long long realSize = size / 1000.0 / 1000.0;
    if (realSize >= 1.0) {
        return [NSString stringWithFormat:@"%lldM", realSize];
    }
    else {
        return [NSString stringWithFormat:@"%fKB", size / 1000.0];
    }
}

//MARK: 单个文件大小
+ (long long)fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
//MARK: 遍历文件夹获得文件夹大小，返回字节
+ (long long)folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath])
        return 0;
    NSString* fileName = [folderPath copy];
    long long folderSize = 0;
   
    BOOL isdir;
    [manager fileExistsAtPath:fileName isDirectory:&isdir];
    if (isdir != YES) {
        return [self fileSizeAtPath:fileName];
    }
    else {
        NSArray * items = [manager contentsOfDirectoryAtPath:fileName error:nil];
        for (int i =0; i<items.count; i++) {
            BOOL subisdir;
            NSString* fileAbsolutePath = [fileName stringByAppendingPathComponent:items[i]];

            [manager fileExistsAtPath:fileAbsolutePath isDirectory:&subisdir];
            if (subisdir==YES) {
                folderSize += [self folderSizeAtPath:fileAbsolutePath]; //文件夹就递归计算
            }
            else {
                folderSize += [self fileSizeAtPath:fileAbsolutePath];//文件直接计算
            }
        }
    }
    return folderSize;
}
//MARK: 清理缓存
+ (void)xk_clearCaches {
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject;
    path = [path stringByAppendingPathComponent:@"Caches"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
}

@end
