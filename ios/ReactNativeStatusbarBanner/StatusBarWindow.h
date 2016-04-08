//
//  StatusBarWindow.h
//  ReactNativeStatusbarBanner
//
//  Created by Rahul Jiresal on 4/8/16.
//  Copyright © 2016 Rahul Jiresal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatusBarWindow : UIWindow

- (void)setText:(NSString *)message;
- (void)showAnimated:(BOOL)animated;
- (void)hideAnimated:(BOOL)animated;
- (void)showAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
- (void)hideAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion;

@end
