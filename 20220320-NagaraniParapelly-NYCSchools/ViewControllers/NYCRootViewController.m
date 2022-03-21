//
//  NYCRootViewController.m
//  20220320-NagaraniParapelly-NYCSchools
//
//  Created by raniraja on 3/20/22.
//

#import "NYCRootViewController.h"

@interface NYCRootViewController ()

@end

@implementation NYCRootViewController

UIView *loadingView;
UIActivityIndicatorView *activityIndicator;
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)startAnimating {
    loadingView=[[UIView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 100) /2,  (self.view.frame.size.height - 100)/2, 100, 100)];
    loadingView.backgroundColor=[UIColor clearColor];
    loadingView.clipsToBounds=YES;
    loadingView.layer.cornerRadius=10.0;
    [self.view addSubview:loadingView];
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];

    [activityIndicator setCenter:CGPointMake(loadingView.frame.size.width/2, loadingView.frame.size.height/2)];
    [loadingView addSubview:activityIndicator];
    [activityIndicator startAnimating];
    UILabel *loadingViewlabel =[[UILabel alloc]initWithFrame:CGRectMake(0, loadingView.frame.size.height/2 + 20 , loadingView.frame.size.width, 20)];
    loadingViewlabel.backgroundColor=[UIColor clearColor];
    loadingViewlabel.textAlignment = NSTextAlignmentCenter;
    loadingViewlabel.textColor = [UIColor blackColor];
    loadingViewlabel.text = @"Loading...";
    [loadingView addSubview:loadingViewlabel];
}

-(void)stopAnimating {
    [activityIndicator stopAnimating];
    loadingView.hidden = YES;
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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
