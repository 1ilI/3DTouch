# 3DTouchDemo

![leaks](https://raw.githubusercontent.com/1ilI/1ilI.github.io/master/resource/2018-05/3DTouch-iOS11-leaks.gif)
<p align="center">在 iOS11.3 下，检测到了 3DTouch Pop 时的内存泄漏。</p>

## 问题

不论是自己写的 demo 还是在 [开发者指南和样例代码](https://developer.apple.com/library/content/samplecode/ViewControllerPreviews/Introduction/Intro.html#//apple_ref/doc/uid/TP40016546) 上下载的样例工程，在加入了 [MLeaksFinder](https://github.com/Tencent/MLeaksFinder) 后均能发现在 iOS10.3.1 和 iOS 11.3 下有泄漏。

问题出在 `UIViewControllerPreviewingDelegate` 的 Pop 代理函数上

```objc
//Pop 进入
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(nonnull UIViewController *)viewControllerToCommit {
    [self showViewController:viewControllerToCommit sender:self];
}
```

```swift
/// Present the view controller for the "Pop" action.
func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
    // Reuse the "Peek" view controller for presentation.
    show(viewControllerToCommit, sender: self)
}
```

## 解决

```objc
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(nonnull UIViewController *)viewControllerToCommit {
    BViewController *pushVC = [[BViewController alloc] init];
    pushVC.parameter = [(BViewController *)viewControllerToCommit parameter];
    [self.navigationController pushViewController:pushVC animated:YES];
}
```

![no-leaks](https://raw.githubusercontent.com/1ilI/1ilI.github.io/master/resource/2018-05/3DTouch-iOS11-noleaks.gif)

可以看到第一次的 `viewDidLoad` 到 `dealloc` 这一系列生命周期函数都是内存地址为 `0x7fd6e19883f0` 的 `BViewController` Peek 产生的，后面的就是内存地址为 `0x7fd6df503b30` 的 ViewController Pop 产生的，这样就没有内存泄漏警告了。

## 最后

详见分析 [1ilI的博客](https://1ili.github.io/2018/05/09/3dtouch-mleaksfinder/)
