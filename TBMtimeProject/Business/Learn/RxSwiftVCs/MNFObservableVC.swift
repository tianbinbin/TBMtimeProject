//
//  MNFObservableVC.swift
//  TBMtimeProject
//
//  Created by 田彬彬 on 2021/5/27.
//

import TBMtimeBaseControll
import RxCocoa
import RxSwift
import RxDataSources


enum MyError: Error {
    case A
    case B
}

class MNFObservableVC: MNFBaseViewController {
    
    let disBag = DisposeBag()
    
    var tableView:UITableView!
    
    var vm = RXVM()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        // Observable 被订阅
        // Observable<T> 这个类就是Rx 框架的基础  称它为可观察序列 它的作用就是可以异步地产生一系列的 Event（事件），即一个 Observable<T> 对象会随着时间推移不定期地发出 event(element : T) 这样一个东西 而且这些 Event 还可以携带数据，它的泛型 <T> 就是用来指定这个Event携带的数据的类型
        
        // Observer 订阅者 有了可观察序列，我们还需要有一个Observer（订阅者）来订阅它，这样这个订阅者才能收到 Observable<T> 不时发出的 Event。
        
        // RxSwift的核心
        /**
         * 可观察序列 Observalbe
         * 观察者 Observer
         * 调度者 Scheduler   主要用于控制任务在哪个线程或队列运行
         * 销毁者 Dispose
         */
        
        
//        demo1()
//        print("***********************************************************************")
//        demo2()
//        print("***********************************************************************")
//        demo3()
//        print("***********************************************************************")
//        demo4()
//        print("***********************************************************************")
//        demo5()
//        print("***********************************************************************")
//        demo6()
//        print("***********************************************************************")
//        demo7()
//        print("***********************************************************************")
//        demo8()
//        print("***********************************************************************")
//        demo9()
//        print("***********************************************************************")
//        demo10()
//        print("***********************************************************************")
//        demo11()
//        print("***********************************************************************")
//        demo12()
//        print("***********************************************************************")
//        demo13()
//        print("***********************************************************************")
//        demo14()
//        print("***********************************************************************")
//        demo15()
//        print("***********************************************************************")
//        demo16()
        print("***********************************************************************")
        demo17()
    }
    
    
    deinit {
        print("MNFObservableVC 释放了")
    }
}

extension MNFObservableVC {
    func demo1(){
        // 创建一个序列 只有一个参数
        let ob1 = Observable<Int>.just(10)
        // 由多个参数 但是参数的类型必须保持一致 但是他不是数组
        let ob2 = Observable.of("3","2","334","34")
        // 这个是以数组为参数 数组中可以任意类型
        let ob3 = Observable.from(["2",1,"3",1.0])
        // 创建一个空的序列 这个有用吗 同样要指定参数类型
        let ob4 = Observable<Int>.empty()
        // 创建一个永远不会执行的序列 同样需要指定参数类型
        let ob5 = Observable<Int>.never()
        // 创建一个只发送错误的序列 依然指定参数类型 但是 还需要带上 error 错误信息
        let ob6 = Observable<Int>.error(MyError.A)
        // 创建一个以这个范围内所有值作为初始值的Observable序列。
        let ob7 = Observable<Int>.range(start: 1, count: 5) //等同于下面的这个of 要从1.2.3。4.5 执行
        let observable = Observable.of(1, 2, 3 ,4 ,5)
        // 一个永远不会停止的序列
        let ob8 = Observable.repeatElement(12)
        // 自定义一个序列
        let ob9 = Observable<String>.create { (observer) -> Disposable in
            // 发出一个事件
            observer.onNext("你是个傻子")
            observer.onCompleted()
            return Disposables.create()
        }
        
        // 执行了两次 第一次将 你是个傻子 打印出来 紧接着执行了一个nil的对象
        ob9.subscribe { (element) in
            print("执行了多少次\(element.element)")
        }
     
        // 延迟队列 先执行了一个序列 然后执行了另一个序列 条件语句 先执行一个条件语句 然后执行另一个语句 但是只执行了一次
        var isOdd = true
        let factory:Observable<Int> = Observable.deferred {
            isOdd = !isOdd
            if isOdd {
                return Observable.of(1,3,5,7)
            } else {
                return Observable.of(2,4,6,8)
            }
        }
        
        factory.subscribe { (elment) in
            print("第一次执行\(elment.element)")
        }
        
        factory.subscribe { (elment) in
            print("第二次执行\(elment.element)")
        }
        
        // 永不停的一个序列
//        let ob10 = Observable<Int>.interval(1.5, scheduler: MainScheduler.instance)
//        ob10.subscribe { (elment) in
//            print("主线程中执行一次 永远不会停止\(elment.element)")
//        }
    }
    
