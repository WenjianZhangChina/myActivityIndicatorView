# myActivityIndicatorView  
  使用方法：
  把myAcitivityIndicatorView/Animation文件夹中的ActivityIndicatorView.h和ActivityIndicatorView.m拷贝到您的项目中，使用[[WZActivityIndicatorView alloc] initWithStyle:WZActivityIndicatorStyleWave color:[UIColor whiteColor]]即可，可以根据项目风格和个人喜好选择不同的画风。有
    WZActivityIndicatorStyleRevolution,（太阳地球月球）
    WZActivityIndicatorStyleHeart,（跳动的心）
    WZActivityIndicatorStyleRotateSquare,（炫酷的旋转方块）
    WZActivityIndicatorStyleMicrosoft,（仿微软logo）
    WZActivityIndicatorStyleLights,（红绿灯）
    WZActivityIndicatorStyleBounce,（同心圆，一个膨胀一个收缩）
    WZActivityIndicatorStyleWave,（风吹麦浪，啦啦啦）
    
      
      ![image](https://github.com/WenjianZhangChina/myActivityIndicatorView/blob/master/myActivityIndicatorView/demo-wavestyle.png)
      
  

  该项目受到了 https://github.com/ninjaprox/NVActivityIndicatorView 的启发，但是我们的实现语言，方法和展示方式都迥然不同。
    
    学习过程：
  
    Day 1 试出了同步Xcode文件和Github的方法，开心：）
    Day 2 学习Core Animation的概念，知道了CALayer。
    Day 3 用贝塞尔曲线画了一个心形（后来删了）。
    Day 4 从基础做起，绘制了一个模仿太阳地球和月球运动动画。
    Day 5 阅读别人的源码，受益匪浅。实现各种idea～
    Day 8 完成。
