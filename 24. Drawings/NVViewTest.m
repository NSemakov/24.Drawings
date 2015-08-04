//
//  NVViewTest.m
//  24. Drawings
//
//  Created by Admin on 03.08.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "NVViewTest.h"

@implementation NVViewTest

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void) drawRect:(CGRect)rect {
    
    for (NSInteger i=0; i<5; i++) {
        [self createFiveEndsStarAtRandomPoint];
    }
}
- (void) createFiveEndsStarAtRandomPoint{
    //set random radius and center, not exceeding bounds of view
    CGFloat radiusOfStar=arc4random_uniform(30)+30;
    
    //create random point in such way, when whole star doesn't exceed bounds of view:
    CGPoint randomCenterPoint=CGPointMake(arc4random_uniform(CGRectGetWidth(self.bounds)-2*radiusOfStar)+radiusOfStar, arc4random_uniform(CGRectGetHeight(self.bounds)-2*radiusOfStar)+radiusOfStar);
    
    CGFloat randomAngle=arc4random_uniform(361)*2*M_PI/360;
    CGContextRef context=UIGraphicsGetCurrentContext();
    NSMutableArray* arrayOfPointsForStar=[[NSMutableArray alloc]init];
    
    for (NSInteger i=0; i<5; i++) {
        CGFloat x=cosf(2*M_PI/5*2*i+randomAngle)*radiusOfStar+randomCenterPoint.x;
        CGFloat y=sinf(2*M_PI/5*2*i+randomAngle)*radiusOfStar+randomCenterPoint.y;
        //2*M_PI/5=72 degrees.
        CGPoint point= CGPointMake(x, y);
        [arrayOfPointsForStar addObject:NSStringFromCGPoint(point)];
        CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
        
    }

    [self connectPointWithLinesInArray:arrayOfPointsForStar isfill:YES];
    
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);

    CGContextFillPath(context);
   [self createCircleAtVertexes:arrayOfPointsForStar];
    
}
- (void) createCircleAtVertexes:(NSMutableArray*) arrayOfVertex {
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    for (NSString* obj in arrayOfVertex){
        CGPoint currentPoint=CGPointFromString(obj);
        CGFloat width=20;
        CGRect rect=CGRectMake(currentPoint.x-width/2, currentPoint.y-width/2, width, width);
        CGContextAddEllipseInRect(context, rect);
       
    }
    
    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextFillPath(context);
    [self createLinesBetweenCircles:arrayOfVertex];
    
}
- (void) drawCircleAtPoint:(CGPoint) point {
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGFloat width=10;
    CGRect rect=CGRectMake(point.x-width/2, point.y-width/2, width, width);
    CGContextAddEllipseInRect(context, rect);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextStrokePath(context);
}
- (void) createLinesBetweenCircles:(NSMutableArray*) arrayOfVertexes {

    NSMutableArray *arrayOfVertexInRightOrder=[[NSMutableArray alloc]initWithObjects:
                        [arrayOfVertexes objectAtIndex:0],
                        [arrayOfVertexes objectAtIndex:3],
                        [arrayOfVertexes objectAtIndex:1],
                        [arrayOfVertexes objectAtIndex:4],
                        [arrayOfVertexes objectAtIndex:2],
                        nil];
     [self connectPointWithLinesInArray:arrayOfVertexInRightOrder isfill:NO];
}

 - (void) connectPointWithLinesInArray:(NSMutableArray*) array isfill:(BOOL) isfill {
     CGContextRef context=UIGraphicsGetCurrentContext();
    CGPoint current=CGPointFromString([array objectAtIndex:0]);
    CGContextMoveToPoint(context, current.x, current.y);
    for (NSInteger i=0; i<[array count]; i++) {
        
        CGPoint nextPoint=CGPointFromString([array objectAtIndex:(i+1)%5]);
        
        CGContextAddLineToPoint(context, nextPoint.x, nextPoint.y);
    }
    if (isfill) {
        CGContextClosePath(context);
        CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
        //CGContextFillPath(context);
        CGContextDrawPath(context, kCGPathFillStroke);
    } else {
        CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
        CGContextStrokePath(context);
    }
}
@end