    func demo2(){
        let ob1 = Observable.of("A","W","EC")
        ob1.subscribe { (event) in
            print("打印的结果\(event)")
        }
        //  onNext、onError、onCompleted 和 onDisposed 这四个回调 block 参数都是有默认值的，即它们都是可选的 所以我们也可以只处理 onNext而不管其他的情况
        ob1.subscribe(onNext: { value in
            print("可以忽略其他block只处理有值的\(value)")
        })
        
        // doON  他妈的根本就没有执行 这是什么操作
        ob1.do { (value) in
            print("执行顺序1111111\(value)")
        } afterNext: { (value) in
            print("执行顺序222222\(value)")
        } onError: { (error) in
            print("执行顺序33333\(error)")
        } afterError: { (error) in
            print("执行顺序4444\(error)")
        } onCompleted: {
            print("执行顺序555555")
        } afterCompleted: {
            print("执行顺序666666")
        } onSubscribe: {
            print("执行顺序7777777")
        } onSubscribed: {
            print("执行顺序88888888")
        } onDispose: {
            print("执行顺序999999999")
        }

        // Dispose
        /*
         * 1、一个 Observable 序列被创建出来后它不会马上就开始被激活从而发出 Event，而是要等到它被某个人订阅了才会激活它。
         * 2、而 Observable 序列激活之后要一直等到它发出了.error或者 .completed的 event 后，它才被终结。
         * 3、 当一个订阅行为被dispose 了，那么之后 observable 如果再发出 event，这个已经 dispose 的订阅就收不到消息了。下面是一个简单的使用样例。
         */
    
        let ob2 = Observable<String>.create { (obser) -> Disposable in
            obser.onNext("自定义一个序列")
            obser.onNext("再来个参数")
            obser.onCompleted()
            return Disposables.create()
        }
        let sub2 = ob2.subscribe { (event) in
            print("这里开始执行订阅-----\(event)")
        }
        // 这里销毁
        sub2.dispose()
    }
    
    func demo3(){
        var lb1 = UILabel(frame: CGRect(x: 100, y: 100, width: 300, height: 50))
        lb1.backgroundColor = .green
        lb1.textColor = .red
        view.addSubview(lb1)
        
        let ob1 = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        // 这里牵扯到map 映射 但是这个地方没有任何提示 不清楚为什么这样写 然后数组int 直接变成string 形式了 这里是一个用不停止的序列 在主线程中
//        ob1.map { "当前索引数：\($0 )"
//        }.bind { [weak self] (text) in
//            lb1.text = text
//        }.disposed(by: disBag)
        
        // AnyObserver 可以用来描叙任意一种观察者
        let ob2 : AnyObserver<String> = AnyObserver { (event) in
            switch event {
            case .next(let data):
                print("数据是什么\(data)")
            case .error(let er):
                print("错许信息\(er)")
            case .completed:
                print("结束了")
            }
        }
        
        let ob3 = Observable.of("1","2","3")
        // 纯属脱了裤子放屁 没一点用
        ob3.subscribe(ob2)
        
        // binder 创建观察者
        /**
         *  Binder 不会处理错误事件 确保绑定都是在给定 Scheduler 上执行（默认 MainScheduler）
         */
        let ob4 = Observable<String>.just("我是谁呢")
//        let obser4:Binder<String> = Binder(lb1) { (lb, text) in
//            lb.text = text
//        }
//        ob4.bind(to: obser4)
        
        ob4.bind(to: lb1.rx.text).disposed(by: disBag)
    }
    
    func demo4(){
        
        /**   Subjects  既是订阅者，也是 Observable：
         *
         *  PublishSubject
         *  BehaviorSubject
         *  ReplaySubject
         *  Variable
         *  他们之间最大的区别只是在于：当一个新的订阅者刚订阅它的时候，能不能收到 Subject 以前发出过的旧 Event，如果能的话又能收到多少个。
         */
        
        // PublishSubject 的订阅者只能收到他们订阅后的 Event。 并且不需要初始值
        // PublishSubject 订阅之前的事件是收不到的，并且如果已经执行了 onCompleted 那么以后的事件也都收不到了 但是能收到 completed 事件
        
        let pub = PublishSubject<String>()
        
        pub.onNext("PublishSubject发出的第一个事件")
        
        pub.subscribe { (event) in
            print("PublishSubject 第一次订阅开始\(event)")
        }.disposed(by: disBag)
        
        pub.onNext("PublishSubject发出的第二个事件")
        
        pub.subscribe { (event) in
            print("PublishSubject 第二次订阅开始\(event)")
        }.disposed(by: disBag)
        pub.onNext("PublishSubject发出的第三个事件")
        
        pub.onCompleted()
        
        pub.onNext("PublishSubject onCompleted 之后发出的事件")
        
        pub.subscribe { (event) in
            print("PublishSubject 第三次次订阅开始\(event)")
        }.disposed(by: disBag)
        
        pub.onNext("PublishSubject 收不到订阅之前的事件")
    }
    
