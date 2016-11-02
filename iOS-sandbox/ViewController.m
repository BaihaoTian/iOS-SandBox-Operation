//
//  ViewController.m
//  iOS-sandbox
//
//  Created by Bc.whi1te_Lei on 2016/11/2.
//  Copyright © 2016年 Bc.whi1te_Lei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
#pragma mark - 审核简介
    /*
     --概念:每个iOS应用都有自己的应用沙盒，应用沙盒就是文件系统目录。
     --核心:sandbox对应用程序执行各种操作的权限限制
     --特点:
     1.每个应用程序的活动范围都限定在自己的沙盒里
     2.不能随意跨越自己的沙盒去访问别的应用程序沙盒中的内容
     （iOS8已经部分开放访问extension）
     3.在访问别人沙盒内的数据时需要访问权限。
     --概括:
     1.是一种安全体系的表现
     2.总体来说沙盒就是一种独立、安全、封闭的空间。
     3.非代码文件都要保存在此，例如图像，图标，声音，映像，属性列表，文本文件等。
     --*注意:  APP之间不能相互通,唯独可以通过URL Scheme可以通信
     */
    
#pragma mark - 沙盒目录作用
     /*
     -- Documents：保存应用运行时生成的需要持久化的数据,iTunes会自动备份该目录。
     苹果建议将在应用程序中浏览到的文件数据保存在该目录下。
     -- Library:
     Caches：
     一般存储的是缓存文件，例如图片视频等，此目录下的文件不会再应用程序退出时删除。
     *在手机备份的时候，iTunes不会备份该目录。
     例如音频,视频等文件存放其中
     Preferences：
     保存应用程序的所有偏好设置iOS的Settings(设置)，我们不应该直接在这里创建文件，
     而是需要通过NSUserDefault这个类来访问应用程序的偏好设置。
     *iTunes会自动备份该文件目录下的内容。
     比如说:是否允许访问图片,是否允许访问地理位置......
     -- tmp：临时文件目录，在程序重新运行的时候，和开机的时候，会清空tmp文件夹。
     */
    
    
#pragma mark - 获取沙盒各目录路径
    /*
     
     获取沙盒各目录路径
     
     */
    
    //获取根目录
    NSString *homePath = NSHomeDirectory();
    NSLog(@"Home目录：%@",homePath);
    
    /* 获取Documents文件夹目录,
     @param NSDocumentDirectory  获取Document目录
     @param NSUserDomainMask     是在当前沙盒范围内查找
     @param YES                  展开路径，NO是不展开
     @return test.txt文件的路径
     */
    NSString *docPath =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)firstObject];
    
    NSLog(@"Documents目录：%@",docPath);
    
  
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask, YES)firstObject];
    NSLog(@"Library目录：%@",libraryPath);
    
    NSString *libraryCachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES)firstObject];
    NSLog(@"Library/Cache目录:%@",libraryCachePath);
    
    NSString *libraryPreferencesPath = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                                             NSUserDomainMask, YES)firstObject]stringByAppendingPathComponent:@"Preferences"];
    NSLog(@"library/Preferences目录：%@",libraryPreferencesPath);
    
    NSString *tmpPath = NSTemporaryDirectory();
    NSLog(@"tmp目录:%@",tmpPath);


#pragma mark - 沙盒读写文件
    
 
    //向沙盒中写入文件
    NSString *documentsPathW = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)[0];
    //写入文件
    if (!documentsPathW) {
        NSLog(@"目录未找到");
    }else {
        NSString *filePaht = [documentsPathW stringByAppendingPathComponent:@"test.txt"];
        NSArray *array = [NSArray arrayWithObjects:@"code",@"change", @"world", @"OK", @"", @"是的", nil];
        [array writeToFile:filePaht atomically:YES];}
    
    
    
    
    //从沙盒中读取文件
    NSString *documentsPathR = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)[0];
    NSString *readPath = [documentsPathR stringByAppendingPathComponent:@"test.txt"];
    NSArray *fileContent = [[NSArray alloc] initWithContentsOfFile:readPath];
    NSLog(@"文件内容：%@",fileContent);
    
#pragma mark - 代码获取应用程序包的目录与内容
    //    -- 程序包文件，包含了资源文件和可执行文件AppName.app
    NSString *appPath = [NSBundle mainBundle].resourcePath;
    NSLog(@"bundle目录：%@",appPath);
    
    NSString *imagePath = [[NSBundle mainBundle]pathForResource:@"123" ofType:@"jpeg"];
    /*
     1.imageWithname这种加载的方式的是有缓存的，第二次在加载时直接从内存中取出图片，
     这样的话效率更高，但是会使得内存变得越来越大，通常使用在，图片内存较小，
     而且需要频繁使用的地方。
     2.NSBundle mainBundle 是通过获取图片的全路径来加载图片的，
     不会有缓存，但是这样每次就得重新加载，它也不会是在不是在使用完图片后就释放，
     而是在下一次使用图片的时候才会释放，所以需要我们在使用完图片后，手动来释放内存。
     */
    NSLog(@"imagePath目录：%@",imagePath);

    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
