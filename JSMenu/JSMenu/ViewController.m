//
//  ViewController.m
//  CGSLMenu
//
//  Created by John on 11/10/14.
//  Copyright (c) 2014 John. All rights reserved.
//

#import "ViewController.h"
#import "pressControlView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    pressControlView *view1 = [[pressControlView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view1];
}


@end
