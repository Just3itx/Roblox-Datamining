-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialTabsPage = script:FindFirstAncestor("SocialTabsPage")
local SocialTabsPageParent = SocialTabsPage.Parent

local ButtonTypes = require(SocialTabsPageParent.UserList).Enums.ButtonTypes

local _Types = require(SocialTabsPage.Common.Types)

local FFlagUserListActionsV2 = require(SocialTabsPageParent.SharedFlags).FFlagUserListActionsV2

local function func1() end

local tbl1 = {
    JoinExperience = ButtonTypes.Join,
    Chat = ButtonTypes.Chat,
    AddFriend = ButtonTypes.Add,
    AcceptFriendRequest = ButtonTypes.Accept,
    PendingFriendRequest = ButtonTypes.Pending
}

local function mapProfileCTAToRowCTA(arg1, arg2, str1: string)
    if not (arg1 and arg1.buttons) then
        return nil
    end

    for _, button in arg1.buttons do
        local type = tbl1[button.type]
        if not type then
            continue
        end

        local var2 = arg2[type]
        local var3 = type == ButtonTypes.Pending or nil
        if FFlagUserListActionsV2 and button.disabledReason ~= nil then
            var3 = true
        end

        return {
            type = type,
            onActivated = var2 and function()
                var2(str1)
            end or func1,
            isDisabled = var3,
            disabledReason = button.disabledReason
        }
    end

    return nil
end

return mapProfileCTAToRowCTA
