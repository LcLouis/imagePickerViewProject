//
//  textBookViewController.m
//  imagePickerViewProject
//
//  Created by Lc、 on 16/4/21.
//  Copyright © 2016年 Lc、. All rights reserved.
//

#import "textBookViewController.h"
#import <CoreText/CoreText.h>

#define kGlobalLineLeading 5
#define kPerLineRatio 1.4

@interface textBookViewController ()

@property (nonatomic, assign) NSRange range; //记录上一次位置



@end

@implementation textBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
//    NSURL * url = nil;
//    url = [[NSBundle mainBundle] URLForResource:@"盗墓笔记 2.txt" withExtension:nil];
//    NSMutableAttributedString *attributedTextHolder = [[NSMutableAttributedString alloc] initWithFileURL:url options:@{} documentAttributes:nil error:nil];
//    [attributedTextHolder addAttribute:NSFontAttributeName value:[UIFont preferredFontForTextStyle:UIFontTextStyleBody] range:NSMakeRange(0, attributedTextHolder.length)];
//     NSLog(@"%@", attributedTextHolder);
    
    
    
    NSStringEncoding gbkEncoding =
    CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"盗墓笔记 2" ofType:@"txt"];
    NSMutableString * pageSource = [[NSMutableString alloc]initWithContentsOfFile:path encoding:gbkEncoding error:nil];
//    NSString *pageSource = [[NSString alloc]initWithContentsOfFile:path encoding:gbkEncoding error:nil];
//    NSLog(@"%@",pageSource);
    NSMutableAttributedString * attributedTextHolder = [[NSMutableAttributedString alloc]initWithString:pageSource];
    [attributedTextHolder addAttribute:NSFontAttributeName value:UIFontTextStyleBody range:NSMakeRange(0, attributedTextHolder.length)];
    
    
    NSLog(@"%f--%f",self.view.frame.size.height,self.view.frame.size.width);
    
    
    [self caluteBookPageWithString:pageSource];
    
    
}


-(int)caluteBookPageWithString:(NSMutableString *)sourceString
{
    
    CGSize size = self.view.frame.size;
    
    int numChara = 400;
    
    NSString * string = [sourceString substringWithRange:NSMakeRange(0, numChara)];
    NSLog(@"%@",string);
    CGFloat height = [textBookViewController textHeightWithText3:string width:self.view.frame.size.width font:[UIFont systemFontOfSize:14]];
    
    while (height<600) {
        numChara  += 1;
        NSString * string = [sourceString substringWithRange:NSMakeRange(0, numChara)];
        NSLog(@"%@",string);
        
        height = [textBookViewController textHeightWithText3:string width:self.view.frame.size.width font:[UIFont systemFontOfSize:14]];
        
    }
    
    while (height > 667) {
        numChara -= 1;
        NSString * string = [sourceString substringWithRange:NSMakeRange(0, numChara)];
        NSLog(@"%@",string);
        height = [textBookViewController textHeightWithText3:string width:self.view.frame.size.width font:[UIFont systemFontOfSize:14]];
    }
    
    
    
    
    NSLog(@"%f",height);
    
    
    
    
    return 100;
}



//计算高度的代码：
+ (CGFloat)textHeightWithText3:(NSString *)aText width:(CGFloat)aWidth font:(UIFont *)aFont
{
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:aText];
    
    // 设置全局样式
    [self addGlobalAttributeWithContent:content font:aFont];
    
    CTFramesetterRef framesetterRef = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)content);
    
    CGSize suggestSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetterRef, CFRangeMake(0, aText.length), NULL, CGSizeMake(aWidth, MAXFLOAT), NULL);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, aWidth, suggestSize.height*10)); // 10这个数值是随便给的，主要是为了确保高度足够
    
    
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetterRef, CFRangeMake(0, aText.length), path, NULL);
    
    CFArrayRef lines = CTFrameGetLines(frameRef);
    CFIndex lineCount = CFArrayGetCount(lines);
    
    CGFloat ascent = 0;
    CGFloat descent = 0;
    CGFloat leading = 0;
    
    CGFloat totalHeight = 0;
    
    NSLog(@"计算高度开始");
    for (CFIndex i = 0; i < lineCount; i++)
    {
        
        CTLineRef lineRef = CFArrayGetValueAtIndex(lines, i);
        
        CTLineGetTypographicBounds(lineRef, &ascent, &descent, &leading);
        
        NSLog(@"ascent = %f,descent = %f, leading = %f",ascent,descent,leading);
        
        totalHeight += ascent + descent;
        
    }
    
    leading = kGlobalLineLeading; // 行间距，
    
    totalHeight += (lineCount ) * leading;
    
    
    NSLog(@"totalHeight = %f",totalHeight);
    
    NSLog(@"高度计算完毕");
    
    return totalHeight;
}


