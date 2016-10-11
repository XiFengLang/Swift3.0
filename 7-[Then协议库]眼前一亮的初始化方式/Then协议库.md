### 常规写法

`缺点:$0不能自动联想出属性，需要手动敲`

```OBjct-C

	    let _: UILabel = {
            view.addSubview($0)
            $0.text = "测试"
            $0.font = UIFont.systemFont(ofSize: 18)
            var tempCenter = self.view.center
            tempCenter.y += 30
            $0.center = tempCenter
            $0.bounds = CGRect.init(x: 0, y: 0, width: 100, height: 50)
            return $0
        }(UILabel())
        
        // (UILabel()) 实则是向Block传一个初始化的对象
        // 隐藏参数的情况下，$0取Block里面的第一个参数
```

### Then协议库的初始化写法[推荐]

`优点：$0能自动联想，省去命名的烦恼`

```Objct-C

        // 2.0 带参数，可自行命名
        let label_AnyO = UILabel().then { (label) in
            label.backgroundColor = .blue
            label.font = UIFont.systemFont(ofSize: 18)
            label.textAlignment = .center
            label.text = "Then库写法_2.0"
            label.frame = CGRect.init(x: 200, y: 260, width: 150, height: 40)
        }
        self.view.addSubview(label_AnyO)
        
        
        // 2.1 (推荐)无参数，无需命名，用$取参数，可自动联想属性
        let _ = UILabel().then {
            $0.backgroundColor = .blue
            $0.font = UIFont.systemFont(ofSize: 18)
            $0.textAlignment = .center
            $0.text = "Then库写法_2.1"
            $0.frame = CGRect.init(x: 200, y: 260, width: 150, height: 40)
            self.view.addSubview($0)
        }
```