# iOS_IAPTool
iOS in-app-purchase tool, you can use it to upload iap or edit it through ruby scripts.

由于我现在公司产品的特殊性（主要是手游 app），经常性的要加巨大数量的 ipa(in-app-purchases)，真的是数量非常的多，导致我这边的工作量很重，其实添加ipa无非是个体力劳动，重复的操作同一个流程完全不用费脑子，但是苹果却没有提供一个可以批量上传的工具，这就导致了上传的工作效率很低，于是我就想写一个批量上传的工具来提高下效率，经过一番的调研后，我锁定了 *   [fastlane](https://github.com/fastlane/fastlane) 这个工具。

# Getting Started

安装 Xcode 工具
xcode-select --install

安装 fastlane
[sudo] gem install fastlane -NV



