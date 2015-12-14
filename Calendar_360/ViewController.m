//
//  ViewController.m
//  Calendar_360
//
//  Created by satyendra chauhan on 12/14/15.
//  Copyright © 2015 g-h-s. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    int y;
    CGFloat scrollHeignt;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Sussess");
    // Do any additional setup after loading the view, typically from a nib.
    
    y =10;

    [self makeYearView];
    scrollHeignt = 800;
    self.Scrolll.delegate = self;
//    self.Scrolll.contentSize = CGSizeMake(300, 800);
    self.Scrolll.contentSize = CGSizeMake(300, scrollHeignt);
    
    WidthCellMonthOnYear=  CellMonthforYearlyView.frame.size.width / 7.0f;
    HeightCellMonthOnYear = CellMonthforYearlyView.frame.size.height / 8.0f;
    
    calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents *dateParts = [calendar components:unitFlags fromDate:[NSDate date]];
    
    currentMonth = [dateParts month];
    currentYear = [dateParts year];

  

    
}
-(void)viewDidLayoutSubviews{
    
    self.Scrolll.contentSize = CGSizeMake(300, scrollHeignt);
}
-(void)makeYearView{
    int j =0;
    CGFloat x  =2;
    for ( int k =0; k<=3; k++) {
        for (int i=0; i<3; i++) {
            
            [[NSBundle mainBundle]loadNibNamed:@"Empty" owner:self options:nil];
            CellMonthforYearlyView.frame = CGRectMake(x,y,[UIScreen mainScreen].bounds.size.width/3-4, [UIScreen mainScreen].bounds.size.height/4-10);
            CellMonthforYearlyView.backgroundColor = [UIColor grayColor];
            
            [self drawMonthsOnyearView];
            [self updateCalendarForMonth:currentMonth forYear:currentYear];
            [self.Scrolll addSubview:CellMonthforYearlyView];

            j=j+1;
            x=x+CellMonthforYearlyView.frame.size.width+2;
            
            
        }
        j=0;
        y = y + [UIScreen mainScreen].bounds.size.height/4-3 + 4;
        x=2;
        
    }

    
}
- (void)updateCalendarForMonth:(int)month forYear:(int)year {
    char *months[12] = {"January", "Febrary", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"};
    //    self.LabelMonth.text = [NSString stringWithFormat:@"%s %d", months[month - 1], year];
    LabelMonthOnYearlyView.text = [NSString stringWithFormat:@"%s", months[month - 1]];
    
    //Get the first day of the month
    NSDateComponents *dateParts = [[NSDateComponents alloc] init];
    [dateParts setMonth:month];
    [dateParts setYear:year];
    [dateParts setDay:1];
    NSDate *dateOnFirst = [calendar dateFromComponents:dateParts];
    
    NSDateComponents *weekdayComponents = [calendar components:NSCalendarUnitWeekday fromDate:dateOnFirst];
    int weekdayOfFirst = [weekdayComponents weekday];
    
    //Map first day of month to a week starting on Monday
    //as the weekday component defaults to 1->Sun, 2->Mon...
    if(weekdayOfFirst == 1) {
        weekdayOfFirst = 7;
    } else {
        --weekdayOfFirst;
    }
    int numDaysInMonth = [calendar rangeOfUnit:NSCalendarUnitDay
                                        inUnit:NSCalendarUnitMonth
                                       forDate:dateOnFirst].length;
    
    int day = 1;
    for (int i = 0; i < 6; i++) {
        for(int j = 0; j < 7; j++) {
            int buttonNumber = i * 7 + j;
            
            UILabel *dateLabel = [ArayDaysOnYearView objectAtIndex:buttonNumber];
            
//             [button setBtnDate:nil];
            
            if(buttonNumber >= (weekdayOfFirst - 1) && day <= numDaysInMonth) {
                
                dateLabel.text = [NSString stringWithFormat:@"%d",day];
               
                NSDateComponents *dateParts = [[NSDateComponents alloc] init];
                [dateParts setMonth:month];
                [dateParts setYear:year];
                [dateParts setDay:day];
                NSDate *buttonDate = [calendar dateFromComponents:dateParts];
              //  dateLabel.text =[NSString stringWithFormat:@"%@",day];
             //   [button setBtnDate:buttonDate];
//                button.enabled = YES;
                ++day;
            }
        }
    }
}

#pragma mark ScrollView Delegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    y = y +40;
     scrollHeignt = [UIScreen mainScreen].bounds.size.height + scrollHeignt;
    [self makeYearView];
    
}
- (void)drawMonthsOnyearView {
    ArayDaysOnYearView = [[NSMutableArray alloc] initWithCapacity:42];
    for (int i = 0; i < 6; i++) {
        for(int j = 0; j < 7; j++) {
            CGRect buttonFrame = CGRectMake(j*WidthCellMonthOnYear, (i+1  )*HeightCellMonthOnYear, WidthCellMonthOnYear, HeightCellMonthOnYear);
            UILabel *dateLabel = [[UILabel alloc]initWithFrame:buttonFrame];
            
            dateLabel.font = [UIFont systemFontOfSize:9];
            dateLabel.textColor= [UIColor redColor];
            [ArayDaysOnYearView addObject:dateLabel];
            [self.Scrolll addSubview:[ArayDaysOnYearView lastObject]];
            
        }
    }
}
-(void)updateMonth:(int)month forYear:(int)year inView:(UIView *)view{
    
    char *months[12] = {"January", "Febrary", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"};
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
