#import "TGActionTableView.h"

@interface TGActionTableView () <UIGestureRecognizerDelegate>

@property (nonatomic) bool ignoreTouches;

@end

@implementation TGActionTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    }
    return self;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    if (!editing)
    {
        if (_actionCell != nil)
        {
            if ([_actionCell conformsToProtocol:@protocol(TGActionTableViewCell)])
                [(id<TGActionTableViewCell>)_actionCell dismissEditingControls:true];
            self.actionCell = nil;
            
            _ignoreTouches = false;
        }
    }
    
    [super setEditing:editing animated:animated];
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)__unused view
{
    return true;
}

- (void)setActionCell:(UITableViewCell *)actionCell
{
    _actionCell = actionCell;
    
    if (actionCell != nil)
        self.scrollEnabled = false;
    else
        self.scrollEnabled = true;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (_actionCell != nil)
    {
        UIView *buttonHitTest = [_actionCell hitTest:CGPointMake(point.x - _actionCell.frame.origin.x, point.y - _actionCell.frame.origin.y) withEvent:event];
        if ([buttonHitTest isKindOfClass:[UIButton class]])
            return buttonHitTest;
        else
        {
            if ([_actionCell conformsToProtocol:@protocol(TGActionTableViewCell)])
                [(id<TGActionTableViewCell>)_actionCell dismissEditingControls:true];
            self.actionCell = nil;
            _ignoreTouches = true;
            
            id delegate = self.delegate;
            if ([delegate conformsToProtocol:@protocol(TGActionTableViewDelegate)])
            {
                [(id<TGActionTableViewDelegate>)delegate dismissEditingControls];
            }
        }
        
        return self;
    }
    else if (_ignoreTouches && event.type == UIEventTypeTouches)
        return self;
    
    UIView *result = [super hitTest:point withEvent:event];
    
    if ([result isKindOfClass:[UIButton class]])
    {
        self.delaysContentTouches = false;
    }
    else
    {
        self.delaysContentTouches = true;
    }
    
    return result;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //TGLog(@"touches began: %@", touches);
    if (!_ignoreTouches)
        [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!_ignoreTouches)
        [super touchesMoved:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    //TGLog(@"touches cancel: %@", touches);
    if (_ignoreTouches)
        _ignoreTouches = false;
    else
        [super touchesCancelled:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //TGLog(@"touches ended: %@", touches);
    
    if (_ignoreTouches)
        _ignoreTouches = false;
    else
    {
        [super touchesEnded:touches withEvent:event];
        
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(touchedTableBackground)])
            [self.delegate performSelector:@selector(touchedTableBackground)];
    }
}

- (void)enableSwipeToLeftAction
{
    UISwipeGestureRecognizer *rightSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewSwiped:)];
    rightSwipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:rightSwipeRecognizer];
    rightSwipeRecognizer.delegate = self;
}

- (void)tableViewSwiped:(UISwipeGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateRecognized)
    {
        if (recognizer.direction == UISwipeGestureRecognizerDirectionRight)
        {
            id delegate = self.delegate;
            if ([delegate respondsToSelector:@selector(performSwipeToLeftAction)])
                [delegate performSwipeToLeftAction];
        }
    }
}

@end