+ (void)addGlobalAttributeWithContent:(NSMutableAttributedString *)aContent font:(UIFont *)aFont
{
    CGFloat lineLeading = kGlobalLineLeading; // 行间距
    
    const CFIndex kNumberOfSettings = 2;
    
#warning 这几个属性有待研究
    
    CTParagraphStyleSetting lineBreakStyle;
    CTLineBreakMode lineBreakMode = kCTLineBreakByWordWrapping;
    lineBreakStyle.spec = kCTParagraphStyleSpecifierLineBreakMode;
    lineBreakStyle.valueSize = sizeof(CTLineBreakMode);
    lineBreakStyle.value = &lineBreakMode;
    
    CTParagraphStyleSetting lineSpaceStyle;
    CTParagraphStyleSpecifier spec;
    spec = kCTParagraphStyleSpecifierLineSpacingAdjustment;
    //    spec = kCTParagraphStyleSpecifierMaximumLineSpacing;
    //    spec = kCTParagraphStyleSpecifierMinimumLineSpacing;
    //    spec = kCTParagraphStyleSpecifierLineSpacing;
    
    lineSpaceStyle.spec = spec;
    lineSpaceStyle.valueSize = sizeof(CGFloat);
    lineSpaceStyle.value = &lineLeading;
    
    CTParagraphStyleSetting lineHeightStyle;
    lineHeightStyle.spec = kCTParagraphStyleSpecifierMinimumLineHeight;
    lineHeightStyle.valueSize = sizeof(CGFloat);
    lineHeightStyle.value = &lineLeading;
    
    // 结构体数组
    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
        
        lineBreakStyle,
        lineSpaceStyle,
        //        lineHeightStyle
    };
    
    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
    
    
    // 将设置的行距应用于整段文字
    [aContent addAttribute:NSParagraphStyleAttributeName value:(__bridge id)(theParagraphRef) range:NSMakeRange(0, aContent.length)];
    
    
    CFStringRef fontName = (__bridge CFStringRef)aFont.fontName;
    CTFontRef fontRef = CTFontCreateWithName(fontName, aFont.pointSize, NULL);
    
    // 将字体大小应用于整段文字
    [aContent addAttribute:NSFontAttributeName value:(__bridge id)fontRef range:NSMakeRange(0, aContent.length)];
    
    // 给整段文字添加默认颜色
    [aContent addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, aContent.length)];
    
    
    // 内存管理
    CFRelease(theParagraphRef);
    CFRelease(fontRef);
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.navigationController.navigationBar.hidden = YES;
}





