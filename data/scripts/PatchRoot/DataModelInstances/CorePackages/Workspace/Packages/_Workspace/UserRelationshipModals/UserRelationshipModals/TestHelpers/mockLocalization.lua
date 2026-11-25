-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserRelationshipModalsParent = script:FindFirstAncestor("UserRelationshipModals").Parent

return {
    Format = function(_, str1: string): string
        if str1 == "InGame.FriendPlayerPrompt.Title.SendFriendRequest"
            or str1 == "InGame.FriendPlayerPrompt.Title.SendFriendRequest.FriendsRename"
        then
            return "Send Friend Request"
        end

        if str1 == "InGame.FriendPlayerPrompt.Action.Send" then
            return "Send"
        elseif str1 == "Feature.Friends.Action.FriendRequestSent" then
            return "Friend Request Sent"
        elseif str1 == "CommonUI.Messages.Response.SomethingWentWrong" then
            return "Something Went Wrong"
        end

        return str1
    end,
    GetLocale = function(): string
        return "en-us"
    end,
    changed = require(UserRelationshipModalsParent.AppCommonLib).Signal.new()
}
