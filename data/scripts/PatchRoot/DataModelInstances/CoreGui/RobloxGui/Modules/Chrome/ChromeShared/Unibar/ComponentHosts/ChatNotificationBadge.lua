-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local TextChatService = game:GetService("TextChatService")
local React = require(CorePackages.Packages.React)
local SignalsReact = require(CorePackages.Packages.SignalsReact)

local ExpChat = require(CorePackages.Workspace.Packages.ExpChat)
local GetGlobalChatTooltipStore = ExpChat.Stores.GetGlobalChatTooltipStore
local GetChatTooltipStore = ExpChat.Stores.GetChatTooltipStore
local GetChatStatusStore = ExpChat.Stores.GetChatStatusStore
local isUserChatEnabled = ExpChat.isUserChatEnabled

local ExpChatShared = require(CorePackages.Workspace.Packages.ExpChatShared)
local GetFFlagTextChatEnableUniverseChatTabs = ExpChatShared.Flags.GetFFlagTextChatEnableUniverseChatTabs
local FFlagExpChatPresetChatEnabled = ExpChatShared.Flags.FFlagExpChatPresetChatEnabled
local FFlagExpChatUseUnifiedTooltipStore = ExpChatShared.Flags.FFlagExpChatUseUnifiedTooltipStore

local ExpChatPresetChatBadgeFTUXExperimentation = require(CorePackages.Workspace.Packages.SocialExperiments).ExpChatPresetChatBadgeFTUXExperimentation

local FFlagExpChatPresetChatBadgeExperimentCleanup = require(CorePackages.Workspace.Packages.SharedFlags).FFlagExpChatPresetChatBadgeExperimentCleanup

local bool1 = game:DefineFastFlag("ExpChatShowPresetTooltipToNonAgeChecked2", false)

local _Chrome = require(CorePackages.Workspace.Packages.Chrome)

local function ChatNotificationBadge(tbl1)
    local iconHostProps = tbl1.iconHostProps
    local bool2 = iconHostProps.integration.id == "chat"

    local chatWindowConfiguration = TextChatService:FindFirstChildOfClass("ChatWindowConfiguration")
    local bool3 = chatWindowConfiguration == nil
        or chatWindowConfiguration.HorizontalAlignment == Enum.HorizontalAlignment.Left
            and chatWindowConfiguration.VerticalAlignment == Enum.VerticalAlignment.Top
    local bool4 = false
    local var1, var2, var3

    if FFlagExpChatUseUnifiedTooltipStore then
        var1 = GetChatTooltipStore(false)
        var2 = SignalsReact.useSignalState(var1.getIsChatWindowOpen)
        local var4 = SignalsReact.useSignalState(var1.getActiveTooltipKey)
        local var5 = SignalsReact.useSignalState(var1.getIsChatInputBarVisible)
        local var6 = SignalsReact.useSignalState(var1.getIsScreenWideEnough)

        local var7 = bool2 and var6 and bool3
        local var8 = var4 == "GlobalChatTooltip" and var7
        local var9 = FFlagExpChatPresetChatEnabled

        if var9 then
            if var4 ~= "PresetChatTooltip" then
                var7 = false
            end
        else
            var7 = var9
        end

        bool4 = var7

        React.useEffect(function()
            if not bool2 then
                return
            end

            local var10 = if bool1 then bool4 and (var5 or var2) else bool4 and var5
            var1.setShouldShow("GlobalChatTooltip", var8 and var2)
            if FFlagExpChatPresetChatEnabled then
                var1.setShouldShow("PresetChatTooltip", var10)
            end
        end, {
            bool2,
            var8,
            bool4,
            var5,
            var2,
            var1.setShouldShow
        })

        var3 = var8 or bool4
    else
        var1 = GetGlobalChatTooltipStore(false)
        local chatStatusStore = GetChatStatusStore(false)

        var2 = SignalsReact.useSignalState(var1.getIsChatWindowOpen)
        local var4 = SignalsReact.useSignalState(chatStatusStore.getChatStatus)
        local var5 = isUserChatEnabled(var4)
        local var6 = SignalsReact.useSignalState(var1.getIsGlobalChatTooltipDismissed)
        local var7 = SignalsReact.useSignalState(var1.getIsGlobalChatTooltipEligible)
        local var8 = SignalsReact.useSignalState(var1.getIsScreenWideEnough)

        local var9, var10 = React.useState(false)
        React.useEffect(function()
            if not GetFFlagTextChatEnableUniverseChatTabs() then
                return
            end

            if TextChatService:HasAllocatedUniverseChatContext("global") then
                var10(true)
            end

            local connection = TextChatService.UniverseChatChannelAllocated:Connect(function(context: string)
                if context == "global" then
                    var10(true)
                end
            end)

            return function()
                connection:Disconnect()
            end
        end, {})

        var3 = bool2 and var5 and var7 and var9 and bool3 and var8 and not var6

        local setShouldShowGlobalChatTooltip = var1.setShouldShowGlobalChatTooltip
        React.useEffect(function()
            if bool2 then
                setShouldShowGlobalChatTooltip(var3 and var2)
            end
        end, {
            bool2,
            var3,
            var2,
            setShouldShowGlobalChatTooltip
        })
    end
    local var4, var5 = React.useState(false)
    React.useEffect(function()
        if var3 and var2 then
            var5(true)
        end
    end, { var3, var2 })

    local var6 = var3 and not var4

    if FFlagExpChatPresetChatBadgeExperimentCleanup then
        local var7 = var6 and bool4 and not var2

        React.useEffect(function()
            if not (var7 and ExpChatPresetChatBadgeFTUXExperimentation.isExperimentEnabled) then
                return
            end

            ExpChatPresetChatBadgeFTUXExperimentation.logExposure()
        end, { var7 })
    end

    local var7 = table.clone(iconHostProps)
    if var6 and (not bool4 or ExpChatPresetChatBadgeFTUXExperimentation.getShouldShowPresetChatIconBadge()) then
        var7.minBadgeCount = 1
    end

    return React.createElement(tbl1.NotificationBadge, var7)
end

return ChatNotificationBadge
