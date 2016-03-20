//
//  NewsViewCell.m
//  WilliamProject
//
//  Created by WilliamChen on 16/1/11.
//  Copyright © 2016年 WilliamChen. All rights reserved.
//

#import "NewsViewCell.h"
#import "M80AttributedLabel.h"

@interface NewsViewCell ()<M80AttributedLabelDelegate>
@property (nonatomic, strong) M80AttributedLabel *contentLab;
@end

@implementation NewsViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)configureCellWithString:(NSString *)string
{
    _contentLab.text = string;
    [_contentLab addCustomLink:@"UUUUU" forRange:NSMakeRange(0, string.length )];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _contentLab = [[M80AttributedLabel alloc]init];
        _contentLab.font = [UIFont systemFontOfSize:13];
        _contentLab.linkColor = [UIColor orangeColor];
        _contentLab.lineSpacing = -2;
        _contentLab.textColor = [UIColor lightGrayColor];
        _contentLab.delegate = self;
        [self.contentView addSubview:_contentLab];
    }
    return self;
}

- (void)m80AttributedLabel:(M80AttributedLabel *)label clickedOnLink:(id)linkData
{
    NSLog(@"DARA:%@",linkData);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(15, 10, self.contentView.height - 20, self.contentView.height - 20);
    _contentLab.frame = CGRectMake(self.imageView.right + 10, 0, self.contentView.width - 30, self.contentView.height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