    func demo5(){
        /**   BehaviorSubject 需要通过一个默认初始值来创建
         * BehaviorSubject 能获取到订阅之前的最后一次赋值
         * onCompleted 之后就无法获取新的值了
         */
        let ob1 = BehaviorSubject(value: "初始值")
        
        ob1.onNext("第一次赋值")
        
        ob1.onNext("第二次赋值")
        
        ob1.subscribe { (event) in
            print("开始第一次订阅--\(event)")
        }.disposed(by: disBag)
        
        ob1.onNext("第三次赋值")
        
        ob1.onNext("第四次赋值")
        
        ob1.onCompleted()
        
        ob1.onNext("第五次赋值")
        ob1.onNext("第六次赋值")
    }
    
    func demo6(){
        /**   ReplaySubject  在创建时候需要设置一个 bufferSize，表示它对于它发送过的 event 的缓存个数
         * ReplaySubject 可以接受订阅之前的事件 但是缓存的个数取决于 bufferSize 的大小
         *  onCompleted  将不再接受新的事件
         *    onCompleted 之后 如果再次订阅 那么会将 onCompleted 缓存之前的的 bufferSize 大小的事件再执行一遍 就是不会接受新事件
         */
        let ob1 = ReplaySubject<String?>.create(bufferSize: 2)
        
        //连续发送3个next事件
        ob1.onNext("111")
        ob1.onNext("222")
        ob1.onNext("333")
        
        ob1.subscribe { event in
            print("第1次订阅：", event)
        }.disposed(by: disBag)
         
        ob1.onNext("444")
        ob1.onNext("555")
        ob1.onNext("666")
        
        
        ob1.onCompleted()
        
        ob1.onNext("777")
        
        ob1.subscribe { event in
            print("第2次订阅：", event)
        }.disposed(by: disBag)

        ob1.onNext("8888")
        
    }
    
    func demo7(){
        
        // buffer 方法作用是缓冲组合，第一个参数是缓冲时间，第二个参数是缓冲个数，第三个参数是线程。
        // 这个会一直走 缓冲时间一到就会走 根据缓冲时间走 缓冲的数据是以缓冲个数为定 如果小于缓冲个数的话也会走
        let ob1 = PublishSubject<String>()
        ob1.buffer(timeSpan: 5, count: 3, scheduler: MainScheduler.instance).subscribe { (event) in
            print("打印buffer 相关的数据\(event)")
        }.disposed(by: disBag)
        
        ob1.onNext("buffer 数据1")
        ob1.onNext("buffer 数据2")
        ob1.onNext("buffer 数据3")
        ob1.onNext("buffer 数据4")
    }
    
    func demo8(){
        let ob1 = PublishSubject<String>()
        ob1.window(timeSpan: 5, count: 3, scheduler: MainScheduler.instance).subscribe { (event) in
            print("打印window 相关的数据\(event)")
        }.disposed(by: disBag)
            
        ob1.onNext("buffer 数据1")
        ob1.onNext("buffer 数据2")
        ob1.onNext("buffer 数据3")
        ob1.onNext("buffer 数据4")
        ob1.onNext("buffer 数据5")
        ob1.onNext("buffer 数据6")
    }
    
    func demo9(){
        let text = UITextField(frame: CGRect(x:10, y:120, width:200, height:30))
        text.borderStyle = UITextField.BorderStyle.roundedRect
        view.addSubview(text)
        
//        text.rx.text.orEmpty.asObservable().subscribe { (event) in
//            print("text输入的内容是什么\(event)")
//        }.disposed(by: disBag)
        
        text.rx.text.orEmpty.changed.subscribe { (event) in
            print("text-----changed输入的内容是什么\(event)")
        }.disposed(by: disBag)
    }
    
