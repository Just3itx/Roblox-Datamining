-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")

local React = require(CorePackages.Packages.React)
local SignalsReact = require(CorePackages.Packages.SignalsReact)

local Foundation = require(CorePackages.Packages.Foundation)
local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local Button = Foundation.Button

local useLocalization = require(CorePackages.Workspace.Packages.Localization).Hooks.useLocalization

local PeopleService = require(CorePackages.Workspace.Packages.PeopleService)

return React.memo(function(tbl1) -- name: AddConnectionButton
    local var1 = useLocalization({
        isFriend = "CommonUI.Features.Label.Connection",
        addPerson = "CommonUI.Features.Label.Add",
        requestSent = "CommonUI.Features.Label.Sent"
    })

    local var2 = React.useMemo(function()
        return PeopleService.getService("Constants")
    end, {})

    local var3 = React.useMemo(function()
        return PeopleService.getService("PeopleAnalyticsManager")
    end, {})

    local var4 = React.useMemo(function()
        return PeopleService.getService("FriendStatusStore")
    end, {})

    local var5 = React.useMemo(function()
        if tbl1.userId then
            return (Players:GetPlayerByUserId(tbl1.userId))
        end

        return nil
    end, { tbl1.userId })

    local text = SignalsReact.useSignalState(var4.getFriendButtonText(tbl1.userId, var1))
    local isDisabled = SignalsReact.useSignalState(var4.getIsFriendButtonDisabled(tbl1.userId))

    local createElement = React.createElement
    local var8 = Button
    local tbl2 = {
        text = text,
        variant = if isDisabled then ButtonVariant.Subtle else ButtonVariant.Emphasis,
        fillBehavior = FillBehavior.Fill,
        isDisabled = isDisabled,
        LayoutOrder = tbl1.layoutOrder,
        onActivated = 0
    }

    function tbl2.onActivated()
        var3:trackRequestFriendship(var2.ANALYTICS.ENTRY_POINT.PLAYER_PROFILE)
        var4.sendFriendRequest(var5)
    end

    return createElement(var8, tbl2)
end)
