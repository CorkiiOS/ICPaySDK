//
//  ICCircleTestViewController.m
//  ICPaySDK_Example
//
//  Created by mac on 2017/12/29.
//  Copyright © 2017年 corkiios. All rights reserved.
//

#import "ICCircleTestViewController.h"
#import "ICViewController.h"
@interface ICCircleTestViewController ()

@end

@implementation ICCircleTestViewController

- (IBAction)test:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ICViewController *controller = [storyboard instantiateInitialViewController];
    [self.navigationController pushViewController:controller animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
