//
//  ViewController.m
//  Foursquare2
//
//  Created by Douglas Voss on 5/15/15.
//
//

#import "ViewController.h"

#define kToolbarHeight 40

static NSString *kCategoryFood = @"4d4b7105d754a06374d81259";
static NSString *kCategoryCoffee = @"4bf58dd8d48988d1e0931735";
static NSString *kCategoryWine = @"4d4b7105d754a06376d81259";
static NSString *kCategoryEntertainment = @"4d4b7104d754a06370d81259";

NSString *kQueryCompletedID = @"queryCompletedID";

@interface ViewController ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIView *scrollContentView;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *businessNameLabel;
@property (nonatomic, strong) UILabel *businessSubCategoryLabel;
@property (nonatomic, strong) UILabel *businessPhoneNumberLabel;
@property (nonatomic, strong) UILabel *businessAddressLabel;
@property (nonatomic, strong) UILabel *businessURLLabel;

@property (nonatomic, strong) UIImageView *foursquareCreditImageView;

@property (nonatomic, strong) UIImage *venueImage;
@property (nonatomic, strong) UIImageView *venueImageView;
@property (nonatomic, strong) NSString *venueID;



@property (nonatomic, strong) UIToolbar *toolbar;
@end

@implementation ViewController

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.imgView = [[UIImageView alloc] init];
        self.scrollContentView = [[UIView alloc] init];
        self.scrollView = [[UIScrollView alloc] init];
        self.businessNameLabel = [[UILabel alloc] init];
        self.businessSubCategoryLabel = [[UILabel alloc] init];
        self.businessPhoneNumberLabel = [[UILabel alloc] init];
        self.businessAddressLabel = [[UILabel alloc] init];
        self.businessURLLabel = [[UILabel alloc] init];
        self.venueImageView = [[UIImageView alloc] init];
        
        self.venueID = @"";
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Random Venue Demo";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.scrollContentView.backgroundColor = [UIColor brownColor];
    
    //self.scrollView.frame = CGRectMake(10, 80, 300, 400);
    self.scrollView.backgroundColor = [UIColor clearColor];
    //self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width*5.0, self.view.frame.size.height*5.0);
    //NSLog(@"scrollView.frame wid=%f height=%f", self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    //NSLog(@"scrollView.contentSize wid= %f height=%f", self.scrollView.contentSize.width, self.scrollView.contentSize.height);
    
    //self.businessNameLabel.text = @"\t";
    self.businessNameLabel.text = @"talk\nblah\nblah\nscroll\nwhy\nis\nthis\nso\nhard\nto\nmake\nwork?";
    self.businessNameLabel.backgroundColor = [UIColor redColor];
    
    self.businessSubCategoryLabel.text = @"\t";
    self.businessSubCategoryLabel.backgroundColor = [UIColor orangeColor];
    
    self.businessPhoneNumberLabel.text = @"\t";
    self.businessPhoneNumberLabel.backgroundColor = [UIColor yellowColor];
    
    self.businessAddressLabel.text = @"\t";
    self.businessAddressLabel.backgroundColor = [UIColor greenColor];
    
    self.businessURLLabel.text = @"\t";
    self.businessURLLabel.backgroundColor = [UIColor blueColor];
    self.businessURLLabel.textColor = [UIColor whiteColor];
    
    self.foursquareCreditImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"foursquareCredit"]];
    
    //self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-kToolbarHeight, self.view.frame.size.width, kToolbarHeight)];
    self.toolbar = [[UIToolbar alloc] init];
    UIBarButtonItem *foodBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Food"] landscapeImagePhone:[UIImage imageNamed:@"Food"] style:UIBarButtonItemStylePlain target:self action:@selector(foodBarButtonHandler)];
    UIBarButtonItem *coffeeBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Coffee"] landscapeImagePhone:[UIImage imageNamed:@"Coffee"] style:UIBarButtonItemStylePlain target:self action:@selector(coffeeBarButtonHandler)];
    UIBarButtonItem *wineBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Wine"] landscapeImagePhone:[UIImage imageNamed:@"Wine"] style:UIBarButtonItemStylePlain target:self action:@selector(wineBarButtonHandler)];
    UIBarButtonItem *entertainmentBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Entertainment"] landscapeImagePhone:[UIImage imageNamed:@"Entertainment"] style:UIBarButtonItemStylePlain target:self action:@selector(entertainmentBarButtonHandler)];
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    self.toolbar.items = @[foodBarButton, flexibleItem, coffeeBarButton, flexibleItem, wineBarButton, flexibleItem, entertainmentBarButton];
    
    [self.scrollContentView addSubview:self.businessNameLabel];
    [self.scrollContentView addSubview:self.businessSubCategoryLabel];
    [self.scrollContentView addSubview:self.businessPhoneNumberLabel];
    [self.scrollContentView addSubview:self.businessAddressLabel];
    [self.scrollContentView addSubview:self.businessURLLabel];
    [self.scrollContentView addSubview:self.venueImageView];

    /*self.imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spaceshuttle.jpg"]];
    NSLog(@"imgView.frame.size.width=%f height=%f", self.imgView.frame.size.width, self.imgView.frame.size.height);
    [self.scrollContentView addSubview:self.imgView];*/
    
    //self.foursquareCreditImageView.frame = CGRectMake(0.0, 0.0, 100.0, 100.0);
    //[self.scrollView addSubview:self.foursquareCreditImageView];
    
    [self.scrollView addSubview:self.scrollContentView];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.toolbar];
    [self.view addSubview:self.foursquareCreditImageView];

    [self scrollContentViewConstraints];
    [self scrollViewConstraints];
    [self businessNameLabelConstraints];
    [self businessSubCategoryLabelConstraints];
    [self businessPhoneNumberLabelConstraints];
    [self businessAddressLabelConstraints];
    [self businessURLLabelConstraints];
    [self venueImageViewConstraints];
    [self foursquareCreditImageViewConstraints];
    [self toolbarConstraints];
    
    [self printFrame:self.scrollContentView.frame];
    [self printFrame:self.scrollView.frame];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getVenuePhotoHandler) name:kQueryCompletedID object:nil];
}

