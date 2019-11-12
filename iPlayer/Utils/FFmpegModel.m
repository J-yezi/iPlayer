//
//  FFmpegUtil.m
//  iPlayer
//
//  Created by 叶浩 on 2019/11/5.
//  Copyright © 2019 叶浩. All rights reserved.
//

#import "FFmpegModel.h"

#include "libavcodec/avcodec.h"
#include "libavformat/avformat.h"
#include "libswscale/swscale.h"

@interface FFmpegModel () {
    // 多媒体容器格式的封装、解封装工具
    AVFormatContext *formatContext;
    int videoStream;
    // 解码器相关信息
    AVCodecContext *codecContext;
    // 帧率
    double fps;
    // 解码后的帧数据 ->  YUV数据  PCM数据
    AVFrame *avFrame;
    AVPicture avPicture;
    // 解码前的帧数据
    AVPacket avPacket;
}

@property (strong, nonatomic) NSString *path;

@end

@implementation FFmpegModel

@synthesize frameWidth = frameWidth, frameHeight = frameHeight;

- (instancetype)initWith:(NSString *)path {
    self = [super init];
    self.path = path;
    return self;
}

- (void)dealloc {
    [self destory];
}

- (UIImage *)cover {
    [self initTool];
    [self seekTime:3];
    [self decodeFrame];
    return [self imageFromFrame];
}

- (void)initTool {
    // 用于各种类型声音、图像编解码
    AVCodec *pCodec;
    
    // 注册所有解码器
    avcodec_register_all();
    av_register_all();
    
    // 打开视频文件, 拉流
    if (avformat_open_input(&formatContext, [_path UTF8String], NULL, NULL) != 0) {
        NSLog(@"打开视频失败");
        return;
    }
    
    // 获取流信息
    if (avformat_find_stream_info(formatContext, NULL) < 0) {
        NSLog(@"获取流失败");
        return;
    }
    
    // 获取第一个视频流
    if ((videoStream =  av_find_best_stream(formatContext, AVMEDIA_TYPE_VIDEO, -1, -1, &pCodec, 0)) < 0) {
        NSLog(@"获取第一个视频流失败");
        return;
    }
    
    // 获取视频编解码的上下文指针
    AVStream *avStream = formatContext->streams[videoStream];
    // 解码器信息
    codecContext = avStream->codec;
    // AVRational fps是分数来表示的 分子和分母都要大于0
    fps = 30;
    if (avStream->avg_frame_rate.den && avStream ->avg_frame_rate.num) {
        fps = av_q2d(avStream ->avg_frame_rate);
    }
    
    // 查找解码器
    pCodec = avcodec_find_decoder(codecContext ->codec_id);
    if (pCodec == NULL) {
        NSLog(@"没有找到解码器");
        return;
    }
    
    // 打开解码器
    if (avcodec_open2(codecContext, pCodec, NULL) < 0) {
        NSLog(@"打开解码器失败");
        return;
    }
    
    avFrame = av_frame_alloc();
    frameWidth = codecContext->width;
    frameHeight = codecContext->height;
}

- (UIImage *)imageFromFrame {
    if (!avFrame->data[0]) {
        return nil;
    }
    
    avpicture_free(&avPicture);
    avpicture_alloc(&avPicture, AV_PIX_FMT_RGB24, frameWidth, frameHeight);
    
    struct SwsContext *imageCovertContext = sws_getContext(avFrame->width, avFrame ->height, AV_PIX_FMT_YUV420P, frameWidth, frameHeight, AV_PIX_FMT_RGB24, SWS_FAST_BILINEAR, NULL, NULL, NULL);
    if (imageCovertContext == nil) {
        return nil;
    }
    
    // YUV数据转化为RGB数据
    sws_scale(imageCovertContext, avFrame->data, avFrame->linesize, 0, avFrame->height, avPicture.data, avPicture.linesize);
    sws_freeContext(imageCovertContext);
    
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    CFDataRef data = CFDataCreate(kCFAllocatorDefault,
                                  avPicture.data[0],
                                  avPicture.linesize[0] * frameHeight);
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData(data);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGImageRef cgImage = CGImageCreate(frameWidth,
                                       frameHeight,
                                       8,
                                       24,
                                       avPicture.linesize[0],
                                       colorSpace,
                                       bitmapInfo,
                                       provider,
                                       NULL,
                                       NO,
                                       kCGRenderingIntentDefault);
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    CGColorSpaceRelease(colorSpace);
    CGDataProviderRelease(provider);
    CFRelease(data);
    
    return image;
}

- (void)destory {
    // 释放RGB
    avpicture_free(&avPicture);
    // 释放frame
    av_packet_unref(&avPacket);
    // 释放YUV frame
    av_free(avFrame);
    // 关闭解码器
    if (codecContext) avcodec_close(codecContext);
    // 关闭文件
    if (formatContext) avformat_close_input(&formatContext);
}

- (void)seekTime:(double)seconds {
    AVRational timeBase = formatContext->streams[videoStream]->time_base;
    
    int64_t timeFrame = (int64_t)( (double)timeBase.den / timeBase.num * seconds);
    
    // 跳转到0s帧处
    avformat_seek_file(formatContext, videoStream, 0, timeFrame, timeFrame, AVSEEK_FLAG_FRAME);
    
    // 清空buffer状态
    avcodec_flush_buffers(codecContext);
}

- (BOOL)decodeFrame {
    int decodeFinished = 0;
    
    // 读取每一帧数据
    while (!decodeFinished && av_read_frame(formatContext, &avPacket) >= 0) {
        NSLog(@"每帧数据%d", videoStream);
        // 解码前的数据
        if (avPacket.stream_index == videoStream) {
            // 解码一帧视频数据，存储到AVFrame中
            avcodec_decode_video2(codecContext, avFrame, &decodeFinished, &avPacket);
        }
    }
    
    if (decodeFinished == 0) {
        [self destory];
    }
    return decodeFinished !=0;
}

@end
