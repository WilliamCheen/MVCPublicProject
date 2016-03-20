//
//  TTTopicLabel.m
//  WilliamProject
//
//  Created by WilliamChen on 15/11/23.
//  Copyright © 2015年 WilliamChen. All rights reserved.
//

#import "TTTopicLabel.h"
#import <CoreText/CoreText.h>

NSString *const kRouterEventTopicTapEventName = @"kRouterEventTopicTapEventName";


@interface TTTopicLabel ()
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) NSArray                *topicMaches;
@end

@implementation TTTopicLabel

#pragma mark  -Event Response

- (void)tapAction:(UIGestureRecognizer *)tapGesture{
    
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)tapGesture;
    CGPoint point = [tap locationInView:self];
    CFIndex charIndex = [self characterIndexAtPoint:point];
    
    for (NSTextCheckingResult *match in self.topicMaches) {
        if (match.range.location == NSNotFound && match.range.length <= 1) continue;
        
        NSLog(@"matchRange:%@",NSStringFromRange(match.range));
        if ([self isIndex:charIndex inRange:match.range]) {
            
            NSString *tapString = [self.topicText substringWithRange:match.range];
            [self routerEventWithName:kRouterEventTopicTapEventName userInfo:@{@"SelectedTopic":tapString}];
            break;
        }
    }
}

#pragma mark -Private Method

- (void)formateTopicText{
    if (self.topicText.length) {
        self.topicMaches = [[TTTopicLabel regexTopic] matchesInString:self.topicText options:kNilOptions range:NSMakeRange(0, self.topicText.length)];
        
        // highlight the topic text
        
        [self highlightTopicText];
    }
}

- (void)highlightTopicText {
    
    NSMutableAttributedString *attributedString = nil;
    if (self.attributedText) {
        attributedString = self.attributedText.mutableCopy;
    }
    else{
        attributedString = [[NSMutableAttributedString alloc]initWithString:self.topicText];
    }
    
    for (NSTextCheckingResult *match in self.topicMaches) {
        if (match.range.location == NSNotFound && match.range.length <= 1) continue;
        
        UIColor *topicColor = !self.topicColor ? [UIColor redColor] : self.topicColor;
        NSRange matchRange = [match range];
        [attributedString addAttribute:NSForegroundColorAttributeName value:topicColor range:matchRange];
    }
    
    self.attributedText = attributedString;
}

+ (NSRegularExpression *)regexTopic {
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regex = [NSRegularExpression regularExpressionWithPattern:@"#[^@#]+?#" options:kNilOptions error:NULL];
    });
    return regex;
}

- (CFIndex)characterIndexAtPoint:(CGPoint)point
{
    // First, create a CoreText framesetter
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)self.attributedText);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
    // Get the frame that will do the rendering.
    CFRange currentRange = CFRangeMake(0, 0);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, currentRange, path, NULL);
    CGPathRelease(path);
    
    
    if (!CGRectContainsPoint(self.bounds, point)) {
        return NSNotFound;
    }
    
    CFArrayRef lines = CTFrameGetLines(frame);
    
    NSInteger numberOfLines = self.numberOfLines > 0 ? MIN(self.numberOfLines, CFArrayGetCount(lines)) : CFArrayGetCount(lines);
    
    NSLog(@"num lines: %d", numberOfLines);
    
    if (numberOfLines == 0) {
        CFRelease(frame);
        CFRelease(path);
        return NSNotFound;
    }
    
    NSUInteger idx = NSNotFound;
    
    CGPoint lineOrigins[numberOfLines];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, numberOfLines), lineOrigins);
    
    for (CFIndex lineIndex = 0; lineIndex < numberOfLines; lineIndex++) {
        
        CGPoint lineOrigin = lineOrigins[lineIndex];
        CTLineRef line = CFArrayGetValueAtIndex(lines, lineIndex);
        
        // Get bounding information of line
        CGFloat ascent, descent, leading, width;
        width = CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
        CGFloat yMin = floor(lineOrigin.y - descent);
        CGFloat yMax = ceil(lineOrigin.y + ascent);
        
        // Check if we've already passed the line
        if (point.y > yMax) {
            break;
        }
        
        // Check if the point is within this line vertically
        if (point.y >= yMin) {
            
            // Check if the point is within this line horizontally
            if (point.x >= lineOrigin.x && point.x <= lineOrigin.x + width) {
                
                // Convert CT coordinates to line-relative coordinates
                CGPoint relativePoint = CGPointMake(point.x - lineOrigin.x, point.y - lineOrigin.y);
                idx = CTLineGetStringIndexForPosition(line, relativePoint);
                
                break;
            }
        }
    }
    
//    CFRelease(frame);
//    CFRelease(path);
    
    return idx;
}

- (BOOL)isIndex:(CFIndex)index inRange:(NSRange)range
{
    return index > range.location && index < range.location+range.length;
}

#pragma mark -Setters And Getters

- (void)setTopicText:(NSString *)topicText{
    _topicText = topicText;
    
    if (![self.gestureRecognizers containsObject:self.tapGesture]) {
        [self addGestureRecognizer:self.tapGesture];
    }
    
    if (!self.userInteractionEnabled) {
        self.userInteractionEnabled = YES;
    }
    
    [self formateTopicText];
}

- (void)setTopicColor:(UIColor *)topicColor{
    _topicColor = topicColor;
    
    if (self.topicMaches.count) {
        [self highlightTopicText];
    }
}

- (UITapGestureRecognizer *)tapGesture{
    if (_tapGesture == nil) {
        _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                             action:@selector(tapAction:)];
    }
    return _tapGesture;
}

@end

@implementation UIResponder (Router)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}


@end
