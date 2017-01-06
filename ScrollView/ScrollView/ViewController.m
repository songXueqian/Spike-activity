//
//  ViewController.m
//  ScrollView
//
//  Created by 宋学谦 on 2017/1/4.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

/*
 
仿淘宝 秒杀活动 
上面时间轴（根据后台返回数据）自定义TimeStatusView
下面collectionView 每个cell里是1个tableView
得用scrollView代理方法完成实现
 
 
*/


#import "ViewController.h"
#import "CollectionViewCell.h"
#import "TimeStatusView.h"


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)NSMutableArray *array;
@property (nonatomic, strong)NSMutableArray *viewArray;

@property (nonatomic, strong)NSMutableArray *offsetArray;
@property (nonatomic, strong)UIImageView *redImage;
@property (nonatomic, assign)NSInteger number;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    self.offsetArray = [NSMutableArray array];
    self.dataCollectionArray = [NSMutableArray array];
    self.viewArray = [NSMutableArray array];
    self.array = [NSMutableArray arrayWithObjects:[UIColor blackColor], [UIColor whiteColor], [UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor cyanColor], [UIColor yellowColor], [UIColor magentaColor], [UIColor orangeColor], [UIColor purpleColor], [UIColor brownColor], [UIColor grayColor], nil];
    
    
    //滚动时间ScrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 46.5)];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    
    //自定义TimeStatusView(滚动时间View)
    
    int j = 6;//假数据
    //为了scrollView可以向左滑，0:00显示出来， 加了两个 @"" 字符串
    self.dataCollectionArray = [NSMutableArray arrayWithObjects:@"", @"", @"0:00", @"1:00", @"2:00", @"3:00", @"4:00", @"5:00", @"6:00", @"7:00", @"8:00", @"9:00", @"10:00", @"11:00", @"12:00", nil];
    
    //循环自定义TimeStatusView(根据数据有多少个循环多少个) 假数据显示15个 前两个为空
    for (int i = 0; i < self.dataCollectionArray.count; i++) {
        
        TimeStatusView *timeView = [[TimeStatusView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 5 * i, 0, SCREEN_WIDTH / 5, self.scrollView.frame.size.height)];
        timeView.timeLabel.text = [self.dataCollectionArray objectAtIndex:i];
        timeView.statusLabel.text = @"即将开抢";
        timeView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selected:)];
        [timeView addGestureRecognizer:tap];
        //有一个View 就添加到viewArray数组中
        [self.viewArray addObject:timeView];
        [self.scrollView addSubview:timeView];
        
        //前两个空字符串 不显示字
        if (0 == i || 1 == i) {
            timeView.timeLabel.textColor = [UIColor clearColor];
            timeView.statusLabel.textColor = [UIColor clearColor];
            timeView.timeLabel.text = @"";
            timeView.statusLabel.text = @"";
            
        }
        
        
        
    }
    
    
    
    //scrollView 偏移量 （j = 6, 显示在屏幕中间位置，整屏分5份，应减2, 因为加入两个空字符串，所以不变j）
    self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH / 5 * j, 0);
    //scrollView 滚动范围 (+ SCREEN_WIDTH / 5 * 2 是因为能让最后两个时间 11:00, 12:00 显示出来)
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH / 5 * self.dataCollectionArray.count + SCREEN_WIDTH / 5 * 2, 0);
    
    //因为加入两个空字符串，所以当前j是一4:00, 所以 j + 2 才是 6:00
    int g;
    g = j + 2;
    TimeStatusView *timeView = [self.viewArray objectAtIndex:g];
    timeView.timeLabel.textColor = [UIColor blackColor];
    timeView.statusLabel.textColor =  [UIColor blackColor];
    timeView.statusLabel.text = @"正在疯抢";
    
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    for (int a = 0; a < self.viewArray.count; a++) {
        // a >= 8 当取到 @"正在疯抢" 以后的时间时，把它们放到dataArray中
        if (a >= g) {
            [dataArray addObject:[self.viewArray objectAtIndex:a]];
        }
    }
    
    //g = 8  从self.viewArray数组中第8项开始，到最后结束，共7项 15-8=7
    //设置一个删除范围
    NSRange range = NSMakeRange(g, self.viewArray.count - g);
    //删除后数组
    [self.viewArray removeObjectsInRange:range];
    
    for (TimeStatusView *timeView in self.viewArray) {
        timeView.statusLabel.text = @"已经过季";
        timeView.statusLabel.textColor = [UIColor colorWithRed:0.76 green:0.76 blue:0.76 alpha:1.00];
    }
    
    //前两个空字符串 不显示字
    TimeStatusView *timeView2 = [self.viewArray objectAtIndex:0];
    timeView2.statusLabel.text = @"";
    timeView2.statusLabel.textColor = [UIColor clearColor];
    
    TimeStatusView *timeView3 = [self.viewArray objectAtIndex:1];
    timeView3.statusLabel.text = @"";
    timeView3.statusLabel.textColor = [UIColor clearColor];
    
    
    //把前面保存的dataArray加回来给 self.viewArray，后面还用到self.viewArray
    [self.viewArray addObjectsFromArray:dataArray];
    
    
    //collectionView 假数据 没有空字符串了〜〜〜
    self.dataCollectionArray = [NSMutableArray arrayWithObjects:@"0:00", @"1:00", @"2:00", @"3:00", @"4:00", @"5:00", @"6:00", @"7:00", @"8:00", @"9:00", @"10:00", @"11:00", @"12:00", nil];
    
    
    
    //collectionView
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 46.5);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 左右
    flowLayout.minimumInteritemSpacing = 0;
    // 上下
    flowLayout.minimumLineSpacing = 0;
    
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 46.5, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 46.5) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor redColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    self.collectionView.pagingEnabled = YES;
    
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"三"];
    
    // collectionView偏移量（没有空字符串了，所以 j 是几就 SCREEN_WIDTH * j）
    self.collectionView.contentOffset = CGPointMake(SCREEN_WIDTH * j, 0);
    
    
    // 红色透明图片
    self.redImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - (SCREEN_WIDTH / 5 / 2), 0, SCREEN_WIDTH / 5, self.scrollView.frame.size.height)];
    self.redImage.backgroundColor = [UIColor redColor];
    self.redImage.alpha = 0.4;
    [self.view addSubview:self.redImage];
    
    
    
    
    
    
}