-(void)getVenuePhotoHandler
{
[Foursquare2
     venueGetPhotos:self.venueID
     limit:@3
     offset:@0
 callback:^(BOOL success, id result){
     if (success) {
         NSLog(@"success in getting venue photo");
         NSLog(@"result == %@", result);
         NSDictionary *dic = result;
         NSMutableString *mutStr = [NSMutableString new];
         NSArray *photoDictArray = [dic valueForKeyPath:@"response.photos.items"];
         NSDictionary *photoDict = photoDictArray[0];
         [mutStr appendString:[photoDict valueForKeyPath:@"prefix"]];
         NSNumber *heightNum = [photoDict valueForKeyPath:@"height"];
         //NSLog(@"testNum=%d", [testNum integerValue]);
         NSString *heightStr = [NSString stringWithFormat:@"%d",[heightNum integerValue]];
         [mutStr appendString:heightStr];
         [mutStr appendString:@"x"];
         NSNumber *widthNum = [photoDict valueForKeyPath:@"width"];
         //NSLog(@"testNum=%d", [testNum integerValue]);
         NSString *widthStr = [NSString stringWithFormat:@"%d",[widthNum integerValue]];
         [mutStr appendString:widthStr];
         [mutStr appendString:[photoDict valueForKeyPath:@"suffix"]];
         NSLog(@"photo url=%@", mutStr);
         
         self.venueImage = [UIImage imageWithData:
                            [NSData dataWithContentsOfURL:
                             [NSURL URLWithString:mutStr]]];
         [self.venueImageView setImage:self.venueImage];
         
     } else {
         NSLog(@"failed in getting venue photo");
     }
 }];
    
}

