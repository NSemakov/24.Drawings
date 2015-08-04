//
//  ViewController.m
//  24. Drawings
//
//  Created by Admin on 03.08.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "ViewController.h"
#import "NVViewTest.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
- (void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    //NSLog(@"%@",NSStringFromCGSize(size));
    [self.drawingView setNeedsDisplay];
    
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch=[touches anyObject];
    CGPoint point=[touch locationInView:self.view];
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGFloat width=10;
    CGRect rect=CGRectMake(point.x-width/2, point.y-width/2, width, width);
    CGContextAddEllipseInRect(context, rect);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextStrokePath(context);
   
}
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch=[touches anyObject];
    CGPoint point=[touch locationInView:self.view];
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGFloat width=10;
    CGRect rect=CGRectMake(point.x-width/2, point.y-width/2, width, width);
    CGContextAddEllipseInRect(context, rect);
    CGContextAddRect(context, rect);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextStrokePath(context);
}
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
