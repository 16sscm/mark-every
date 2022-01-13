//##节流，工作一次以后，限定时间内不再接客。效果：频繁触发下，固定频率执行。
function throttle(fn, duration) {
    let valid = true;
    return function () {
        if (!valid) {
            return false;
        }
        valid = false;
        setTimeout(() => {
            valid = true
            fn()
        }, duration)
    }
}

//##防抖，给定时间内，重复触发会取消定时任务，重新定时。效果：周期时间内连续触发只执行一次。
function debounce() {
    let timer = null;
    return function () {
        if (timer) {
            clearTimeout(timer);
            timer = setTimeout(fn, delay)
        } else {
            timer = setTimeout(fn, delay)
        }
    }

}
## vue index不能做key，当数组删除时，index与数据的对应关系会失效
##vue data要用函数，因为data为对象时，组件复用场景下，引用的时同一个data，对一个组件data的修改会影响其他组件，函数每次会返回新的对象，每个组件data都不同。
## ['1','2','3'].map(parseInt) 返回[1,NaN,NaN],因为map会给回调函数传一个index参数，在parseInt当中有一个可选参数radix基数，index被当成radix导致错误。
##继承当中 super的作用：
初始化父类，子类才能调用父类属性和方法
1.构造函数继承父类属性
2.原型继承父类方法
##为什么没有super会报错：
构造函数需要生成一个子类this，子类constructor调用super会生成一个父类实例，使子类的prototype等于父类的实例，才能实现原型继承，如果没有父类实例，继承无法实现，子类原型无法确定，无法创建this。
可以hack一个this
class B extends A {
  constructor() {
    return Object.create(new.target.prototype);
  }
  get two() { return 2; }
};
##为什么继承的子类原型要指向父类的实例
function P(){}
function C(){}
var p = new P();
C.prototype = p;
这样写的好处是子类如果更改了prototype，那么更改的东西也是附加到p这个实例上的
如果你直接写C.prototype = P.prototype，那你对C的prototype的任何修改都会同时修改P的prototype
##async，await的原理，如何用同步的方式执行异步操作。
利用genarator函数，遇到await（yield）的时候，跳转到函数到函数外部执行同步代码，然后等待异步操作完成，执行后面的代码，知道函数结束或者遇到下一个await。
