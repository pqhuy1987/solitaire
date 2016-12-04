//
//  ProgressBar.m
//  Fruit Connections Cut
//
//  Created by 张朴军 on 13-4-7.
//  Copyright 2013年 张朴军. All rights reserved.
//

#import "ProgressBar.h"


@implementation ProgressBar

@synthesize back = _back;
@synthesize front = _front;
@synthesize vernier = _vernier;
@synthesize direct = _direct;
@synthesize max= _max;
@synthesize value = _value;
@synthesize min = _min;
@synthesize color = _color;


+(id)progressbarWithBack:(CCSprite *)back Front:(CCSprite *)front Vernier:(CCSprite *)vernier Direct:(ProgressBarDirect)direct
{
    return [[[self alloc] initWithBack:back Front:front Vernier:vernier Direct:direct] autorelease];
}

-(id)initWithBack:(CCSprite *)back Front:(CCSprite *)front Vernier:(CCSprite *)vernier Direct:(ProgressBarDirect)direct
{
    if(self = [super init])
    {
        if(back)
        {
            self.back = back;
            [self addChild:self.back];
        }
        
        
        if(front)
        {
            self.front = front;
            [self addChild:self.front];
            _frontRect = self.front.textureRect;
        }
        
        if(vernier)
        {
            self.vernier = vernier;
            [self addChild:self.vernier];
        }
        
        self.direct = direct;
        
        _max = 100;
        _min = 0;
        
    }
    return self;
}

-(void)dealloc
{
    self.front = nil;
    self.back = nil;
    self.vernier = nil;
    [super dealloc];
}

-(void)setDirect:(ProgressBarDirect)direct
{
    switch (direct)
    {
        case ProgressBarDirect_L2R:
            _direct = direct;
            self.back.position = ccp(0, 0);
            self.back.anchorPoint = ccp(0, 0.5);
            
            self.front.position = ccp(0, 0);
            self.front.anchorPoint = ccp(0, 0.5);
            
            _area = CGRectMake(-self.front.contentSize.height, -self.front.contentSize.height,
                               self.front.contentSize.width + self.front.contentSize.height * 2, self.front.contentSize.height * 2);
            break;
        case ProgressBarDirect_R2L:
            _direct = direct;
            self.back.position = ccp(self.front.contentSize.width, 0);
            self.back.anchorPoint = ccp(1, 0.5);
            
            self.front.position = ccp(self.front.contentSize.width, 0);
            self.front.anchorPoint = ccp(1, 0.5);
            
            _area = CGRectMake(-self.front.contentSize.height, -self.front.contentSize.height,
                               self.front.contentSize.width + self.front.contentSize.height * 2, self.front.contentSize.height * 2);
            break;
        case ProgressBarDirect_T2B:
            _direct = direct;
            
            self.back.position = ccp(0, self.front.contentSize.height);
            self.back.anchorPoint = ccp(0.5, 1);
            
            self.front.position = ccp(0, self.front.contentSize.height);
            self.front.anchorPoint = ccp(0.5, 1);
            
            _area = CGRectMake(-self.front.contentSize.width, 0, self.front.contentSize.width * 2, self.front.contentSize.height);
            break;
        case ProgressBarDirect_B2T:
            _direct = direct;
            
            self.back.position = ccp(0, 0);
            self.back.anchorPoint = ccp(0.5, 0);
            
            self.front.position = ccp(0, 0);
            self.front.anchorPoint = ccp(0.5, 0);
            
            _area = CGRectMake(-self.front.contentSize.width, 0, self.front.contentSize.width * 2, self.front.contentSize.height);
            break;
    }
    [self updateVernier];
}

-(void)setMax:(float)max
{
    if(max > _min)
    {
        _max = max;
    }
    [self updateVernier];
}

-(void)setMin:(float)min
{
    if(min < _max)
    {
        _min = min;
    }
    [self updateVernier];
}

-(void)setValue:(float)value
{
    _value = value;
    if (_value > _max)
        _value = _max;
    if(_value < _min)
        _value = _min;
    
    [self updateVernier];
}


-(void)setColor:(ccColor3B)color
{
    if(self.front)
        self.front.color = color;
}

-(void)updateVernier
{
    CGRect newRect;
    newRect = _frontRect;
    
    switch (_direct)
    {
        case ProgressBarDirect_L2R:
            newRect.size.width = ( self.value-self.min ) * _frontRect.size.width / ( self.max - self.min);
            self.vernier.position = ccp(newRect.size.width, 0);
            
            break;
        case ProgressBarDirect_R2L:
            newRect.size.width = ( self.value-self.min ) * _frontRect.size.width / ( self.max - self.min);
            newRect.origin.x = _frontRect.size.width - newRect.size.width;
            self.vernier.position = ccp(newRect.origin.x, 0);
            self.front.position = ccp(newRect.origin.x, 0);
            break;
        case ProgressBarDirect_T2B:
            newRect.size.height = ( self.value-self.min ) * _frontRect.size.height / ( self.max - self.min );
            newRect.origin.y = _frontRect.size.height - newRect.size.height;
            self.vernier.position = ccp(0, newRect.origin.y);
            self.front.position = ccp(0, newRect.origin.y);
            break;
        case ProgressBarDirect_B2T:
            newRect.size.height = ( self.value-self.min ) * _frontRect.size.height / ( self.max - self.min );
            self.vernier.position = ccp(0, newRect.size.height);
            break;
    }
    self.front.textureRect = newRect;
    
    
}
@end
