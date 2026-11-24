-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local React = require(ExpChatParent.React)
local Signals = require(ExpChatParent.Signals)
local SignalsReact = require(ExpChatParent.SignalsReact)
local useSelector = require(ExpChatParent.RoactUtils).Hooks.RoactRodux.useSelector

local Foundation = require(ExpChatParent.Foundation)
local Coachmark = Foundation.Coachmark
local PopoverSide = Foundation.Enums.PopoverSide
local PopoverAlign = Foundation.Enums.PopoverAlign

local FFlagExpChatUseUnifiedTooltipStore = require(ExpChatParent.ExpChatShared).Flags.FFlagExpChatUseUnifiedTooltipStore
local FFlagExpChatUseChannelTabsStore = require(ExpChatParent.SharedFlags).FFlagExpChatUseChannelTabsStore

local Localization = require(ExpChat.Localization)
local Config = require(ExpChat.Config)
local isUserChatEnabled = require(ExpChat.isUserChatEnabled)
local GetTransparencyStore = require(ExpChat.Stores.GetTransparencyStore)
local GetGlobalChatTooltipStore = require(ExpChat.Stores.GetGlobalChatTooltipStore)
local GetChatTooltipStore = require(ExpChat.Stores.GetChatTooltipStore)
local GetChannelTabsStore = if FFlagExpChatUseChannelTabsStore then require(ExpChat.Stores.GetChannelTabsStore) else nil
local useChatTooltipLifecycle = require(script.Parent.Parent.useChatTooltipLifecycle)
local FFlagExpChatGlobalTabDefault = require(ExpChat.Flags.FFlagExpChatGlobalTabDefault)

local MinTabWidth = Config.ChannelTabsSettings.MinTabWidth
local DropdownIconContainerWidth = Config.ChannelTabsSettings.DropdownIconContainerWidth

local function useGlobalTabIndex()
    if not FFlagExpChatUseChannelTabsStore then
        return useSelector(function(arg1)
            local allChannelTabs = arg1.ChannelTabs and arg1.ChannelTabs.allChannelTabs
            local rbxGlobal = allChannelTabs and allChannelTabs.RBXGlobal
            return if rbxGlobal then rbxGlobal.TabIndex else 2
        end)
    end

    local var1 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            local rbxGlobal = GetChannelTabsStore(false).getChannelTabsState(arg1).allChannelTabs.RBXGlobal
            return if rbxGlobal then rbxGlobal.tabIndex else 2
        end)
    end, {})
    return SignalsReact.useSignalState(var1)
end

local function useTabCount()
    if not FFlagExpChatUseChannelTabsStore then
        return useSelector(function(arg1)
            local allChannelTabs = arg1.ChannelTabs and arg1.ChannelTabs.allChannelTabs
            if allChannelTabs == nil then
                return 0
            end
            local num1 = 0
            for _ in allChannelTabs do
                num1 += 1
            end
            return num1
        end)
    end

    local var1 = React.useMemo(function()
        return Signals.createComputed(function(arg1): number
            local num1 = 0
            for _ in GetChannelTabsStore(false).getChannelTabsState(arg1).allChannelTabs do
                num1 += 1
            end
            return num1
        end)
    end, {})
    return SignalsReact.useSignalState(var1)
end

local function GlobalChatTooltipNew(tbl1)
    local chatTooltipStore = GetChatTooltipStore(false)
    local var1 = SignalsReact.useSignalState(chatTooltipStore.getShouldShow("GlobalChatTooltip"))

    local var2 = useTabCount()

    local var3, var4 = React.useState(0)
    local var5 = if FFlagExpChatGlobalTabDefault then useGlobalTabIndex() else 2
    local bool1 = var3 > 0 and var3 < var2 * MinTabWidth
    local xScale

    if var2 < var5 then
        xScale = 1
    elseif not bool1 then
        xScale = var5 / var2
    else
        local var6 = var3 - DropdownIconContainerWidth
        local num1 = math.floor(var6 / MinTabWidth)
        xScale = if var5 <= num1 then var5 * var6 / (num1 * var3) else 1
    end

    local var6 = useSelector(function(arg1): boolean
        local alignment = arg1.ChatLayout and arg1.ChatLayout.Alignment
        return not (alignment == nil or alignment.AnchorPoint.X ~= 0) and alignment.AnchorPoint.Y == 0
    end)

    local var7 = useChatTooltipLifecycle({ tooltipKey = "GlobalChatTooltip", targetTextChannel = tbl1.targetTextChannel })

    local var8 = Localization.useLocalization(
        {
            headerText = "CoreScripts.TextChat.Tooltip.Global.Header",
            bodyText = "CoreScripts.TextChat.Tooltip.Global.Body"
        }
    )

    if not (tbl1.visible and var1 and var6) then
        return nil
    end

    local function onAnchorChanged(arg1)
        local parent = arg1.Parent
        if parent and parent:IsA("GuiObject") then
            var4(parent.AbsoluteSize.X)
        end
    end

    return React.createElement(Coachmark, {
        title = var8.headerText,
        text = var8.bodyText,
        isOpen = var7.isActive,
        onClose = var7.onDismiss,
        side = PopoverSide.Right,
        align = PopoverAlign.Start,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(xScale, -13, 0, -48),
        onAbsoluteSizeChanged = onAnchorChanged,
        onAbsolutePositionChanged = onAnchorChanged
    }, {
        AnchorSizer = React.createElement("Frame", {
            Size = UDim2.new(0, 1, 0, Config.ChannelTabsSettings.HorizontalBarHeight),
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        })
    })
