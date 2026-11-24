-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")
local TextChatService = game:GetService("TextChatService")

local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local React = require(ExpChatParent.React)
local SignalsReact = require(ExpChatParent.SignalsReact)
local _Signals = require(ExpChatParent.Signals)

local Config = require(ExpChat.Config)
local advanceHistoryScroll = require(script.Parent.advanceHistoryScroll)

local useStyle = require(ExpChatParent.UIBlox).Core.Style.useStyle
local debounce = require(ExpChat.ChatWindow.Helpers.debounce)
local getFFlagExpChatSendWindowScrollEvent = require(ExpChat.Flags.getFFlagExpChatSendWindowScrollEvent)
local num1 = game:DefineFastInt("ExpChatWindowScrollV3Debounce", 0)
local FFlagExpChatLimitScrollingV2Window = require(ExpChat.Flags.FFlagExpChatLimitScrollingV2Window)
local FFlagExpChatScrollbarInset = require(ExpChat.Flags.FFlagExpChatScrollbarInset)
local FFlagExpChatFixWarmMountBottomLock = require(ExpChat.Flags.FFlagExpChatFixWarmMountBottomLock)
local FFlagExpChatRenderHistoricalMessages = require(ExpChat.Flags.FFlagExpChatRenderHistoricalMessages)

local ExpChatPerfTracker = require(ExpChatParent.ChatUIPrimitives).Telemetry.ExpChatPerfTracker
local FFlagExpChatPerfTrackerTabName = require(ExpChatParent.ChatUIPrimitives).Flags.FFlagExpChatPerfTrackerTabName
local _SocialLuaAnalytics = require(ExpChatParent.SocialLuaAnalytics)

local num2 = game:DefineFastInt("ExpChatScrollLockThreshold", 90) / 100

