//
//  StatusBarNotificationBanner.m
//  ReactNativeStatusbarBanner
//
//  Created by Rahul Jiresal on 11/24/15.
//  Copyright © 2015 Rahul Jiresal. All rights reserved.
//

#import "StatusBarNotificationBanner.h"
#import "RCTBridge.h"
#import "UIColor+Hex.h"
#import "StatusBarWindow.h"

@interface StatusBarNotificationBanner () <RCTBridgeModule>

@property (strong, nonatomic) StatusBarWindow* notificationWindow;
@property BOOL currentlyShowing;
@property NSTimer *timer;
@property NSMutableArray *messageQueue;

@end

@implementation StatusBarNotificationBanner

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(showNotificationWithMessage:(NSString *)message backgroundColor:(NSString *)colorHexString )
{
    UIColor *color = [UIColor colorWithHexString:colorHexString];
    [StatusBarNotificationBanner showWithMessage:message backgroundColor:color autoHide:NO];
}

RCT_EXPORT_METHOD(hideNotificationBanner)
{
    [StatusBarNotificationBanner hide];
}

static StatusBarNotificationBanner *STATUSBARNOTIFICATION_SINGLETON = nil;
static bool isFirstAccess = YES;

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        STATUSBARNOTIFICATION_SINGLETON = [[super allocWithZone:NULL] init];
    });
    
    return STATUSBARNOTIFICATION_SINGLETON;
}

#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone {
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

- (id)copy {
    return [[StatusBarNotificationBanner alloc] init];
}

- (id)mutableCopy {
    return [[StatusBarNotificationBanner alloc] init];
}

- (id) init {
    if(STATUSBARNOTIFICATION_SINGLETON){
        return STATUSBARNOTIFICATION_SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    return self;
}

#pragma mark - public methods

+ (void)showWithMessage:(NSString*)message backgroundColor:(UIColor*)bgColor autoHide:(BOOL)autoHide {
    [[StatusBarNotificationBanner sharedInstance] showWithMessage:message backgroundColor:bgColor autoHide:(BOOL)autoHide];
}

+ (void)hide {
    [[StatusBarNotificationBanner sharedInstance] hideAnimated:YES];
}

+ (UIColor*)errorColor {
    return [UIColor colorWithRed:249.0/255.0 green:83.0/255.0 blue:114.0/255.0 alpha:1.0];
}

+ (UIColor*)warningColor {
    return [UIColor colorWithRed:255.0/255.0 green:153.0/255.0 blue:0.0/255.0 alpha:1.0];
}

+ (UIColor*)successColor {
    return [UIColor colorWithRed:29.0/255.0 green:156.0/255.0 blue:90.0/255.0 alpha:1.0];
}

+ (UIColor*)infoColor {
    return [UIColor colorWithRed:102.0/255.0 green:178.0/255.0 blue:255.0/255.0 alpha:1.0];
}

#pragma mark - private methods

- (void)showWithMessage:(NSString*)message backgroundColor:(UIColor*)bgColor autoHide:(BOOL)autoHide{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.currentlyShowing) {
            [self.timer invalidate];
            [self.notificationWindow setBackgroundColor:bgColor];
            [self.notificationWindow setText:message];
        }
        else {
            if (!self.notificationWindow) {
                self.notificationWindow = [[StatusBarWindow alloc] init];
            }
            [self.notificationWindow setBackgroundColor:bgColor];
            [self.notificationWindow setText:message];
            [self.notificationWindow setHidden:NO];
            [self.notificationWindow showAnimated:YES];
            self.currentlyShowing = YES;
        }
        if (autoHide) {
            self.timer = [NSTimer timerWithTimeInterval:0.7 target:self selector:@selector(timerTick) userInfo:nil repeats:NO];
            [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        }
    });
    
}

- (void)timerTick {
    self.currentlyShowing = NO;
    [self hideAnimated:YES];
}

- (void)hideAnimated:(BOOL)animated {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.notificationWindow hideAnimated:animated completion:^(BOOL finished) {
            [self.notificationWindow setHidden:YES];
        }];
        self.currentlyShowing = NO;
    });
}

@end