end

local function GlobalChatTooltipLegacy(tbl1)
    local globalChatTooltipStore = GetGlobalChatTooltipStore(false)
    local transparencyStore = GetTransparencyStore(false)

    local var1 = SignalsReact.useSignalState(globalChatTooltipStore.getShouldShowGlobalChatTooltip)
    local var2 = SignalsReact.useSignalState(globalChatTooltipStore.getIsScreenWideEnough)
    local var3 = transparencyStore.getIsFocused or transparencyStore.getIsTextBoxFocused
    local var4 = SignalsReact.useSignalState(transparencyStore.getLastActivity)
    local var5 = SignalsReact.useSignalState(var3)

    local var6 = useTabCount()

    local var7, var8 = React.useState(0)
    local var9 = if FFlagExpChatGlobalTabDefault then useGlobalTabIndex() else 2
    local bool1 = var7 > 0 and var7 < var6 * MinTabWidth
    local xScale

    if var6 < var9 then
        xScale = 1
    elseif not bool1 then
        xScale = var9 / var6
    else
        local var10 = var7 - DropdownIconContainerWidth
        local num1 = math.floor(var10 / MinTabWidth)
        xScale = if var9 <= num1 then var9 * var10 / (num1 * var7) else 1
    end

    local var10 = useSelector(function(arg1): boolean
        local alignment = arg1.ChatLayout and arg1.ChatLayout.Alignment
        return not (alignment == nil or alignment.AnchorPoint.X ~= 0) and alignment.AnchorPoint.Y == 0
    end)

    local var11 = tbl1.chatStatus == nil or isUserChatEnabled(tbl1.chatStatus)

    local var12, var13 = React.useState(true)
    local var14, var15 = React.useState(false)

    local var16 = React.useRef(false)
    local var17 = React.useRef(0)
    local var18 = React.useRef(tbl1.targetTextChannel)

    local onClose = React.useCallback(function()
        if not var16.current then
            var16.current = true
            globalChatTooltipStore.reportImpression()
        end
        globalChatTooltipStore.setIsGlobalChatTooltipDismissed(true)
    end, { globalChatTooltipStore.setIsGlobalChatTooltipDismissed, globalChatTooltipStore.reportImpression })

    React.useEffect(function()
        globalChatTooltipStore.setIsChatWindowOpen(tbl1.visible)
        return function()
            globalChatTooltipStore.setIsChatWindowOpen(false)
        end
    end, { tbl1.visible })

    React.useEffect(function()
        if var5 then
            var13(true)
            return nil
        end

        local var20 = Config.ChatWindowBackgroundFadeOutTime - (os.clock() - var4)
        if var20 <= 0 then
            var13(false)
            return nil
        end
        var13(true)
        local var21 = task.delay(var20, function()
            var13(false)
        end)
        return function()
            task.cancel(var21)
        end
    end, { var4, var5 })

    React.useEffect(function()
        if not (var12 and var2) or var14 or not (var1 and var11) then
            return nil
        end
        local startTime = os.clock()
        local num1 = math.max(0, 10 - var17.current)
        local var20 = task.delay(num1, function()
            var15(true)
        end)
        return function()
            local var21 = var17
            var21.current += os.clock() - startTime
            task.cancel(var20)
        end
    end, {
        var12,
        var2,
        var14,
        var1,
        var11
    })

    React.useEffect(function()
        if not var14 then
            return nil
        end
        local var20 = task.delay(1, function()
            onClose()
        end)
        return function()
            task.cancel(var20)
        end
    end, { var14, onClose })

    React.useEffect(function()
        local current = var18.current
        var18.current = tbl1.targetTextChannel
        if current and current ~= tbl1.targetTextChannel and var1 and var11 and not var14 then
            var15(true)
        end
    end, {
        tbl1.targetTextChannel,
        var1,
        var11,
        var14
    })
    local var20 = Localization.useLocalization(
        {
            headerText = "CoreScripts.TextChat.Tooltip.Global.Header",
            bodyText = "CoreScripts.TextChat.Tooltip.Global.Body"
        }
    )

    if not (tbl1.visible and var1 and var10) then
        return nil
    end

    local function onAnchorChanged(arg1)
        local parent = arg1.Parent
        if parent and parent:IsA("GuiObject") then
            var8(parent.AbsoluteSize.X)
        end
    end

    return React.createElement(Coachmark, {
        title = var20.headerText,
        text = var20.bodyText,
        isOpen = var12 and var2 and not var14,
        onClose = onClose,
        side = PopoverSide.Right,
        align = PopoverAlign.Start,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(xScale, -13, 0, -48),
        onAbsoluteSizeChanged = onAnchorChanged,
        onAbsolutePositionChanged = onAnchorChanged
    }, {
        AnchorSizer = React.createElement("Frame", {
            Size = UDim2.new(0, 1, 0, Config.ChannelTabsSettings.HorizontalBarHeight),
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        })
    })
end

local function GlobalChatTooltip(tbl1)
    if FFlagExpChatUseUnifiedTooltipStore then
        return GlobalChatTooltipNew(tbl1)
    end
    return GlobalChatTooltipLegacy(tbl1)
end

return GlobalChatTooltip