-(void)printFrame:(CGRect)frame
{
    NSLog(@"frame x=%f y=%f wid=%f height=%f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
}

-(void)queryForCategory:(NSString *)category
{
    self.businessNameLabel.text = @"Searching...";
    self.businessSubCategoryLabel.text = @"\t";
    self.businessPhoneNumberLabel.text = @"\t";
    self.businessAddressLabel.text = @"\t";
    self.businessURLLabel.text = @"\t";
    
    NSNumber *numVenues = @3;
    [Foursquare2
     venueSearchNearByLatitude:@(40.75)
     longitude:@(-111.8833)
     query:nil
     limit:numVenues
     intent:intentCheckin
     radius:@(10000)
     categoryId:category
     callback:^(BOOL success, id result){
         if (success) {
             NSDictionary *dic = result;
             //NSLog(@"dic=%@", dic);
             NSArray *venues = [dic valueForKeyPath:@"response.venues"];
             NSLog(@"query success");
             //NSString *nameString = venues[0][@"name"];
             
             int randomIndex = arc4random_uniform([venues count]);
             
             NSString *nameString = [venues[randomIndex] valueForKeyPath:@"name"];
             //NSLog(@"name is %@", nameString);
             if (nameString) {
                 self.businessNameLabel.text = nameString;
             } else {
                 self.businessNameLabel.text = @"No data for business name.";
             }
             
             NSArray *subCategoryArray = [venues[randomIndex] valueForKeyPath:@"categories.name"];
             NSMutableString *mutStr = [NSMutableString new];
             for (NSString *str in subCategoryArray) {
                 [mutStr appendString:[str stringByAppendingString:@"\n"]];
             }
             NSString *subCategoryString = (NSString *)[mutStr substringToIndex:([mutStr length]-1)];
             if (subCategoryString) {
                 //self.businessSubCategoryLabel.text = subCategoryString;
                 self.businessSubCategoryLabel.text = subCategoryString;
             } else {
                 self.businessSubCategoryLabel.text = @"No data for business sub category.";
             }
             
             NSString *phoneNumString = [venues[randomIndex] valueForKeyPath:@"contact.formattedPhone"];
             //NSLog(@"Phone Number is %@", phoneNumString);
             if (phoneNumString) {
                 self.businessPhoneNumberLabel.text = phoneNumString;
             } else {
                 self.businessPhoneNumberLabel.text = @"No data for phone number.";
             }
             
             mutStr = nil;
             mutStr = [NSMutableString new];
             NSString *street = [venues[randomIndex] valueForKeyPath:@"location.address"];
             NSString *city = [venues[randomIndex] valueForKeyPath:@"location.city"];
             NSString *zip = [venues[randomIndex] valueForKeyPath:@"location.postalCode"];
             //NSLog(@"street: %@\ncity: %@\nzip: %@", street, city, zip);
             if (street) {
                 [mutStr appendString:street];
                 [mutStr appendString:@"\n"];
             }
             if (city) {
                 [mutStr appendString:city];
             }
             if (zip) {
                 [mutStr appendString:@", "];
                 [mutStr appendString:zip];
             }
             if (street==nil && city==nil && zip==nil) {
                 [mutStr appendString:@"No data for address."];
             }
             
             NSString *addressString = (NSString *)mutStr;
             if (addressString) {
                 self.businessAddressLabel.text = addressString;
             } else {
                 self.businessAddressLabel.text = @"No data for address.";
             }
             
             NSString *urlString = [venues[randomIndex] valueForKeyPath:@"url"];
             NSLog(@"URL is %@", urlString);
             if (phoneNumString) {
                 self.businessURLLabel.text = urlString;
             } else {
                 self.businessURLLabel.text = @"No data for url.";
             }
             
             //self.venuePhoto = ?;
             self.venueID = [venues[randomIndex] valueForKeyPath:@"id"];
             NSLog(@"venueID=%@", self.venueID);
             
         } else {
             NSLog(@"%@",result);
         }
         [[NSNotificationCenter defaultCenter] postNotificationName:kQueryCompletedID object:self userInfo:nil];
     }];
    
}

-(void)foodBarButtonHandler
{
    NSLog(@"Food!");
    //[self queryForString:@"food"];
    [self queryForCategory:kCategoryFood];
}
 
-(void)coffeeBarButtonHandler
{
    NSLog(@"Coffee!");
    //[self queryForString:@"coffee"];
    [self queryForCategory:kCategoryCoffee];
}

-(void)wineBarButtonHandler
{
    NSLog(@"Wine!");
    //[self queryForString:@"wine"];
    [self queryForCategory:kCategoryWine];
}

-(void)entertainmentBarButtonHandler
{
    NSLog(@"Entertainment!");
    //[self queryForString:@"entertainment"];
    [self queryForCategory:kCategoryEntertainment];
}
                      
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


-(void)businessNameLabelConstraints
{
    NSMutableArray *constraintsMutArr = [NSMutableArray new];
    
    [self.businessNameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *xLeftPosConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.businessNameLabel
                                              attribute:NSLayoutAttributeLeft
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.scrollContentView
                                              attribute:NSLayoutAttributeLeftMargin
                                              multiplier:1.0
                                              constant:0.0];
    [constraintsMutArr addObject:xLeftPosConstraint];
    
    NSLayoutConstraint *xRightPosConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.businessNameLabel
                                              attribute:NSLayoutAttributeRight
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.scrollContentView
                                              attribute:NSLayoutAttributeRightMargin
                                              multiplier:1.0
                                              constant:0.0];
    [constraintsMutArr addObject:xRightPosConstraint];
    
    NSLayoutConstraint *yTopPosConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.businessNameLabel
                                             attribute:NSLayoutAttributeTop
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.scrollContentView
                                             attribute:NSLayoutAttributeTop
                                             multiplier:1.0
                                             constant:0.0];
    [constraintsMutArr addObject:yTopPosConstraint];
    
    [self.scrollContentView addConstraints:constraintsMutArr];
    self.businessNameLabel.numberOfLines = 0; // this should autoresize for multiple lines
    
    
    constraintsMutArr = nil;
    constraintsMutArr = [NSMutableArray new];
}

