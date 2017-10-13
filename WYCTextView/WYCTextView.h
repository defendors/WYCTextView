//
//  WYCTextView.h
//  WYCTextView
//
//  Created by WD_王宇超 on 2017/10/13.
//  Copyright © 2017年 WD_王宇超. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^belongMaxLength)(NSInteger maxLength);
@interface WYCTextView : UITextView
/*
 所有的size，最终都会取相应的最大值maxHeight和maxWidth
 */

@property(strong,nonatomic)UILabel* placeholderLabel;

@property(assign,nonatomic)CGSize leftViewSize;
@property(assign,nonatomic)CGSize rightViewSize;

@property(strong,nonatomic)UILabel* leftTitleLabel;
@property(assign,nonatomic)CGSize leftTitleLabelSize;

@property(strong,nonatomic)UILabel* rightTitleLabel;
@property(assign,nonatomic)CGSize rightTitleLabelSize;

@property(strong,nonatomic)UIImageView* leftImageView;
@property(assign,nonatomic)CGSize leftImageViewSize;

@property(strong,nonatomic)UIImageView* rightImageView;
@property(assign,nonatomic)CGSize rightImageViewSize;

@property(strong,nonatomic)UIButton* rightButton;
/**
 文字或图片(leftTitleLabel或leftImageView) 距离左边的距离
 */
@property(assign,nonatomic)CGFloat leftSpace;
/**
 文字或图片(rightTitleLabel或rightImageView) 距离右边的距离
 */
@property(assign,nonatomic)CGFloat rightSpace;
/**
 标题或图片(leftTitleLabel或leftImageView) 距离输入文字的距离
 */
@property(assign,nonatomic)CGFloat centerSpace;


/**
 边框的有色垂线高度所占view高度的比例。
 */
@property(assign,nonatomic)float verticalLinePercent;
/**
 有色垂线的颜色。底部有色水平线不能设置高度。当颜色为nil时，垂线消失
 */
@property(strong,nonatomic)UIColor* lineColor;
/**
 线的宽度。默认为1
 */
@property(assign,nonatomic)CGFloat lineWidth;

/**
 UITextViewTextDidChangeNotification通知内部调用的方法。用于处理自动适应高度。如不实现此方法，无法实现自适应高度
 
 @param textViewNotification 通知
 */
-(void)textViewTextDidChangeNotification:(NSNotification*)textViewNotification;
/**
 textView的自适应最大高度(默认为100)
 */
@property(assign,nonatomic)CGFloat maxHeight;

/**
 文本最大长度。默认为50
 */
@property(assign,nonatomic)CGFloat maxLength;
/**
 默认为YES，limitedLength为yes时，maxLength才会有效
 */
@property(assign,nonatomic)BOOL limitedLength;
/**
 输入文本过长时的回调block
 */
@property(strong,nonatomic)belongMaxLength belongMaxLengthBlock;

@end

