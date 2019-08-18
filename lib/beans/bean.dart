import 'dart:convert';


///
/// 用户页用户实体
/// [id] 用户id, [nickname] 名称, [gender] 性别, [topics] 动态数, [latestTid] 最新动态id
/// [fans] 粉丝数, [idols] 关注数, [isFollowing] 是否已关注
///
class User {
    int id;
    String nickname;
    int gender;
    int topics;
    int latestTid;
    int fans, idols;
    bool isFollowing;

    User({
        this.id,
        this.nickname,
        this.gender,
        this.topics,
        this.latestTid,
        this.fans,
        this.idols,
        this.isFollowing,
    });

    @override
    bool operator == (Object other) => identical(this, other) || other is User && runtimeType == other.runtimeType && id == other.id;

    @override
    int get hashCode => id.hashCode;
}

///
/// 用户信息实体
/// [sid] 用户token, [ticket] 用户当前token, [blowfish] 用户设备uuid
/// [uid] 用户uid, [workId] 工号/学号,
/// [name] 名字, [signature] 签名, [gender] 性别, [isFollowing] 是否已关注
///
class UserInfo {
    /// For Login Process
    String sid;
    String ticket;
    String blowfish;
    bool isTeacher;

    /// Common Object
    int uid;
    int gender;
    String name;
    String signature;
    String workId;
    bool isFollowing;

    UserInfo({
        this.sid,
        this.uid,
        this.name,
        this.signature,
        this.ticket,
        this.blowfish,
        this.isTeacher,
        this.workId,
        this.gender,
        this.isFollowing,
    });

    @override
    bool operator == (Object other) => identical(this, other) || other is UserInfo && runtimeType == other.runtimeType && uid == other.uid;

    @override
    int get hashCode => uid.hashCode;

    @override
    String toString() {
        return "UserInfo ${JsonEncoder.withIndent("  ").convert({
            'sid': sid,
            'uid': uid,
            'name': name,
            'signature': signature,
            'ticket': ticket,
            'blowfish': blowfish,
            'isTeacher': isTeacher,
            'workId': workId,
            'gender': gender,
            'isFollowing': isFollowing,
        })}";
    }

}

///
/// 用户个性标签
/// [id] 标签id, [name] 名称
///
class UserTag {
    int id;
    String name;

    UserTag({this.id, this.name});

    @override
    bool operator ==(Object other) => identical(this, other) || other is UserTag && runtimeType == other.runtimeType && id == other.id;

    @override
    int get hashCode => id.hashCode;
}

///
/// 应用中心应用
/// [id] 应用id, [sequence] 排序下标, [code] 代码, [name] 名称, [url] 地址, [menuType] 分类
///
class WebApp {
    int id;
    int sequence;
    String code;
    String name;
    String url;
    String menuType;

    WebApp({this.id, this.sequence, this.code, this.name, this.url, this.menuType});

    @override
    bool operator ==(Object other) => identical(this, other) || other is WebApp && runtimeType == other.runtimeType && id == other.id;

    @override
    int get hashCode => id.hashCode;

    static Map category() => {
//        "10": "个人事务",
        "A4": "我的服务",
        "A3": "我的系统",
        "A8": "流程服务",
        "A2": "我的媒体",
        "A1": "我的网站",
        "A5": "其他",
        "20": "行政办公",
        "30": "客户关系",
        "40": "知识管理",
        "50": "交流中心",
        "60": "人力资源",
        "70": "项目管理",
        "80": "档案管理",
        "90": "教育在线",
        "A0": "办公工具",
        "Z0": "系统设置",
    };
}