#pragma mark -- collectionView  的代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataCollectionArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"三" forIndexPath:indexPath];
    
    if (6 == indexPath.item) {
        cell.tableView.backgroundColor = [self.array objectAtIndex:indexPath.item];
    }
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
}

//滚动时间表点击事件
- (void)selected:(UITapGestureRecognizer *)action{
    //前两个空字符串 点击不发生变化
    if (0 == action.view.tag|| 1 == action.view.tag) {
        
        self.scrollView.contentOffset = CGPointMake(0, 0);
        
    } else {
        //self.scrollView.contentOffset 因为前两个空字符串 所以点击手势触发tag值 多两个， 要减掉SCREEN_WIDTH / 5 * 2
        self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH / 5 * action.view.tag - (SCREEN_WIDTH / 5 * 2), 0);
        NSLog(@"contOffset ==== %f", self.scrollView.contentOffset.x);
        
        self.number = 1;
        self.collectionView.contentOffset = CGPointMake(self.scrollView.contentOffset.x * 5, 0);
        NSLog(@"collectionView ==== %f", self.collectionView.contentOffset.x);
        
        
        //字体变黑
        TimeStatusView *timeView = [self.viewArray objectAtIndex:action.view.tag];
        timeView.timeLabel.textColor = [UIColor blackColor];
        timeView.statusLabel.textColor =  [UIColor blackColor];
        
        
        //点击的TimeStatusView存放起来
        UIView *view2 = [self.viewArray objectAtIndex:action.view.tag];
        
        //从数组中删除 点击的TimeStatusView
        [self.viewArray removeObjectAtIndex:action.view.tag];
        
        //数组中剩下的TimeStatusView For循环 全部变白
        for (TimeStatusView *timeView in self.viewArray) {
            timeView.backgroundColor = [UIColor whiteColor];
            timeView.timeLabel.textColor = [UIColor colorWithRed:0.49 green:0.49 blue:0.49 alpha:1.00];
            timeView.statusLabel.textColor = [UIColor colorWithRed:0.76 green:0.76 blue:0.76 alpha:1.00];
        }
        
        //最后把删除的TimeStatusView插入回来，放在之前的位置
        [self.viewArray insertObject:view2 atIndex:action.view.tag];
        
        
        //此处可以刷新数据，走接口
    }

}