//
///* 判断是否需要分页和进行分页动作 */
//-(BOOL)paging
//{
//    /* 获取Settings中设定好的字体（主要是获取字体大小） */
//    static const CGFloat textScaleFactor = 1.; // 设置文字比例
//    NSString *textStyle = [curPageView.textView tkd_textStyle]; // 设置文字样式
//    preferredFont_ = [UIFont tkd_preferredFontWithTextStyle:textStyle scale:textScaleFactor]; //设置prferredFont（包括样式和大小）
//    NSLog(@"paging: %@", preferredFont_.fontDescriptor.fontAttributes); // 在控制台中输出字体的属性字典
//    
//    
//    /* 设定每页的页面尺寸 */
//    NSUInteger height = (int)self.view.bounds.size.height - 40.0; // 页面的高度
//    
//    
//    /* 获取文本的总尺寸 */
//    NSDictionary *dic = preferredFont_.fontDescriptor.fontAttributes;
//    CGSize totalTextSize = [bookItem.content.string boundingRectWithSize:curPageView.textView.bounds.size
//                                                                 options:NSStringDrawingUsesLineFragmentOrigin
//                                                              attributes:dic
//                                                                 context:nil].size;
//    NSLog(@"w = %f", totalTextSize.width);
//    NSLog(@"h = %f", totalTextSize.height);
//    
//    
//    /* 开始分页 */
//    if (totalTextSize.height < height) {
//        /* 如果一页就能显示完，直接显示所有文本 */
//        totalPages_   = 1;             // 设定总页数为1
//        charsPerPage_ = [bookItem.content length]; // 设定每页的字符数
//        textLength_   = [bookItem.content length]; // 设定文本总长度
//        return NO;                     // 不用分页
//    }
//    else {
//        /* 计算理想状态下的页面数量和每页所显示的字符数量，用来作为参考值用 */
//        textLength_                       = [bookItem.content length];                   // 文本的总长度
//        NSUInteger referTotalPages        = (int)totalTextSize.height / (int)height + 1; // 理想状态下的总页数
//        NSUInteger referCharactersPerPage = textLength_ / referTotalPages;               // 理想状态下每页的字符数
//        // 输出理想状态下的参数信息
//        NSLog(@"textLength             = %d", textLength_);
//        NSLog(@"referTotalPages        = %d", referTotalPages);
//        NSLog(@"referCharactersPerPage = %d", referCharactersPerPage);
//        
//        
//        /* 根据referCharactersPerPage和text view的高度开始动态调整每页的字符数 */
//        // 如果referCharactersPerPage过大，则直接调整至下限值，减少调整的时间
//        if (referCharactersPerPage > 1000) {
//            referCharactersPerPage = 1000;
//        }
//        
//        // 获取理想状态下的每页文本的范围和pageText及其尺寸
//        NSRange range       = NSMakeRange(referCharactersPerPage, referCharactersPerPage); // 一般第一页字符数较少，所以取第二页的文本范围作为调整的参考标准
//        NSString *pageText  = [bookItem.content.string substringWithRange:range]; // 获取该范围内的文本
//        NSLog(@"%@", pageText);
//        
//        
//        NSRange ptrange = NSMakeRange(0, pageText.length);
//        NSDictionary *ptdic = [[bookItem.content attributedSubstringFromRange:ptrange] attributesAtIndex:0 effectiveRange:&ptrange];
//        CGSize pageTextSize = [pageText boundingRectWithSize:curPageView.textView.bounds.size
//                                                     options:NSStringDrawingUsesLineFragmentOrigin
//                                                  attributes:ptdic
//                                                     context:nil].size;
//        
//        // 若pageText超出text view的显示范围，则调整referCharactersPerPage
//        NSLog(@"height = %d", height);
//        while (pageTextSize.height > height) {
//            NSLog(@"pageTextSize.height = %f", pageTextSize.height);
//            referCharactersPerPage -= 2;                                      // 每页字符数减2
//            range                   = NSMakeRange(0, referCharactersPerPage); // 重置每页字符的范围
//            ptdic = [[bookItem.content attributedSubstringFromRange:range] attributesAtIndex:0 effectiveRange:&range];
//            CGSize pageTextSize = [pageText boundingRectWithSize:curPageView.textView.bounds.size
//                                                         options:NSStringDrawingUsesLineFragmentOrigin
//                                                      attributes:ptdic
//                                                         context:nil].size;
//            pageText                = [bookItem.content.string substringWithRange:range];        // 重置pageText
//            
//            pageTextSize = [pageText boundingRectWithSize:curPageView.textView.bounds.size
//                                                  options:NSStringDrawingUsesLineFragmentOrigin
//                                               attributes:ptdic
//                                                  context:nil].size; // 获取pageText的尺寸
//        }
//        
//        // 根据调整后的referCharactersPerPage设定好charsPerPage_
//        charsPerPage_ = referCharactersPerPage;
//        NSLog(@"cpp: %d", charsPerPage_);
//        
//        // 计算totalPages_
//        totalPages_ = (int)bookItem.content.length / charsPerPage_ + 1;
//        NSLog(@"ttp: %d", totalPages_);
//        
//        // 计算最后一页的字符数，防止范围溢出
//        charsOfLastPage_ = textLength_ - (totalPages_ - 1) * charsPerPage_;
//        NSLog(@"colp: %d", charsOfLastPage_);
//        
//        // 分页完成
//        return YES;
//    }
//}




@end
