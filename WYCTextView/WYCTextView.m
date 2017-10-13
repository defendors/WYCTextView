//
//  WYCTextView.m
//  WYCTextView
//
//  Created by WD_王宇超 on 2017/10/13.
//  Copyright © 2017年 WD_王宇超. All rights reserved.
//

#import "WYCTextView.h"

@implementation WYCTextView
{
	UIView* leftConstraintView;
	UIView* rightConstraintView;
	UIView* leftVerticalLine;
	UIView* rightVerticalLine;
	UIView* bottomHorizonLine;
	
	CGFloat rightLabelHeight;
	CGFloat leftLabelHeight;
	
	CGFloat  originalViewHeight;
	
	NSInteger changeCountLayoutSubviews;
	NSInteger changeCountTextViewTextDidChangeNotification;
	NSInteger unknownDefine;
}
-(id)initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	if (self) {
		
		unknownDefine = 4;
		changeCountLayoutSubviews = 1;
		changeCountTextViewTextDidChangeNotification = 1;
		_maxHeight = 100.0f;
		_limitedLength = YES;
		
		leftConstraintView = [UIView new];
		_leftImageView = [[UIImageView alloc]init];
		[_leftImageView setContentMode:UIViewContentModeScaleAspectFit];
		_leftTitleLabel = [[UILabel alloc]init];
		[self addSubview:leftConstraintView];
		[leftConstraintView addSubview:_leftImageView];
		[leftConstraintView addSubview:_leftTitleLabel];
		
		
		_placeholderLabel = [[UILabel alloc]init];
		_placeholderLabel.textColor = [UIColor colorWithRed:206.00 / 255 green:206.00 / 255 blue:206.00 / 255 alpha:1];
		[self addSubview:_placeholderLabel];
		self.font = _placeholderLabel.font;
		
		
		
		rightConstraintView = [UIView new];
		_rightImageView = [[UIImageView alloc]init];
		[_rightImageView setContentMode:UIViewContentModeScaleAspectFit];
		_rightTitleLabel = [[UILabel alloc]init];
		[self addSubview:rightConstraintView];
		[rightConstraintView addSubview:_rightImageView];
		[rightConstraintView addSubview:_rightTitleLabel];
		
		leftVerticalLine = [UIView new];
		[self addSubview:leftVerticalLine];
		rightVerticalLine = [UIView new];
		[self addSubview:rightVerticalLine];
		bottomHorizonLine = [UIView new];
		[self addSubview:bottomHorizonLine];
		
		_maxLength = 50;
		
	}
	return self;
}
-(void)layoutSubviews{
	[super layoutSubviews];
	
	//第一个
	if (changeCountLayoutSubviews == 1) {
		CGFloat currentViewHeight = self.frame.size.height;
		originalViewHeight = currentViewHeight;
		NSLog(@"%f",originalViewHeight);
	}
	if (changeCountLayoutSubviews == 100) {
		changeCountLayoutSubviews = 2;
	}
	changeCountLayoutSubviews ++;
	
	CGFloat leftView_W = MAX(MAX(_leftImageViewSize.width, _leftViewSize.width), _leftTitleLabelSize.width) + _centerSpace;
	
	CGFloat leftView_H = MAX(MAX(_leftImageViewSize.height, _leftViewSize.height), _leftTitleLabelSize.height);
	CGPoint leftView_Center = CGPointMake(0 + 0.5 * leftView_W + _leftSpace, 0.5 * self.frame.size.height + self.contentOffset.y);
	[leftConstraintView setFrame:CGRectMake(0, 0, leftView_W, leftView_H)];
	[leftConstraintView setCenter:leftView_Center];
	
	[_leftImageView setFrame:CGRectMake(0, 0, _leftImageViewSize.width, _leftImageViewSize.height)];
	[_leftImageView setCenter:CGPointMake(0.5 * (leftView_W - _centerSpace),0.5 * leftView_H)];
	
	[_leftTitleLabel setFrame:CGRectMake(0, 0, _leftTitleLabelSize.width, _leftTitleLabelSize.height)];
	[_leftTitleLabel setCenter:CGPointMake(0.5 * (leftView_W - _centerSpace),0.5 * leftView_H)];
	
	
	CGFloat rightView_W = MAX(MAX(_rightImageViewSize.width, _rightViewSize.width), _rightTitleLabelSize.width);
	CGFloat rightView_H = MAX(MAX(_rightImageViewSize.height, _rightViewSize.height), _rightTitleLabelSize.height);
	CGPoint rightView_center = CGPointMake(self.frame.size.width - _rightSpace - 0.5 * rightView_W, 0.5 * self.frame.size.height + self.contentOffset.y);
	[rightConstraintView setFrame:CGRectMake(0, 0, rightView_W, rightView_H)];
	[rightConstraintView setCenter:rightView_center];
	//	NSLog(@"------%f %f",leftConstraintView.frame.origin.x,leftConstraintView.frame.size.width);
	
	[_rightImageView setFrame:CGRectMake(0, 0, _rightImageViewSize.width, _rightImageViewSize.height)];
	[_rightImageView setCenter:CGPointMake(0.5 * rightView_W, 0.5 * rightView_H)];
	
	[_rightTitleLabel setFrame:CGRectMake(0, 0, _rightTitleLabelSize.width, _rightTitleLabelSize.height)];
	[_rightTitleLabel setCenter:CGPointMake(0.5 * rightView_W, 0.5 * rightView_H)];
	if (_rightButton) {
		[rightConstraintView addSubview:_rightButton];
		[_rightButton setFrame:CGRectMake(0, 0, rightView_W, rightView_H)];
		//		[_rightButton setCenter:rightView_center];
	}
	
	if (_lineColor) {
		
		bottomHorizonLine.frame = CGRectMake(0, self.frame.size.height - _lineWidth + self.contentOffset.y, self.frame.size.width, _lineWidth);
		leftVerticalLine.frame = CGRectMake(0, self.frame.size.height * (1 - _verticalLinePercent) + self.contentOffset.y, _lineWidth, self.frame.size.height * _verticalLinePercent);
		rightVerticalLine.frame = CGRectMake(self.frame.size.width - _lineWidth, self.frame.size.height * (1 - _verticalLinePercent) + self.contentOffset.y, _lineWidth, self.frame.size.height * _verticalLinePercent);
		
		bottomHorizonLine.backgroundColor = _lineColor;
		leftVerticalLine.backgroundColor = _lineColor;
		rightVerticalLine.backgroundColor = _lineColor;
	}
	
	CGFloat EdgeInsets_left = leftConstraintView.frame.size.width + _leftSpace - unknownDefine;
	CGFloat EdgeInsets_right = rightConstraintView.frame.size.width + _rightSpace - unknownDefine;
	
	CGFloat placeholderLabel_W = self.frame.size.width - EdgeInsets_left - EdgeInsets_right -  2 *  unknownDefine;
	CGFloat placeholderLabel_H = [self labelHeight:_placeholderLabel];
	//	NSLog(@"placeholderLabel_H:%f",placeholderLabel_H);
	[_placeholderLabel setFrame:CGRectMake(0, 0, placeholderLabel_W, placeholderLabel_H)];
	[_placeholderLabel setCenter:CGPointMake(0.5 * placeholderLabel_W + (EdgeInsets_left + unknownDefine), 0.5 * self.frame.size.height + self.contentOffset.y)];
	
	CGFloat EdgeInsets_top = 0.5 * (originalViewHeight - placeholderLabel_H);
	CGFloat EdgeInsets_bottom = EdgeInsets_top;
	
	self.textContainerInset = UIEdgeInsetsMake(EdgeInsets_top,EdgeInsets_left, EdgeInsets_bottom, EdgeInsets_right);
	//		NSLog(@"textContainerInset top:%f left:%f bottom:%f right:%f",EdgeInsets_top,EdgeInsets_left,EdgeInsets_bottom,EdgeInsets_right);
	
	
}
//-(void)textViewDidChange:(UITextView *)textView {
//	//获得textView的初始尺寸
//	CGFloat width = CGRectGetWidth(textView.frame);
//	CGFloat height = CGRectGetHeight(textView.frame);
//	CGSize newSize = [textView sizeThatFits:CGSizeMake(width,MAXFLOAT)];
//	CGRect newFrame = textView.frame;
//	newFrame.size = CGSizeMake(fmax(width, newSize.width), fmax(height, newSize.height));
//	textView.frame= newFrame;
//}

