-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local SignalsReact = require(scriptParentParentParentParent.SignalsReact)
local Foundation = require(scriptParentParentParentParent.Foundation)
local RobloxTranslator = require(scriptParentParentParentParent.RobloxTranslator)
local useLocalization = require(scriptParentParentParentParent.Localization).Hooks.useLocalization
local IXPServiceWrapper = require(scriptParentParentParentParent.IXPServiceWrapper).IXPServiceWrapper

local View = Foundation.View
local Tabs = Foundation.Tabs
local FillBehavior = Foundation.Enums.FillBehavior
local InputSize = Foundation.Enums.InputSize

local usePlatformLeaderboard = require(scriptParentParentParent.Hooks.usePlatformLeaderboard)
local FallbackSignals = require(scriptParentParentParent.Common.FallbackSignals)
local FFlagPlayerListLocalizeGameText = require(scriptParentParentParent.Flags.FFlagPlayerListLocalizeGameText)
local PlayerListVisibilityStore = require(scriptParentParentParent.Common.PlayerListVisibilityStore)

local FFlagPlatformLeaderboardsExposure3Enabled = require(scriptParentParentParent.Flags.FFlagPlatformLeaderboardsExposure3Enabled)
local FStringPlatformLeaderboardsExposure3Layer = require(scriptParentParentParent.Flags.FStringPlatformLeaderboardsExposure3Layer)

local function translateOrLegacy(str1: string, str2: string) -- Luacid: Inlined by compiler; 3 call sites recovered
    local success, result = pcall(function()
        return RobloxTranslator:FormatByKey(str1)
    end)
    return if success and result and result ~= "" then result else str2
end

local tbl1 = {
    {
        id = "server",
        text = translateOrLegacy("CoreScripts.TextChat.ChannelTabs.Here", "Here")
    },
    {
        id = "friends",
        text = translateOrLegacy("CommonUI.Features.Label.Friends", "Friends")
    },
    {
        id = "global",
        text = translateOrLegacy("CoreScripts.TextChat.ChannelTabs.Global2", "Global")
    }
}

return React.memo(function(tbl2) -- name: LeaderboardTabs
    local var1 = usePlatformLeaderboard()
    local getHasActiveLeaderboard = if var1 ~= nil then var1.getHasActiveLeaderboard else FallbackSignals.getHasActiveLeaderboard
    local var2 = SignalsReact.useSignalState(getHasActiveLeaderboard)

    if FFlagPlatformLeaderboardsExposure3Enabled then
        local var3 = SignalsReact.useSignalState(PlayerListVisibilityStore.getEffectiveVisible)
        if tbl2.isVisible ~= nil then
            var3 = tbl2.isVisible
        end

        local var4 = React.useRef(false)

        React.useEffect(function()
            if var3 and var2 and not var4.current then
                var4.current = true
                IXPServiceWrapper:LogFlagLinkedUserLayerExposure(FStringPlatformLeaderboardsExposure3Layer)
            end
        end, { var2, var3 })
    end

    local tbl3

    if FFlagPlayerListLocalizeGameText then
        local var3 = useLocalization({
            here = "CoreScripts.InGameMenu.Controls.Playerlist.Here",
            friends = "CoreScripts.InGameMenu.Controls.Playerlist.Friends",
            global = "CoreScripts.InGameMenu.Controls.Playerlist.Global"
        })

        tbl3 = {
            {
                id = "server",
                text = var3.here
            },
            {
                id = "friends",
                text = var3.friends
            },
            {
                id = "global",
                text = var3.global
            }
        }
    else
        tbl3 = tbl1
    end

    React.useEffect(function()
        if not var2 and tbl2.onPlatformTabsUnavailable then
            tbl2.onPlatformTabsUnavailable()
        end
    end, { var2, tbl2.onPlatformTabsUnavailable })

    local onActivated = React.useCallback(function(arg1)
        tbl2.onActivated(tostring(arg1))
    end, { tbl2.onActivated })

    if not var2 then
        return nil
    end

    return React.createElement(
        View,
        {
            Name = "CoreUI_LeaderboardTabs",
            LayoutOrder = tbl2.layoutOrder,
            tag = "col size-full-0 auto-y"
        },
        {
            Tabs = React.createElement(Tabs, {
                activeTabId = tbl2.activeTabId,
                size = InputSize.Small,
                fillBehavior = FillBehavior.Fill,
                onActivated = onActivated,
                tabs = tbl3
            })
        }
    )
end)