-(void)businessSubCategoryLabelConstraints
{
    NSMutableArray *constraintsMutArr = [NSMutableArray new];
    
    [self.businessSubCategoryLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *yTopPosConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.businessSubCategoryLabel
                                             attribute:NSLayoutAttributeTop
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.businessNameLabel
                                             attribute:NSLayoutAttributeBottom
                                             multiplier:1.0
                                             constant:0.0];
    [constraintsMutArr addObject:yTopPosConstraint];
    
    NSLayoutConstraint *xLeftPosConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.businessSubCategoryLabel
                                              attribute:NSLayoutAttributeLeft
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.scrollContentView
                                              attribute:NSLayoutAttributeLeftMargin
                                              multiplier:1.0
                                              constant:0.0];
    [constraintsMutArr addObject:xLeftPosConstraint];
    
    NSLayoutConstraint *xRightPosConstraint = [NSLayoutConstraint
                                               constraintWithItem:self.businessSubCategoryLabel
                                               attribute:NSLayoutAttributeRight
                                               relatedBy:NSLayoutRelationEqual
                                               toItem:self.scrollContentView
                                               attribute:NSLayoutAttributeRightMargin
                                               multiplier:1.0
                                               constant:0.0];
    [constraintsMutArr addObject:xRightPosConstraint];
    
    [self.scrollContentView addConstraints:constraintsMutArr];
    self.businessSubCategoryLabel.numberOfLines = 0;
}

-(void)businessPhoneNumberLabelConstraints
{
    NSMutableArray *constraintsMutArr = [NSMutableArray new];
    
    [self.businessPhoneNumberLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *yTopPosConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.businessPhoneNumberLabel
                                             attribute:NSLayoutAttributeTop
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.businessSubCategoryLabel
                                             attribute:NSLayoutAttributeBottom
                                             multiplier:1.0
                                             constant:0.0];
    [constraintsMutArr addObject:yTopPosConstraint];
    
    NSLayoutConstraint *xLeftPosConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.businessPhoneNumberLabel
                                              attribute:NSLayoutAttributeLeft
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.scrollContentView
                                              attribute:NSLayoutAttributeLeftMargin
                                              multiplier:1.0
                                              constant:0.0];
    [constraintsMutArr addObject:xLeftPosConstraint];
    
    NSLayoutConstraint *xRightPosConstraint = [NSLayoutConstraint
                                               constraintWithItem:self.businessPhoneNumberLabel
                                               attribute:NSLayoutAttributeRight
                                               relatedBy:NSLayoutRelationEqual
                                               toItem:self.scrollContentView
                                               attribute:NSLayoutAttributeRightMargin
                                               multiplier:1.0
                                               constant:0.0];
    [constraintsMutArr addObject:xRightPosConstraint];
    
    [self.scrollContentView addConstraints:constraintsMutArr];
    self.businessPhoneNumberLabel.numberOfLines = 0;
}

