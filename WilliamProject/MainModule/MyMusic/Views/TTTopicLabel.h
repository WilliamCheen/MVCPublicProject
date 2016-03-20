//
//  TTTopicLabel.h
//  WilliamProject
//
//  Created by WilliamChen on 15/11/23.
//  Copyright © 2015年 WilliamChen. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const kRouterEventTopicTapEventName;

@interface UIResponder (Router)
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;
@end

@interface TTTopicLabel : UILabel
@property (nonatomic, copy) NSString  		*topicText;
@property (nonatomic, strong) UIColor		*topicColor;
@end