-(void)textViewTextDidChangeNotification:(NSNotification*)textViewNotification{
	WYCTextView* textView = textViewNotification.object;
	CGFloat currentViewHeight = textView.frame.size.height;
	
	//处理文本长度的问题
	if (YES == _limitedLength
		&&
		textView.text.length > _maxLength) {
		NSString* newString = [textView.text substringToIndex:_maxLength];
		[textView setText:newString];
		if (_belongMaxLengthBlock != nil) {
			_belongMaxLengthBlock(_maxLength);
		}
	}
//	if (textView.text.length > _maxLength) {
//		NSString* newString = [textView.text substringToIndex:_maxLength];
//		[textView setText:newString];
//		if (_belongMaxLengthBlock != nil) {
//			_belongMaxLengthBlock(_maxLength);
//		}
//	}
	
	
	//第一个
	if (changeCountTextViewTextDidChangeNotification == 1) {
		originalViewHeight = currentViewHeight;
	}
	if (changeCountTextViewTextDidChangeNotification == 100) {
		changeCountTextViewTextDidChangeNotification = 2;
	}
	changeCountTextViewTextDidChangeNotification ++;
	
	if (textView.text.length < 0.1) {
		textView.placeholderLabel.hidden = NO;
	}else{
		textView.placeholderLabel.hidden = YES;
	}
	
	
	//	CGFloat placeholderLabel_H = [self labelHeight:_placeholderLabel];
	//	CGFloat EdgeInsets_top = 0.5 * (originalViewHeight - placeholderLabel_H);
	//	CGFloat EdgeInsets_bottom = EdgeInsets_top;
	
	CGRect frame = textView.frame;
	CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
	CGSize newSize = [textView sizeThatFits:constraintSize];
	//	NSLog(@"文本高度:%f",newSize.height);
	//	CGFloat newTextHeight = newSize.height + EdgeInsets_top + EdgeInsets_bottom;
	
	if (newSize.height > _maxHeight)
	{
		textView.scrollEnabled = YES;   // 允许滚动
	}
	else
	{
		textView.scrollEnabled = NO;    // 不允许滚动
	}
	
	if (MAX(0, newSize.height) == MIN(newSize.height, originalViewHeight)) {
		
		textView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, originalViewHeight);
	}else if (MAX(originalViewHeight, newSize.height) == MIN(newSize.height, _maxHeight)){
		textView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, newSize.height);
	}else if (_maxHeight < newSize.height){
		textView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, _maxHeight);
	}else{
		//
		NSLog(@"卧槽，这句尼玛都能打印出来？！？！？！？！");
	}
	
	
	
	
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (CGFloat)labelHeight:(UILabel*)label{
	//	UIFont* labelFont = label.font;
	//	CGFloat height_label = labelFont.lineHeight;
	//	return height_label;
	
	NSString *str = @"请输入验证码中国永远国家Aa1234567890Zz";
	NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:label.font,NSFontAttributeName, nil];
	CGSize actsize = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
	return actsize.height;
}

@end