    func demo10(){
        
        //Observable序列（每隔1秒钟发出一个索引数）
        let ob1 = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
         
//        ob1.map { "当前索引数：\($0 )"}.bind { [weak self](text) in
//            //收到发出的索引数后显示到label上
//            print("观察者观察到事件------\(text)")
//        }.disposed(by: disBag)
        
//        ob1.map {_ in
//            return "当前的索引"
//        }.bind { (str) in
//            print("出来的结果----\(str)")
//        }.disposed(by: disBag)
        
        // 观察者观察到事件----Optional("当前索引数：18")
//        ob1.map { "当前索引数：\($0 )"}.subscribe { (event) in
//            print("观察者观察到事件----\(event.element)")
//        }.disposed(by: disBag)
        
        // map的话只能返回字符串吗
//        Observable.of(1,2,4).map {
//           return "我爱北京天安门\($0)"
//        }.bind { (str) in
//            print("最终的结果---\(str)")
//        }.disposed(by: disBag)
        
//        let ob2:AnyObserver<Int> = AnyObserver {elment in
//            switch elment {
//            case .next(let index):
//                print("展示内容\(index)")
//            case .error(_):
//                print("数据异常")
//            case .completed:
//                print("序列完成")
//            }
//        }
//            
//        let ob3 = Observable.of(1,2,3)

//        ob3.subscribe(ob2)
        
        
//        let ob4:AnyObserver<String> = AnyObserver { elment in
//            switch elment {
//            case .next(let model):
//                print("展示内容\(model)")
//            case .error(let err):
//                print("数据异常")
//            case .completed:
//                print("序列完成")
//            }
//        }
//
//        let ob5 = Observable.of("1","33424","222")
//
//        ob5.subscribe(ob4)
        
        // map 转成成之后变成了一个新的队列 map 里面加了一个闭包。改变了 原先队列的条件
        Observable.of(1,2,3).map {
            $0 * 10 + 2
        }.subscribe { (event) in
            print("map之后生成一个新的队列\(event.element)")
        }.disposed(by: disBag)
        
        let ob2 = BehaviorSubject(value: "E")
        let ob3 = BehaviorSubject(value: "R")
        
        let ob4 = BehaviorRelay(value: ob2)
                
        ob4.flatMap { $0
        }.subscribe { (event) in
            print("faltmap之后的数据----\(event.element)")
        }.disposed(by: disBag)
    }
    
    func demo11(){
        let lb1 = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 100))
        view.addSubview(lb1)
        
        let ob1 = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
//        // 牛逼啊 连一个入参数都没有 直接这样写就能成 真他妈的活见鬼
//        ob1.map(formatTimeInterval).bind(to: lb1.rx.attributedText).disposed(by: disBag)
        // 这他妈真牛逼啊还能这样操作
