//
//  ViewController.m
//  testScrollLayout
//
//  Created by jsix lei on 15/7/7.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "ViewController.h"
#import "MyScrollView.h"
#import "ContainView.h"

@interface ViewController ()

@property (strong, nonatomic) MyScrollView *scrollView;
@property (strong, nonatomic) ContainView *containView;

@property (strong, nonatomic) UIView *leftView;
@property (strong, nonatomic) UIView *rightView;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self buildLayout];
}

- (void)buildLayout {
	
	self.scrollView = [[MyScrollView alloc ] init];
	_scrollView.bounces = NO;
	_scrollView.pagingEnabled = YES;
	_scrollView.contentOffset = CGPointMake(0, 0);
	_scrollView.backgroundColor = [UIColor redColor];
	_scrollView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:_scrollView];
	
	
	self.containView = [[ContainView alloc] init];
	_containView.backgroundColor = [UIColor blueColor];
	_containView.translatesAutoresizingMaskIntoConstraints = NO;
	[_scrollView addSubview:_containView];
	
	self.leftView = [[UIView alloc] init];
	_leftView.translatesAutoresizingMaskIntoConstraints = NO;
	_leftView.backgroundColor = [UIColor redColor];
	[_containView addSubview:_leftView];
	
	self.rightView = [[UIView alloc] init];
	_rightView.translatesAutoresizingMaskIntoConstraints = NO;
	_rightView.backgroundColor = [UIColor greenColor];
	[_containView addSubview:_rightView];
	
}

- (void)updateLayout {
	
	UIView *view = self.view;
	NSDictionary *views = NSDictionaryOfVariableBindings(view,
														 _scrollView,
														 _containView);

	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_scrollView]|"
																	  options:0
																	  metrics:0
																		views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_scrollView]|"
																	  options:0
																	  metrics:0
																		views:views]];
	
	[_scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_containView]|"
																	  options:0
																	  metrics:0
																		views:views]];
	[_scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_containView]|"
																		options:0
																		metrics:0
																		  views:views]];
	
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:_containView
														  attribute:NSLayoutAttributeWidth
														  relatedBy:NSLayoutRelationEqual
															 toItem:self.view
														  attribute:NSLayoutAttributeWidth
														 multiplier:2.f
														   constant:0]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:_containView
														  attribute:NSLayoutAttributeHeight
														  relatedBy:NSLayoutRelationEqual
															 toItem:self.view
														  attribute:NSLayoutAttributeHeight
														 multiplier:1.f
														   constant:0]];
	
	[self updateContainView];
}

- (void)updateContainView {
	
	NSDictionary *views = NSDictionaryOfVariableBindings(_containView,
														 _leftView,
														 _rightView);
	
	[_containView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_leftView(_rightView)][_rightView]|"
																		 options:0
																		 metrics:0
																		   views:views]];
	[_containView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_leftView]|"
																		 options:0
																		 metrics:0
																		   views:views]];
	[_containView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_rightView]|"
																		 options:0
																		 metrics:0
																		   views:views]];
}

- (void)updateViewConstraints {
	[super updateViewConstraints];
	
	[self updateLayout];
}







@end
