//
//  StatusBarWindow.m
//  ReactNativeStatusbarBanner
//
//  Created by Rahul Jiresal on 4/8/16.
//  Copyright © 2016 Rahul Jiresal. All rights reserved.
//

#import "StatusBarWindow.h"

@interface StatusBarWindow()

@property (strong, nonatomic) UILabel* notificationLabel;
@property UIInterfaceOrientation orientation;
@property (strong, nonatomic) NSString* message;

@end

@implementation StatusBarWindow

- (id)init {
    self = [super initWithFrame:CGRectMake(0, -self.statusBarHeight, [[UIScreen mainScreen] bounds].size.width, self.statusBarHeight)];
    if (self) {
        [self setWindowLevel:UIWindowLevelStatusBar + 10];
        [self setupOrientationListeners];
    }
    return self;
}

- (void)layoutSubviews {
    if (!self.notificationLabel) {
        self.notificationLabel = [[UILabel alloc] init];
        [self.notificationLabel setTextAlignment:NSTextAlignmentCenter];
        [self.notificationLabel setTextColor:[UIColor whiteColor]];
        [self.notificationLabel setFont:[UIFont systemFontOfSize:12.0]];
        [self.notificationLabel setText:self.message];
        [self addSubview:self.notificationLabel];
    }
    [self setFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, [[UIScreen mainScreen] bounds].size.width, self.statusBarHeight)];
    [self.notificationLabel setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

- (void)setupOrientationListeners {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}

- (void)orientationChanged:(NSNotification*)notification {
    self.orientation = [UIApplication sharedApplication].statusBarOrientation;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setNeedsLayout];
        [self layoutIfNeeded];
    });
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - public methods

- (void)setText:(NSString *)message {
    self.message = message;
    [self.notificationLabel setText:message];
}

- (void)showAnimated:(BOOL)animated {
    [self showAnimated:animated completion:^(BOOL finished) { }];
}

- (void)hideAnimated:(BOOL)animated {
    [self hideAnimated:animated completion:^(BOOL finished) { }];
}

- (void)showAnimated:(BOOL)animated completion:(void (^)(BOOL))completion {
    if (animated) {
        [UIView animateWithDuration:0.1 animations:^{
            [self setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, self.statusBarHeight)];
        } completion:^(BOOL finished) {
            completion(finished);
        }];
    }
    else {
        [self setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, self.statusBarHeight)];
        completion(YES);
    }
}

- (void)hideAnimated:(BOOL)animated completion:(void (^)(BOOL))completion {
    if (animated) {
        [UIView animateWithDuration:0.1 animations:^{
            [self setFrame:CGRectMake(0, -self.statusBarHeight, [[UIScreen mainScreen] bounds].size.width, self.statusBarHeight)];
        } completion:^(BOOL finished) {
            completion(finished);
        }];
    }
    else {
        [self setFrame:CGRectMake(0, -self.statusBarHeight, [[UIScreen mainScreen] bounds].size.width, self.statusBarHeight)];
        completion(YES);
    }
}

- (CGFloat)statusBarHeight {
    return [UIApplication sharedApplication].statusBarFrame.size.height;
}


@end