//        ob1.map { [self] in formatTimeInterval(ms: $0)
//        }.bind(to: lb1.rx.attributedText).disposed(by: disBag)
        


    }
    
    //将数字转成对应的富文本
        func formatTimeInterval(ms: NSInteger) -> NSMutableAttributedString {
            let string = String(format: "%0.2d:%0.2d.%0.1d",
                             arguments: [(ms / 600) % 600, (ms % 600 ) / 10, ms % 10])
            //富文本设置
            let attributeString = NSMutableAttributedString(string: string)
            //从文本0开始6个字符字体HelveticaNeue-Bold,16号
            attributeString.addAttribute(NSAttributedString.Key.font,
                                         value: UIFont(name: "HelveticaNeue-Bold", size: 16)!,
                                         range: NSMakeRange(0, 5))
            //设置字体颜色
            attributeString.addAttribute(NSAttributedString.Key.foregroundColor,
                                         value: UIColor.white, range: NSMakeRange(0, 5))
            //设置文字背景颜色
            attributeString.addAttribute(NSAttributedString.Key.backgroundColor,
                                         value: UIColor.orange, range: NSMakeRange(0, 5))
            return attributeString
        }
    
    func demo12(){
        //创建文本输入框
        let textField = UITextField(frame: CGRect(x:10, y:150, width:200, height:30))
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        self.view.addSubview(textField)
                
          //当文本框内容改变时，将内容输出到控制台上
        textField.rx.text.orEmpty.asObservable().subscribe(onNext: {
            print("您输入的是：\($0)")
        }).disposed(by: disBag)
        
        // 这里为什么没有转成 asObservable 一个序列 直接就被订阅了
        textField.rx.text.subscribe { (event) in
            print("新型的数据类型---\(event.element)")
        }.disposed(by: disBag)
        // 转换成一个change
        textField.rx.text.changed.subscribe { (event) in
            print("change---\(event.element)")
        }.disposed(by: disBag)
        
        // change 在初始化的时候并没有打印 而上面的两个都进行了打印，上面两个应该没什么不同
    }
    
    
    func demo13(){
        // 双向绑定
        let textField = UITextField(frame: CGRect(x:10, y:150, width:200, height:30))
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        view.addSubview(textField)
        
        let lb1 = UILabel(frame: CGRect(x: 100, y: 200, width: 200, height: 100))
        view.addSubview(lb1)
        
        let btn1 = UIButton(frame: CGRect(x: 100, y: 400, width: 200, height: 100))
        btn1.setTitle("btn", for: .normal)
        btn1.backgroundColor = .red
        view.addSubview(btn1)
        
        btn1.rx.tap.subscribe { (event) in
            print("点击了btng改变model的值")
        }.disposed(by: disBag)
        
        //将用户名与textField做双向绑定
//        vm.userName.asObservable().bind(to: textField.rx.text).disposed(by: disBag)
//        textField.rx.text.orEmpty.bind(to: vm.userName).disposed(by: disBag)
        
        // 首先两个序列相互绑定 再者其中的一个序列 userName 经过map之后生成了一个新的序列 userinfo 而序列 userinfo 又与UI绑定
        
        //将用户信息绑定到label上
        vm.userinfo.bind(to: lb1.rx.text).disposed(by: disBag)
    }
    
    func demo14(){
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
         
        //初始化数据
        let sctionModel = SectionModel(model: "", items: ["UILable的用法",
                                                          "UIText的用法",
                                                          "UIButton的用法"])
        let items = Observable.just([sctionModel])
         
        //创建数据源
        let dataSource = RxTableViewSectionedReloadDataSource
            <SectionModel<String, String>>(configureCell: {
                (dataSource, tv, indexPath, element) in
                let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(indexPath.row)：\(element)"
                return cell
            })
         
        //绑定单元格数据
        items.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disBag)
    }
    
    func demo15(){
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
         
        let my = MySection(header: "", items: [
                                        "UILable的用法",
                                        "UIText的用法",
                                        "UIButton的用法"])
        //初始化数据
        let sections = Observable.just([my])
         
        //创建数据源
        let dataSource = RxTableViewSectionedAnimatedDataSource<MySection>(
            //设置单元格
            configureCell: { ds, tv, ip, item in
                let cell = tv.dequeueReusableCell(withIdentifier: "Cell")
                    ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
                cell.textLabel?.text = "\(ip.row)：\(item)"
                 
                return cell
        })
         
        //绑定单元格数据
        sections
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disBag)
    }
    
    func demo16(){
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
         
        // 组头 以及每一个组的个数
        let one = SectionModel(model: "基本控件", items: [
            "UILable的用法",
            "UIText的用法",
            "UIButton的用法"
            ])
        
        let two = SectionModel(model: "高级控件", items: [
            "UITableView的用法",
            "UICollectionViews的用法"
            ])
        
        
        //初始化数据
        let items = Observable.just([one,two])
         
        //创建数据源
        let dataSource = RxTableViewSectionedReloadDataSource
            <SectionModel<String, String>>(configureCell: {
            (dataSource, tv, indexPath, element) in
            let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(indexPath.row)：\(element)"
            return cell
        })
         
        //设置分区头标题
        dataSource.titleForHeaderInSection = { ds, index in
            print("打印组头相对应的数据\(ds),\(index)")
            let h = ds
            let str = ds.sectionModels[index].model
            return str
        }
         
        //设置分区尾标题
        //dataSource.titleForFooterInSection = { ds, index in
        //    return "footer"
        //}
         
        //绑定单元格数据
        items
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disBag)
    }
    
    func demo17(){
        let btn1 = UIButton(frame: CGRect(x: 100, y: 400, width: 200, height: 100))
        btn1.setTitle("btn", for: .normal)
        btn1.backgroundColor = .red
        view.addSubview(btn1)

        let ob1 =  btn1.rx.tap.asObservable().startWith((woaibeijng(nil))).share(replay: 1)
        
    }
    
    func woaibeijng(_ str:String?){
        print("执行一波操作")
        
        
    }
}

//自定义Section
struct MySection {
    var header: String
    var items: [Item]
}
 
// AnimatableSectionModelType 与 SectionModelType 的区别在哪
extension MySection : AnimatableSectionModelType {
    typealias Item = String
     
    var identity: String {
        return header
    }
     
    init(original: MySection, items: [Item]) {
        self = original
        self.items = items
    }
}
