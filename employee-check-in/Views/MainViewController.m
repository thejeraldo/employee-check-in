//
//  MainViewController.m
//  employee-check-in
//
//  Created by Jerald Allen Abille on 10/30/24.
//

#import "MainViewController.h"
#import <SwiftUI/SwiftUI.h>
#import "employee_check_in-Swift.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupViews];
}

- (void)setupViews {
    [self.view setBackgroundColor:[UIColor systemBackgroundColor]];
    
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [startButton setTitle:@"Start" forState:UIControlStateNormal];
    [startButton setBackgroundColor:[UIColor tertiarySystemFillColor]];
    [startButton setTitleColor:[UIColor labelColor] forState:UIControlStateNormal];
    [[startButton layer] setCornerRadius:10];
    [startButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self view] addSubview:startButton];
    [NSLayoutConstraint activateConstraints:@[
        [startButton.leadingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.leadingAnchor],
        [startButton.trailingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.trailingAnchor],
        [startButton.heightAnchor constraintEqualToConstant: 44],
        [startButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]
    ]];
    
    [startButton addTarget:self action:@selector(didTapStartButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didTapStartButton {
    CheckInViewController *vc = [CheckInViewController new];
    [[self navigationController] pushViewController:vc animated:YES];
}

@end