-(void)businessAddressLabelConstraints
{
    NSMutableArray *constraintsMutArr = [NSMutableArray new];
    
    [self.businessAddressLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *yTopPosConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.businessAddressLabel
                                             attribute:NSLayoutAttributeTop
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.businessPhoneNumberLabel
                                             attribute:NSLayoutAttributeBottom
                                             multiplier:1.0
                                             constant:0.0];
    [constraintsMutArr addObject:yTopPosConstraint];
    
    NSLayoutConstraint *xLeftPosConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.businessAddressLabel
                                              attribute:NSLayoutAttributeLeft
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.scrollContentView
                                              attribute:NSLayoutAttributeLeftMargin
                                              multiplier:1.0
                                              constant:0.0];
    [constraintsMutArr addObject:xLeftPosConstraint];
    
    NSLayoutConstraint *xRightPosConstraint = [NSLayoutConstraint
                                               constraintWithItem:self.businessAddressLabel
                                               attribute:NSLayoutAttributeRight
                                               relatedBy:NSLayoutRelationEqual
                                               toItem:self.scrollContentView
                                               attribute:NSLayoutAttributeRightMargin
                                               multiplier:1.0
                                               constant:0.0];
    [constraintsMutArr addObject:xRightPosConstraint];
    
    [self.scrollContentView addConstraints:constraintsMutArr];
    self.businessAddressLabel.numberOfLines = 0;
}

-(void)businessURLLabelConstraints
{
    NSMutableArray *constraintsMutArr = [NSMutableArray new];
    
    [self.businessURLLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *yTopPosConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.businessURLLabel
                                             attribute:NSLayoutAttributeTop
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.businessAddressLabel
                                             attribute:NSLayoutAttributeBottom
                                             multiplier:1.0
                                             constant:0.0];
    [constraintsMutArr addObject:yTopPosConstraint];
    
    NSLayoutConstraint *xLeftPosConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.businessURLLabel
                                              attribute:NSLayoutAttributeLeft
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.scrollContentView
                                              attribute:NSLayoutAttributeLeftMargin
                                              multiplier:1.0
                                              constant:0.0];
    [constraintsMutArr addObject:xLeftPosConstraint];
    
    NSLayoutConstraint *xRightPosConstraint = [NSLayoutConstraint
                                               constraintWithItem:self.businessURLLabel
                                               attribute:NSLayoutAttributeRight
                                               relatedBy:NSLayoutRelationEqual
                                               toItem:self.scrollContentView
                                               attribute:NSLayoutAttributeRightMargin
                                               multiplier:1.0
                                               constant:0.0];
    [constraintsMutArr addObject:xRightPosConstraint];
    
/*    NSLayoutConstraint *yBotPosConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.businessURLLabel
                                             attribute:NSLayoutAttributeBottom
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.scrollContentView
                                             attribute:NSLayoutAttributeBottom
                                             multiplier:1.0
                                             constant:0.0];
    [constraintsMutArr addObject:yBotPosConstraint];*/
    
    [self.scrollContentView addConstraints:constraintsMutArr];
    self.businessURLLabel.numberOfLines = 0;
}

