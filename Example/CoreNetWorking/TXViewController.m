//
//  TXViewController.m
//  CoreNetWorking
//
//  Created by acct<blob>=0xE7A9BAE781B5E699BAE883BD on 02/25/2019.
//  Copyright (c) 2019 acct<blob>=0xE7A9BAE781B5E699BAE883BD. All rights reserved.
//

#import "TXViewController.h"
#import "MGJRouterKit.h"

@interface TXViewController ()

@end

@implementation TXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss:)];
    [self.view addGestureRecognizer:tap];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)dismiss:(UITapGestureRecognizer *)sender{
    [MGJRouter openURL:@"tx://signOut/nulleSchool/teacher"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
