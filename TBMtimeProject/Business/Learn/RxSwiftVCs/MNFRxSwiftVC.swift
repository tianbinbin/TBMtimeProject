//
//  MNFRxSwiftVC.swift
//  TBMtimeProject
//
//  Created by 田彬彬 on 2020/12/23.
//

import TBMtimeBaseControll
import RxCocoa
import RxSwift


class MNFRxSwiftVC: MNFBaseViewController {

    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textfiledone: UITextField!
    @IBOutlet weak var scollowCustom: UIScrollView!
    
    
    fileprivate lazy var bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    
//        rxswiftjiantin()
        
//        rxswiftwenzi()
        
//        rxswiftjiantingwenzigai()
//        rxswiftNoti()
        
//        /// 创建了一个事件
//        let creste = createObserval()
//
//        /// 订阅此事件
//        creste.subscribe { (str:Any) in
//            print("--------自定义的事件\(str)")
//        }.disposed(by: bag)
        
        
//        /// 只执行一次
//        let creat  = cretaJustOBaser("天安门")
//        creat.subscribe { (str:String) in
//
//
//            print(str)
//        }.disposed(by: bag)
//
        
//        createRepeate(60)
        
        
        obeverandobservable()
    }
    
    deinit {
        print("当前vc释放了")
    }
}


extension MNFRxSwiftVC {
    
    func rxswiftjiantin() {
        
        btn.rx.tap.subscribe { (event:Event<Void>) in
            print("发生了点击事件的改变")
        }.disposed(by: bag)
    }
    
    func rxswiftwenzi() {
        /*
        textfiledone.rx.text.subscribe { (event:Event<String?>) in
            print("总的打印----\(event.element!)")
        }.disposed(by: bag)
        */
        
        textfiledone.rx.text.subscribe { (str:String?) in
            print("打印文字的改变---\(str!)")
        }.disposed(by: bag)
    }
    
    func rxswiftjiantingwenzigai() {
        
        /// text 的改变绑定到abel 的text 那么 两者实现绑定
        textfiledone.rx.text.bind(to: label.rx.text).disposed(by: bag)
        
        /// rxswift 的监听
        label.rx.observe(String.self, "text").subscribe { (str:String?) in
            print("监听label 文字发生改变")
        }.disposed(by: bag)
        
        /// 监听滚动
        scollowCustom.contentSize = CGSize(width: 1000, height: 0)
        
        scollowCustom.rx.contentOffset.subscribe { (point:CGPoint) in
            print("滚动--\(point)（）")
        }.disposed(by: bag)
        
    }
    
    func rxswiftNoti() {

    }
    
    /// 创建一个自己的事件
    func createObserval() -> Observable<Any> {
        ///
        return Observable.create { (observer:AnyObserver<Any>) -> Disposable in
            /// 这里面事和一个闭包 返回值是一个Disposable
            
            observer.onNext("beijng")
            observer.onNext("上海")
            observer.onNext("东京")
            
            /// 有报错信息的时候返回error
//            observer.onError(<#T##error: Error##Error#>)
            
            
            /// 这一步是结束
//            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    
    /// 创建一个just事件 只执行一次
    func cretaJustOBaser(_ str:String) -> Observable<String> {
        return Observable.create { (obser:AnyObserver<String>) -> Disposable in
            
            obser.onNext("我是谁\(str)")
            
            
            return Disposables.create()
        }
    }
    
    /// 重复的次数
    func createRepeate(_ ocunt:Int) {

        var countTemp = 60
        
        let repeate = Observable.repeatElement(1)
        
        repeate.take(59).subscribe { (evet:Event<Int>) in
            countTemp -= 1
            print("倒计时\(countTemp)")
        }.disposed(by: bag)
        
        
    }
    
    func obeverandobservable() {
        /// Observer 是发出事件。 Observable 是被订阅
        /// subject 是 Observer 与 Observable 之间的桥梁，既可以被订阅也可以发出事件
        
        /// PublishSubject  订阅者 只能 接受 订阅之后发出的事件
        let publish = PublishSubject<String>()
        
        publish.onNext("dongjing")
        publish.subscribe { (event:Event<String>) in
            print("PublishSubjec -- \(event)")
        }.disposed(by: bag)
        
        publish.onNext("北京")
        
        /// replaySubject
        let replay = ReplaySubject<String>.create(bufferSize: 1)

        replay.onNext("0000")
        replay.subscribe { (event:Event<String>) in
            print("ReplaySubject ----\(event)")
        }.disposed(by: bag)
        
        replay.onNext("123")
        replay.onNext("223")
        replay.onNext("323")
        
        
    }
}
 

extension MNFRxSwiftVC {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "beijing"), object: "123", userInfo: nil)
    }
}