local function isScrollbarNearBottom(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local absoluteWindowSize = arg1.AbsoluteWindowSize
    local canvasPosition = arg1.CanvasPosition
    local absoluteCanvasSize = arg1.AbsoluteCanvasSize
    local var1 = absoluteCanvasSize - absoluteWindowSize
    local var2 = canvasPosition.Y / var1.Y

    return absoluteCanvasSize.Y <= absoluteWindowSize.Y or num2 <= var2
end

local function isMouseMovementOrTouch(preferredInput: Enum.PreferredInput): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return preferredInput == Enum.PreferredInput.KeyboardAndMouse or preferredInput == Enum.PreferredInput.Touch
end

local var1 = debounce(function()
    TextChatService:SendExpChatWindowScroll()
end, num1)

return React.memo(function(tbl1) -- name: BottomLockedScrollViewV3
    local theme = useStyle().Theme

    local ref = React.useRef(nil)
    local bool1 = tbl1.scrollToTopOnReset == true
    local var3 = React.useRef(not bool1)
    local var4 = React.useRef(nil)
    local var5 = React.useRef(false)
    local var6 = React.useRef(nil)
    local var7, var8 = React.useBinding(false)
    local var9 = React.useRef(false)
    local var10 = React.useRef({ canvasHeight = nil, historicalCount = 0 })

    local var11 = SignalsReact.useSignalState(tbl1.messageComponentsSignal)

    local var12 = React.useCallback(function()
        local preferredInput = UserInputService.PreferredInput

        if isMouseMovementOrTouch(preferredInput) then
            var8(true)
        end

        if preferredInput == Enum.PreferredInput.Touch then
            var9.current = true
        end
    end, { UserInputService.PreferredInput })

    local var13 = React.useCallback(function()
        local preferredInput = UserInputService.PreferredInput

        if isMouseMovementOrTouch(preferredInput) then
            var8(false)
        end

        if preferredInput ~= Enum.PreferredInput.Touch then
            return
        end

        var9.current = false

        if var6.current ~= nil and var6.current == var4.current and ref.current then
            ref.current.CanvasPosition = Vector2.new(0, 0)
            var5.current = true
            var6.current = nil
        end
    end, { UserInputService.PreferredInput })

    local var14 = React.useRef(nil)
    React.useEffect(function()
        return function()
            if var14.current then
                var14.current.cleanup()
            end
        end
    end, {})

    local var15 = React.useRef(tbl1.selectedChannelName)
    var15.current = tbl1.selectedChannelName

    local var16 = React.useCallback(function(arg1)
        if var14.current == nil then
            local current = var15.current
            var14.current = ExpChatPerfTracker.startChatWindowScrollInterval(
                ExpChatPerfTracker.Events.ChatWindowScrollInterval,
                arg1,
                {},
                FFlagExpChatPerfTrackerTabName and current and { tabName = current } or nil
            )
        end
        if var14.current then
            var14.current.onScrollTick()
        end
        var3.current = isScrollbarNearBottom(arg1)
        if getFFlagExpChatSendWindowScrollEvent() and not var3.current then
            var1()
        end
        if tbl1.onCanvasPositionChanged then
            local num3 = math.max(arg1.AbsoluteCanvasSize.Y - arg1.AbsoluteWindowSize.Y, 0)
            tbl1.onCanvasPositionChanged(arg1.CanvasPosition, num3)
        end
    end, { tbl1.onCanvasPositionChanged })

    local var17 = React.useCallback(function(arg1)
        if var3.current and not var9.current then
            arg1.CanvasPosition = Vector2.new(0, 2 ^ 53)
        end
    end, {})

    local scrollResetKey = tbl1.scrollResetKey

    React.useEffect(function()
        if var4.current ~= scrollResetKey then
            var4.current = scrollResetKey
            var5.current = false
            var6.current = nil
        end

        local var18 = scrollResetKey and bool1 and not var5.current
        local var19 = scrollResetKey and tbl1.isChannelBarVisible and not (bool1 or var5.current)
        if var18 then
            var3.current = false
            if not var9.current and ref.current then
                ref.current.CanvasPosition = Vector2.new(0, 0)
                var5.current = true
                var6.current = nil
                return
            end
            var6.current = scrollResetKey
            return
        end
        if not var19 then
            return
        end

        var3.current = true
        if not var9.current and ref.current then
            ref.current.CanvasPosition = Vector2.new(0, 2 ^ 53)
        end
    end, { scrollResetKey, tbl1.isChannelBarVisible, bool1 })

    React.useEffect(function()
        local current = ref.current
        if not current then
            return
        end

        local historicalMessageCountSignal = tbl1.historicalMessageCountSignal

        local connection = current:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(function()
            if FFlagExpChatRenderHistoricalMessages and historicalMessageCountSignal then
                local y = advanceHistoryScroll(var10.current, current.AbsoluteCanvasSize.Y, historicalMessageCountSignal(false))

                if y > 0 and not (var3.current or var9.current) then
                    local var18 = current
                    var18.CanvasPosition += Vector2.new(0, y)
                end
            end

            if var3.current and not var9.current and ref.current then
                ref.current.CanvasPosition = Vector2.new(0, 2 ^ 53)
            end
        end)

        return function()
            connection:Disconnect()
        end
    end, {
        var3.current,
        var9.current,
        ref.current,
        scrollResetKey,
        tbl1.historicalMessageCountSignal
    })

    local paddingTop = if type(tbl1.contentTopPadding) == "number" then UDim.new(0, tbl1.contentTopPadding) elseif tbl1.contentTopPadding == nil then nil else tbl1.contentTopPadding:map(function(offset: number): UDim
        return UDim.new(0, offset)
    end)

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        BackgroundTransparency = 1,
        Size = tbl1.Size,
        [React.Event.InputBegan] = var12,
        [React.Event.InputEnded] = var13
    }
    local tbl3 = {
        padding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, 0),
            PaddingBottom = UDim.new(0, 0),
            PaddingLeft = UDim.new(0, 8),
            PaddingRight = UDim.new(0, 8)
        }),
        scrollView = 0
    }
    local createElement2 = React.createElement
    local str2 = "ScrollingFrame"

    local tbl4 = {
        ref = ref,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        BorderSizePixel = 0,
        ScrollBarImageColor3 = theme.UIEmphasis.Color,
        ScrollBarImageTransparency = var7:map(function(arg1): number
            return if arg1 then 0 else 1
        end),
        ScrollBarThickness = Config.ChatWindowScrollBarThickness,
        VerticalScrollBarInset = if FFlagExpChatScrollbarInset then Enum.ScrollBarInset.Always else nil,
        ScrollingDirection = if FFlagExpChatLimitScrollingV2Window then Enum.ScrollingDirection.Y else nil,
        Selectable = false,
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        CanvasSize = UDim2.new(),
        [React.Change.CanvasPosition] = var16
    }

    local absoluteWindowSize = React.Change.AbsoluteWindowSize

    if not FFlagExpChatFixWarmMountBottomLock then
        var17 = nil
    end

    tbl4[absoluteWindowSize] = var17
    tbl3.scrollView = createElement2(str2, tbl4, {
        contentPadding = if paddingTop == nil then nil else React.createElement("UIPadding", { PaddingTop = paddingTop }),
        messages = React.createElement(React.Fragment, nil, var11)
    })
    return createElement(str1, tbl2, tbl3)
end)
