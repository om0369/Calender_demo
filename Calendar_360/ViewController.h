//
//  ViewController.h
//  Calendar_360
//
//  Created by satyendra chauhan on 12/14/15.
//  Copyright © 2015 g-h-s. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIScrollViewDelegate>{
    
    
     IBOutlet UILabel *LabelMonthOnYearlyView;
    IBOutlet UIView *CellMonthforYearlyView;
    NSMutableArray *ArayDaysOnYearView;
    CGFloat HeightCellMonthOnYear;
    CGFloat WidthCellMonthOnYear;
    
    NSCalendar *calendar;
    int currentMonth;
    int currentYear;

}

@property (weak, nonatomic) IBOutlet UIScrollView *Scrolll;




@end

