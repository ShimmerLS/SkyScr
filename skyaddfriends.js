"auto";
var url = rawInput('请输入好友链接');
url = url.trim();
//校验链接
var isNetease = /^http[s]{0,1}:\/\/sky.163.com\/yqlj\/\?i=[\w_-]+$/.test(url);
var isInternational = /^http[s]{0,1}:\/\/sky.thatg.co\/\?i=[\w_-]+$/.test(url);
var isTest = /^http[s]{0,1}:\/\/sky-beta.thatg.co\/\?i=[\w_-]+$/.test(url);
var packageName,className;
//判断国服或国际服链接
if (isNetease == false && isInternational == false  && isTest == false) {
    toast('请检查链接是否正确！');
} else if (isNetease) {
    toast('添加国服好友！');
    packageName = 'com.netease.sky';
    className = 'com.tgc.sky.netease.GameActivity_Netease';
} else if (isInternational) {
    toast('添加国际服好友！');
    packageName = 'com.tgc.sky.android';
    className = 'com.tgc.sky.GameActivity';
} else if (isTest){
    toast('添加测试际服好友！');
    packageName = 'com.tgc.sky.android.test.gold';
    className = 'com.tgc.sky.GameActivity';
}
log(packageName, '=>', url);
//启动app
if (isNetease || isInternational || isTest) {
    app.startActivity({
        action: "android.intent.action.VIEW",
        data: url,
        packageName: packageName,
        className: className
    });
}
