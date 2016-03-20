//
//  RecordTopicViewCell.m
//  WilliamProject
//
//  Created by WilliamChen on 15/11/18.
//  Copyright © 2015年 WilliamChen. All rights reserved.
//

#import "RecordTopicViewCell.h"

@interface RecordTopicViewCell ()
@property (weak, nonatomic) IBOutlet UIView *recordBgView;
@property (weak, nonatomic) IBOutlet UIButton *headerBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end

@implementation RecordTopicViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.recordBgView.layer.cornerRadius = 21.0;
    [self.headerBtn setBackgroundImage:[UIImage imageNamed:@"header.jpg"] forState:UIControlStateNormal];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
