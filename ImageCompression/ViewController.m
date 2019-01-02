//
//  ViewController.m
//  ImageCompression
//
//  Created by PASHA on 02/01/19.
//  Copyright © 2019 Reatchall. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.normalImageV.image = [UIImage imageNamed:@"plp.jpg"];
  [self setElements];
  [self compressImage:[UIImage imageNamed:@"plp.jpg"]];
  // Do any additional setup after loading the view, typically from a nib.
}

// less size 480kb of 9mb
-(void)setElements
{
  
  UIImage * chosenImage = [UIImage imageNamed:@"plp.jpg"];
  NSData *imageData;
  imageData=[[NSData alloc] initWithData:UIImageJPEGRepresentation((chosenImage), 1.0)];
  NSLog(@"[before] image size: %lu--", (unsigned long)[imageData length]);
  CGFloat scale= (100*1024)/(CGFloat)[imageData length]; // For 100KB.
  UIImage *small_image=[UIImage imageWithCGImage:chosenImage.CGImage scale:scale orientation:chosenImage.imageOrientation];
    imageData = UIImageJPEGRepresentation(small_image, scale*1.00);
  NSLog(@"[after] image size: %lu:%f", (unsigned long)[imageData length],scale);
  
  self.lessCompressImageV.image =[UIImage imageWithData:imageData];
}


//less size 60kb of 9mb
-(UIImage *)compressImage:(UIImage *)image{
  
  NSData *imgData = UIImageJPEGRepresentation(image, 1); //1 it represents the quality of the image.
  NSLog(@"Size of Image(bytes):%ld",(unsigned long)[imgData length]);
  
  float actualHeight = image.size.height;
  float actualWidth = image.size.width;
  float maxHeight = 600.0;
  float maxWidth = 800.0;
  float imgRatio = actualWidth/actualHeight;
  float maxRatio = maxWidth/maxHeight;
  float compressionQuality = 0.5;//50 percent compression
  
  if (actualHeight > maxHeight || actualWidth > maxWidth){
    if(imgRatio < maxRatio){
      //adjust width according to maxHeight
      imgRatio = maxHeight / actualHeight;
      actualWidth = imgRatio * actualWidth;
      actualHeight = maxHeight;
    }
    else if(imgRatio > maxRatio){
      //adjust height according to maxWidth
      imgRatio = maxWidth / actualWidth;
      actualHeight = imgRatio * actualHeight;
      actualWidth = maxWidth;
    }
    else{
      actualHeight = maxHeight;
      actualWidth = maxWidth;
    }
  }
  
  CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
  UIGraphicsBeginImageContext(rect.size);
  [image drawInRect:rect];
  UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
  NSData *imageData = UIImageJPEGRepresentation(img, compressionQuality);
  UIGraphicsEndImageContext();
  
  NSLog(@"Size of Image(bytes):%ld",(unsigned long)[imageData length]);
   self.compressImageV.image = [UIImage imageWithData:imageData] ;
  return [UIImage imageWithData:imageData];
  
  
}
@end