//scrollView滚动代理（ collectionView 滚动代理） collectionView滚动时偏移量发生变化,self.scrollView偏移量跟随变化 (只要collectionView偏移量发生变化，self.scrollView偏移量就跟随变化)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == self.collectionView) {
        if (1 == self.number) {
            //1 == self.number collectionView偏移量不变化 上面方法中已经变化 为了不影响self.scrollView变动
            self.number = 2;
        } else {
            self.scrollView.contentOffset = CGPointMake(self.collectionView.contentOffset.x / 5, 0);
            
            //字体变黑
            float num = self.scrollView.contentOffset.x / (SCREEN_WIDTH / 5) + 2;
            int a;//四舍五入取整
            a = (int)(num + 0.5);
            TimeStatusView *timeView = [self.viewArray objectAtIndex:a];
            timeView.timeLabel.textColor = [UIColor blackColor];
            timeView.statusLabel.textColor =  [UIColor blackColor];
            
            //点击的TimeStatusView存放起来
            UIView *view2 = [self.viewArray objectAtIndex:num];
            
            //从数组中删除 点击的TimeStatusView
            [self.viewArray removeObjectAtIndex:num];
            
            //数组中剩下的TimeStatusView For循环 全部变白
            for (TimeStatusView *timeView in self.viewArray) {
                timeView.backgroundColor = [UIColor whiteColor];
                timeView.timeLabel.textColor = [UIColor colorWithRed:0.49 green:0.49 blue:0.49 alpha:1.00];
                timeView.statusLabel.textColor = [UIColor colorWithRed:0.76 green:0.76 blue:0.76 alpha:1.00];
            }
            //最后把删除的TimeStatusView插入回来，放在之前的位置
            [self.viewArray insertObject:view2 atIndex:num];
            
            
            //此处可以刷新数据，走接口
        }
        
    }
    
}


//scrollView结束滚动方法  (BOOL)decelerate有没有减速动画 （如果有 才会走下一个的方法 scrollViewDidEndDecelerating） 
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (scrollView == self.scrollView) {
        if (decelerate == YES) {
            NSLog(@"减速减速减速减速减速减速！！！〜〜〜");
        } else {
            NSLog(@"前 ==== %f", self.scrollView.contentOffset.x);
            // 总偏移量 / 一个时间的宽度 等于第几个
            float f = self.scrollView.contentOffset.x / (SCREEN_WIDTH / 5);
            int a,b;
            a = (int)(f+0.5); //四舍五入取整
            b = a * SCREEN_WIDTH / 5;
            
            //滚动scrollView时，scrollView，collectionView偏移量发生变化
            self.scrollView.contentOffset = CGPointMake(b, 0);
            NSLog(@"后 ==== %f", self.scrollView.contentOffset.x);
            
            self.collectionView.contentOffset = CGPointMake(self.scrollView.contentOffset.x * 5, 0);
            //此处可以刷新数据，走接口
        }
    }
}

//scrollView动画结束方法(上面方法中 (BOOL)decelerate == YES 时才走这个方法) （快速滑动）
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.scrollView) {
        
        // 总偏移量 / 一个时间的宽度 等于第几个
        float f = self.scrollView.contentOffset.x / (SCREEN_WIDTH / 5);
        int a,b;
        a = (int)(f+0.5); //四舍五入取整
        b = a * SCREEN_WIDTH / 5;
        
        //滚动scrollView时，scrollView，collectionView偏移量发生变化
        self.scrollView.contentOffset = CGPointMake(b, 0);
        
        self.collectionView.contentOffset = CGPointMake(self.scrollView.contentOffset.x * 5, 0);
        //此处可以刷新数据，走接口
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
