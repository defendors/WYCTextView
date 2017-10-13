//
//  ViewController.m
//  WYCTextView
//
//  Created by WD_王宇超 on 2017/10/13.
//  Copyright © 2017年 WD_王宇超. All rights reserved.
//

#import "ViewController.h"
#import "WYCTextView.h"
@interface ViewController ()

@end

@implementation ViewController
{
	WYCTextView* test;
}
#pragma mark life cycle
- (void)viewDidLoad {
	[super viewDidLoad];
	[self addView];
	// Do any additional setup after loading the view, typically from a nib.
}
- (void)viewWillAppear:(BOOL)animated{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChangeNotification:) name:UITextViewTextDidChangeNotification object:nil];
}
- (void)viewWillDisappear:(BOOL)animated{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}
#pragma mark private
- (void)addView{
	test = [[WYCTextView alloc]initWithFrame:CGRectMake(50, 150, 200, 40)];
	test.backgroundColor = [UIColor cyanColor];
	test.lineWidth = 2;
	test.leftTitleLabel.backgroundColor = [UIColor redColor];
	test.lineColor = [UIColor blackColor];
	test.maxHeight = 100;
	test.leftSpace = 10;
	test.rightSpace = 10;
	test.verticalLinePercent = 0.3;
	test.placeholderLabel.text = @"test";
	test.leftTitleLabel.text = @"left";
	test.rightTitleLabel.text = @"right";
	test.leftTitleLabelSize = CGSizeMake(40, 20);
	test.rightTitleLabelSize = CGSizeMake(40, 20);
	test.belongMaxLengthBlock = ^(NSInteger maxLength) {
		NSLog(@"最大长度：%ld",(long)maxLength);
	};
	[self.view addSubview:test];
}
- (void)textViewTextDidChangeNotification:(NSNotification*)notification{
	if ([notification.object isKindOfClass:[WYCTextView class]]) {
		WYCTextView* textView = notification.object;
		[textView textViewTextDidChangeNotification:notification];
	}
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
