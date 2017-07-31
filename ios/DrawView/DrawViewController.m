//
//  DrawViewController.m
//  imageCropPicker
//
//  Created by fanruliang on 2017/7/11.
//  Copyright © 2017年 Ivan Pusic. All rights reserved.
//

#import "DrawViewController.h"
#import "TMScrollView.h"
@interface DrawViewController ()
{
    TMScrollView *scrollView;
    void (^block)(UIImage *);
    UIImage *_image;
    UIButton *btnEdit;
}
@end

@implementation DrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"编辑";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (scrollView == nil) {
        
        scrollView = [[TMScrollView alloc]initWithFrame:self.view.bounds];
        scrollView.image = _image;
        scrollView.isEdit = YES;
        [self.view addSubview:scrollView];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-40, self.view.frame.size.width, 40)];
        view.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:view];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10, 0, 80, 40);
        [btn addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"缩放" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [view addSubview:btn];
        btnEdit = btn;
        
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(100, 0, 80, 40);
        [btn1 addTarget:self action:@selector(revocAction) forControlEvents:UIControlEventTouchUpInside];
        [btn1 setTitle:@"撤销" forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [view addSubview:btn1];
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(190, 0, 80, 40);
        [btn2 addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
        [btn2 setTitle:@"清除" forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [view addSubview:btn2];
    }
}

-(void)setImage:(UIImage *)image crop:(void (^)(UIImage *))cropBlock
{
    _image = image;
    block = cropBlock;
}

-(void)clear
{
    [scrollView clear];
    
}

-(void)revocAction
{
    [scrollView revocAction];
}

-(void)edit
{
    if (scrollView.isEdit) {
        [btnEdit setTitle:@"编辑" forState:UIControlStateNormal];
    }
    else
    {
        [btnEdit setTitle:@"缩放" forState:UIControlStateNormal];
    }
    scrollView.isEdit = !scrollView.isEdit;
}

-(void)cancel
{
    block(_image);
}

-(void)save
{
    block([scrollView cropImage]);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
