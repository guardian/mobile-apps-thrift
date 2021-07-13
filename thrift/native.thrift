struct Rect {
    1: required double x;
    2: required double y;
    3: required double height;
    4: required double width;
}

struct AdSlot {
    1: required Rect rect;
    2: optional map<string,string> targetingParams;
    3: required bool isSquare;
}

struct Topic {
    1: required string id;
    2: required string displayName;
    3: required string type;
}

struct Image {
    1: required string url;
    2: required double width;
    3: required double height;
    4: optional string caption;
    5: optional string credit;
}

struct Epic {
    1: required string title;
    2: required string body;
    3: required string firstButton;
    4: optional string secondButton;
}

struct MaybeEpic {
    1: optional Epic epic;
}

struct VideoSlot {
    1: required Rect rect;
    2: required string videoId;
    3: required string posterUrl;
    4: optional i32 duration;
}

struct MetricPaint {
    1: required double time;
}

struct MetricFont {
    1: required double duration;
    2: optional i32 size;
    3: optional string name;
}

union Metric {
    1: MetricPaint firstPaint;
    2: MetricPaint firstContentfulPaint;
    3: MetricFont font;
}

struct CommentResponse {
    1: required string status;
    2: required i32 statusCode;
    3: required string message;
    4: optional string errorCode;
}

enum PurchaseScreenReason {
    hideAds = 0,
    epic = 1
}

service Environment {
    string nativeThriftPackageVersion()
}

service Commercial {
    void insertAdverts(1:list<AdSlot> adSlots),
    void updateAdverts(1:list<AdSlot> adSlots)
}

service Acquisitions {
    void launchPurchaseScreen(1: PurchaseScreenReason reason),
    MaybeEpic getEpics(),
    void epicSeen()
}

service Notifications {
    bool follow(1:Topic topic),
    bool unfollow(1:Topic topic),
    bool isFollowing(1:Topic topic),
}

service User {
    bool isPremium(),
    list<string> filterSeenArticles(1:list<string> articleIds),
    string discussionId(),
    bool doesCcpaApply()
}

service Gallery {
    void launchSlideshow(1:list<Image> images, 2:i32 selectedIndex, 3:string articleTitle)
}

service Videos {
    void insertVideos(1:list<VideoSlot> videoSlots),
    void updateVideos(1:list<VideoSlot> videoSlots)
}

service Metrics {
    void sendMetrics(1:list<Metric> metrics)
    void sendArticleHeight(1:i32 articleHeight)
}

service Discussion {
    string preview(1:string body),
    bool isDiscussionEnabled(),
    bool recommend(1:i32 commentId),
    CommentResponse comment(1:string shortUrl, 2:string body),
    CommentResponse reply(1:string shortUrl, 2:string body, 3:i32 parentCommentId)
}

service Analytics {
    void sendTargetingParams(1:map<string, string> targetingParams)
}

service Navigation {
    void openPrivacySettings(),
    void openPrivacyPolicy()
}
