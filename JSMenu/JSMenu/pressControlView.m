//
//  pressControlView.m
//  CGSLMenu
//
//  Created by John on 11/10/14.
//  Copyright (c) 2014 John. All rights reserved.
//

#import "pressControlView.h"
#import "POP/POP.h"
#import "UIBezierPath+ZEPolygon.h"
@interface pressControlView()
@property (nonatomic,strong)CAShapeLayer *buttonLayer;
@end
@implementation pressControlView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor blackColor];
        self.alpha=0.8f;
        [self addGestureRecognizer];
    }
    return self;
}
-(void)handleLongPress:(UILongPressGestureRecognizer*)gesture{
    CGPoint location=[gesture locationInView:self];
    
    if (gesture.state==UIGestureRecognizerStateBegan) {
        //CGRect frame=CGRectMake(self.center.x-50, self.center.y-50, 100, 100);
        CGRect frame=CGRectMake(location.x-100, location.y-100, 200, 200);
        UIBezierPath *bezierPath=[UIBezierPath bezierPathWithPolygonInRect:frame numberOfSides:6];
        self.buttonLayer=[CAShapeLayer layer];
        self.buttonLayer.path = bezierPath.CGPath;
        self.buttonLayer.lineWidth=2.0f;
        self.buttonLayer.allowsEdgeAntialiasing=YES;
        self.buttonLayer.contentsScale=[UIScreen mainScreen].scale;
        self.buttonLayer.strokeEnd=0;
        self.buttonLayer.fillColor=[UIColor clearColor].CGColor;
        self.buttonLayer.strokeColor=[UIColor whiteColor].CGColor;
        

        [self.layer addSublayer:self.buttonLayer];

        POPSpringAnimation *buttonAnim=[POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
        buttonAnim.fromValue=@(0);
        buttonAnim.toValue=@(1);
  //      buttonAnim.velocity=@(0.01);
        [self.buttonLayer pop_addAnimation:buttonAnim forKey:nil];
        [buttonAnim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
            //self.buttonLayer.fillColor=[UIColor whiteColor].CGColor;

        }];

    }
    if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
        //self.buttonLayer.fillColor=[UIColor clearColor].CGColor;

        POPSpringAnimation *buttonAnim=[POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
        buttonAnim.fromValue=@(self.buttonLayer.strokeEnd);
        buttonAnim.toValue=@(0);
        //      buttonAnim.velocity=@(0.01);
        [self.buttonLayer pop_addAnimation:buttonAnim forKey:nil];
        [buttonAnim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
            [self.buttonLayer removeFromSuperlayer];

            
        }];

    }
    
}

-(void)addGestureRecognizer{
    UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    longPress.minimumPressDuration=0.3;
    
    [self addGestureRecognizer:longPress];
}

@end
