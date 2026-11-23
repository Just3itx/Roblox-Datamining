-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:11:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserList = script:FindFirstAncestor("UserList")
local UserListParent = UserList.Parent

local Foundation = require(UserListParent.Foundation)
local Enums = require(UserList.Common.Enums)
local _Types = require(UserList.Common.Types)

local FFlagUserListCanonicalCtaAnalytics = require(UserList.Flags.FFlagUserListCanonicalCtaAnalytics)
local FFlagUserListActionsV2 = require(UserListParent.SharedFlags).FFlagUserListActionsV2
local FFlagUserListHideNotJoinableJoin = require(UserListParent.SharedFlags).FFlagUserListHideNotJoinableJoin

local IconName = Foundation.Enums.IconName
local ButtonVariant = Foundation.Enums.ButtonVariant
local ButtonTypes = Enums.ButtonTypes
local Joinability = Enums.Joinability

local tbl1 = {
    AddFriend = {
        buttonType = ButtonTypes.Add,
        handlerKey = ButtonTypes.Add
    },
    AcceptFriendRequest = {
        buttonType = ButtonTypes.Accept,
        handlerKey = ButtonTypes.Accept,
        supportsDismiss = true
    },
    PendingFriendRequest = {
        buttonType = ButtonTypes.Pending,
        isDisabled = true
    },
    CannotAddFriend = {
        buttonType = ButtonTypes.Add,
        isDisabled = true
    },
    Chat = {
        buttonType = ButtonTypes.Chat,
        handlerKey = ButtonTypes.Chat,
        variant = ButtonVariant.Standard
    },
    JoinExperience = {
        buttonType = ButtonTypes.Join
    }
}
local function func1() end

local function isSupported(tbl2, type: string) -- Luacid: Inlined by compiler; 1 call site recovered
    if not tbl2 then
        return true
    end
    for _, value in tbl2 do
        if value == type then
            return true
        end
    end
    return false
end

local function isJoinable(arg1, arg2): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not (arg2 and arg2.enableJoinabilityCheck and arg1.type == ButtonTypes.JoinExperience)
        or arg1.joinability ~= Joinability.NotJoinable
end

local function mapServerActionsToRowCta(arg1, arg2, str1: string, arg3, num1: number?)
    if not (arg1 and arg1.buttons) then
        return { primaryCta = nil, secondaryCta = nil }
    end

    local supportedActions = if arg3 then arg3.supportedActions else nil

    for _, button in arg1.buttons do
        local var1 = tbl1[button.type]

        if FFlagUserListHideNotJoinableJoin and not isJoinable(button, arg3)
            or not (var1 and isSupported(supportedActions, button.type))
        then
            continue
        end

        local var2 = if var1.handlerKey then arg2[var1.handlerKey] else nil

        local primaryCta = {
            type = var1.buttonType,
            onActivated = var2 and function()
                var2(str1, if FFlagUserListCanonicalCtaAnalytics then num1 else nil)
            end or func1,
            isDisabled = if FFlagUserListActionsV2 then if var1.isDisabled or button.disabledReason ~= nil then true else nil else var1.isDisabled,
            disabledReason = button.disabledReason,
            variant = var1.variant,
            minWidth = if arg3 then arg3.primaryCtaMinWidth else nil,
            maxWidth = if arg3 then arg3.primaryCtaMaxWidth else nil
        }

        local tbl3

        if var1.supportsDismiss and arg3 and arg3.showDismissForRequests then
            local var3 = arg2[ButtonTypes.Dismiss]
            tbl3 = {
                type = ButtonTypes.Dismiss,
                icon = IconName.X,
                onActivated = var3 and function()
                    var3(str1, if FFlagUserListCanonicalCtaAnalytics then num1 else nil)
                end or func1
            }
        else
            tbl3 = nil
        end

        return { primaryCta = primaryCta, secondaryCta = tbl3 }
    end

    return { primaryCta = nil, secondaryCta = nil }
end

return mapServerActionsToRowCta