-(void)venueImageViewConstraints
{
    NSMutableArray *constraintsMutArr = [NSMutableArray new];
    
    [self.venueImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *yTopPosConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.venueImageView
                                             attribute:NSLayoutAttributeTop
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.businessURLLabel
                                             attribute:NSLayoutAttributeBottom
                                             multiplier:1.0
                                             constant:0.0];
    [constraintsMutArr addObject:yTopPosConstraint];
    
    NSLayoutConstraint *xLeftPosConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.venueImageView
                                              attribute:NSLayoutAttributeLeft
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.scrollContentView
                                              attribute:NSLayoutAttributeLeftMargin
                                              multiplier:1.0
                                              constant:0.0];
    [constraintsMutArr addObject:xLeftPosConstraint];
    
    /*NSLayoutConstraint *xRightPosConstraint = [NSLayoutConstraint
                                               constraintWithItem:self.venueImageView
                                               attribute:NSLayoutAttributeRight
                                               relatedBy:NSLayoutRelationEqual
                                               toItem:self.scrollContentView
                                               attribute:NSLayoutAttributeRightMargin
                                               multiplier:1.0
                                               constant:0.0];
    [constraintsMutArr addObject:xRightPosConstraint];*/
    
    NSLayoutConstraint *yBotPosConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.venueImageView
                                             attribute:NSLayoutAttributeBottom
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.scrollContentView
                                             attribute:NSLayoutAttributeBottom
                                             multiplier:1.0
                                             constant:0.0];
    [constraintsMutArr addObject:yBotPosConstraint];
    
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.venueImageView
                                             attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:nil
                                             attribute:NSLayoutAttributeNotAnAttribute
                                             multiplier:1.0
                                             constant:100.0];
    [constraintsMutArr addObject:widthConstraint];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.venueImageView
                                             attribute:NSLayoutAttributeHeight
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.venueImageView
                                             attribute:NSLayoutAttributeWidth
                                             multiplier:1.0
                                             constant:0.0];
    [constraintsMutArr addObject:heightConstraint];
    
    [self.scrollContentView addConstraints:constraintsMutArr];
}

-(void)scrollContentViewConstraints
{
    NSMutableArray *constraintsMutArr = [NSMutableArray new];
    
    [self.scrollContentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.scrollContentView
                                             attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.view
                                             attribute:NSLayoutAttributeWidth
                                             multiplier:1.0
                                             constant:0.0];
    [constraintsMutArr addObject:widthConstraint];
    
    [self.view addConstraints:constraintsMutArr];
    
    /*NSLayoutConstraint *heightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.scrollContentView
                                             attribute:NSLayoutAttributeHeight
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.view
                                             attribute:NSLayoutAttributeHeight
                                             multiplier:2.0
                                             constant:0.0];
    [constraintsMutArr addObject:heightConstraint];
    
    [self.view addConstraints:constraintsMutArr];*/
    
   /* NSMutableArray *constraintsMutArr = [NSMutableArray new];
    
    [self.scrollContentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.scrollContentView
                                             attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.imgView
                                             attribute:NSLayoutAttributeWidth
                                             multiplier:1.0
                                             constant:0.0];
    [constraintsMutArr addObject:widthConstraint];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.scrollContentView
                                             attribute:NSLayoutAttributeHeight
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.imgView
                                             attribute:NSLayoutAttributeHeight
                                             multiplier:1.0
                                             constant:0.0];
    [constraintsMutArr addObject:heightConstraint];
    
    //[self.scrollContentView addConstraints:constraintsMutArr];*/
    
    NSMutableArray *svConstraintsMutArr = [NSMutableArray new];
    
    NSLayoutConstraint *yTopPosConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.scrollContentView
                                             attribute:NSLayoutAttributeTop
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.scrollView
                                             attribute:NSLayoutAttributeTop
                                             multiplier:1.0
                                             constant:0.0];
    [svConstraintsMutArr addObject:yTopPosConstraint];
    
    NSLayoutConstraint *yBotPosConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.scrollContentView
                                             attribute:NSLayoutAttributeBottom
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.scrollView
                                             attribute:NSLayoutAttributeBottom
                                             multiplier:1.0
                                             constant:0.0];
    [svConstraintsMutArr addObject:yBotPosConstraint];
    
    NSLayoutConstraint *xLeftPosConstraint = [NSLayoutConstraint
                                               constraintWithItem:self.scrollContentView
                                               attribute:NSLayoutAttributeLeading
                                               relatedBy:NSLayoutRelationEqual
                                               toItem:self.scrollView
                                               attribute:NSLayoutAttributeLeft
                                               multiplier:1.0
                                               constant:0.0];
    [svConstraintsMutArr addObject:xLeftPosConstraint];
    
    NSLayoutConstraint *xRightPosConstraint = [NSLayoutConstraint
                                               constraintWithItem:self.scrollContentView
                                               attribute:NSLayoutAttributeTrailing
                                               relatedBy:NSLayoutRelationEqual
                                               toItem:self.scrollView
                                               attribute:NSLayoutAttributeRight
                                               multiplier:1.0
                                               constant:0.0];
    [svConstraintsMutArr addObject:xRightPosConstraint];
    
    [self.scrollView addConstraints:svConstraintsMutArr];
}

