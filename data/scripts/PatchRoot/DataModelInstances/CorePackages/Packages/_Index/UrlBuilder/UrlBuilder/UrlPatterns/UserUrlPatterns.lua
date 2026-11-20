-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1)
    return {
        profile = arg1.fromString("www:users/{userId}/profile?friendshipSourceType={sourceType|}"),
        group = arg1.fromString("www:communities/{groupId}/{groupName|}#!/about"),
        forumComment = arg1.fromString("www:communities/{groupId}#!/forums/{categoryId}/post/{postId}/comment/{commentId}"),
        friends = arg1.fromString("www:users/{userId}/friends"),
        inventory = arg1.fromString("www:users/{userId}/inventory"),
        search = arg1.fromString("www:search/users?{keyword}"),
        profileWithFriendshipSourceType = arg1.fromString("www:users/{userId}/profile?friendshipSourceType={sourceType}"),
        followers = arg1.fromString("www:users/{userId}/friends#!/followers"),
        following = arg1.fromString("www:users/{userId}/friends#!/following"),
        report = function(arg2)
            return arg1.fromString("www:abusereport/embedded/chat?id={userId}&{actionName}&{conversationId}&{redirecturl}")({
                userId = arg2.userId,
                conversationId = arg2.conversationId,
                actionName = "chat",
                redirecturl = arg1.fromString("www:home")()
            })
        end,
        appsflyer = function(arg2)
            local mobileUrl = arg1.fromString("mobilenav:profile?userId={userId}&friendshipSourceType={sourceType}")(arg2)
            local webUrl = arg1.fromString("www:users/{userId}/profile?friendshipSourceType={sourceType}")(arg2)
            return arg1.fromString("appsflyer:Ebh5?pid=share&is_retargeting=true&af_dp={mobileUrl}&af_web_dp={webUrl}")(
                { mobileUrl = mobileUrl, webUrl = webUrl }
            )
        end
    }
end