-(void)scrollViewConstraints
{
    NSMutableArray *constraintsMutArr = [NSMutableArray new];
    
    [self.scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *yTopPosConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.scrollView
                                             attribute:NSLayoutAttributeTop
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.view
                                             attribute:NSLayoutAttributeTop
                                             multiplier:1.0
                                             constant:0.0];
    [constraintsMutArr addObject:yTopPosConstraint];
    
    NSLayoutConstraint *yBotPosConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.scrollView
                                             attribute:NSLayoutAttributeBottom
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.toolbar
                                             attribute:NSLayoutAttributeTop
                                             multiplier:1.0
                                             constant:0.0];
    [constraintsMutArr addObject:yBotPosConstraint];
    
    NSLayoutConstraint *xLeftPosConstraint = [NSLayoutConstraint
                                               constraintWithItem:self.scrollView
                                               attribute:NSLayoutAttributeLeft
                                               relatedBy:NSLayoutRelationEqual
                                               toItem:self.view
                                               attribute:NSLayoutAttributeLeft
                                               multiplier:1.0
                                               constant:0.0];
    [constraintsMutArr addObject:xLeftPosConstraint];
    
    NSLayoutConstraint *xRightPosConstraint = [NSLayoutConstraint
                                               constraintWithItem:self.scrollView
                                               attribute:NSLayoutAttributeRight
                                               relatedBy:NSLayoutRelationEqual
                                               toItem:self.view
                                               attribute:NSLayoutAttributeRight
                                               multiplier:1.0
                                               constant:0.0];
    [constraintsMutArr addObject:xRightPosConstraint];
    
    [self.view addConstraints:constraintsMutArr];
}

-(void)foursquareCreditImageViewConstraints
{
    NSMutableArray *constraintsMutArr = [NSMutableArray new];
    
    [self.foursquareCreditImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *yBotPosConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.foursquareCreditImageView
                                             attribute:NSLayoutAttributeBottom
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.toolbar
                                             attribute:NSLayoutAttributeTop
                                             multiplier:1.0
                                             constant:10.0];
    [constraintsMutArr addObject:yBotPosConstraint];
    
    NSLayoutConstraint *xRightPosConstraint = [NSLayoutConstraint
                                               constraintWithItem:self.foursquareCreditImageView
                                               attribute:NSLayoutAttributeRight
                                               relatedBy:NSLayoutRelationEqual
                                               toItem:self.view
                                               attribute:NSLayoutAttributeRight
                                               multiplier:1.0
                                               constant:0.0];
    [constraintsMutArr addObject:xRightPosConstraint];
    
    [self.view addConstraints:constraintsMutArr];
}


-(void)toolbarConstraints
{
    NSMutableArray *constraintsMutArr = [NSMutableArray new];
    
    [self.toolbar setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *xLeftPosConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.toolbar
                                              attribute:NSLayoutAttributeLeft
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.view
                                              attribute:NSLayoutAttributeLeft
                                              multiplier:1.0
                                              constant:0.0];
    [constraintsMutArr addObject:xLeftPosConstraint];
    
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint
                                               constraintWithItem:self.toolbar
                                               attribute:NSLayoutAttributeWidth
                                               relatedBy:NSLayoutRelationEqual
                                               toItem:self.view
                                               attribute:NSLayoutAttributeWidth
                                               multiplier:1.0
                                               constant:0.0];
    [constraintsMutArr addObject:widthConstraint];

    
    NSLayoutConstraint *yBotPosConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.toolbar
                                             attribute:NSLayoutAttributeBottom
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.view
                                             attribute:NSLayoutAttributeBottom
                                             multiplier:1.0
                                             constant:0.0];
    [constraintsMutArr addObject:yBotPosConstraint];
    
    [self.view addConstraints:constraintsMutArr];
}

@end
