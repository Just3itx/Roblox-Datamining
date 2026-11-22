-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCarousel = script:FindFirstAncestor("SocialCarousel")
local SocialCarouselParent = SocialCarousel.Parent

local React = require(SocialCarouselParent.React)
local Foundation = require(SocialCarouselParent.Foundation)

local useTokens = Foundation.Hooks.useTokens
local usePreferences = Foundation.Hooks.usePreferences
local View = Foundation.View
local FoundationText = Foundation.Text

local MarqueeTextMotion = require(script.Parent.MarqueeTextMotion)
local MarqueePlayStatus = require(SocialCarousel.Common.Enums).MarqueePlayStatus

local function renderCopy(text: string, fontStyle, xOffset: number, xOffset2: number)
    return React.createElement(FoundationText, {
        Text = text,
        fontStyle = fontStyle,
        TextTruncate = Enum.TextTruncate.None,
        Size = UDim2.fromOffset(xOffset2, 0),
        Position = UDim2.fromOffset(xOffset, 0),
        tag = "auto-y text-align-x-left content-default"
    })
end

local function MarqueeText(tbl1)
    local var1 = useTokens()
    local var2 = usePreferences()
    local fontStyle = tbl1.fontStyle or var1.Typography.LabelSmall
    local var3 = if tbl1.speed ~= nil then tbl1.speed else MarqueeTextMotion.DEFAULT_SPEED
    local var4 = if tbl1.maxLoops ~= nil then tbl1.maxLoops else MarqueeTextMotion.DEFAULT_MAX_LOOPS
    local var5 = tbl1.playStatus or MarqueePlayStatus.Playing
    local reducedMotion = if tbl1.reducedMotion ~= nil then tbl1.reducedMotion else var2.reducedMotion
    local var6 = tbl1.direction or MarqueeTextMotion.textDirectionFromLocale(game:GetService("LocalizationService").RobloxLocaleId)
    local var7 = tbl1.heartbeat or game:GetService("RunService").Heartbeat

    local xOffset, var8 = React.useState(0)
    local var9, var10 = React.useState(0)
    local bool1, var11 = React.useState(false)

    local var12 = React.useRef(if tbl1.initialOffset == nil then 0 else tbl1.initialOffset)

    local var13, var14 = React.useBinding(var12.current)

    local var15 = React.useRef(0)

    local var16 = React.useRef(false)
    local var17 = React.useRef(tbl1.saveOffset)
    var17.current = tbl1.saveOffset

    local var18 = MarqueeTextMotion.travelDistance(xOffset, var9)
    local var19 = MarqueeTextMotion.overflows(xOffset, var9)
    local bool2

    if var5 == MarqueePlayStatus.Idle then
        bool2 = false
    else
        bool2 = not (reducedMotion or bool1)

        if bool2 then
            if var18 > 0 then
                bool2 = var19 or tbl1.marqueeShortTitlesEnabled == true
            else
                bool2 = false
            end
        end
    end

    if tbl1.holdForNextLoop ~= true then
        bool1 = false
    elseif bool1 then
        if var5 == MarqueePlayStatus.Idle then
            bool1 = false
        else
            bool1 = not reducedMotion

            if bool1 then
                if var18 > 0 then
                    bool1 = var19 or tbl1.marqueeShortTitlesEnabled == true
                else
                    bool1 = false
                end
            end
        end
    end

    local var20 = bool2 and var5 == MarqueePlayStatus.Playing
    local var21 = bool2 or bool1
    local var22 = not var21 and var19

    React.useEffect(function()
        local current = var12.current
        var12.current = 0
        var15.current = 0
        var16.current = false
        var14(current)
        var11(false)
        local current2 = var17.current
        if current2 ~= nil then
            current2(current)
        end
    end, {
        tbl1.text,
        var4,
        reducedMotion,
        tbl1.runId,
        var17
    })
    local var23 = React.useCallback(function(num1: number)
        if not var20 then
            return
        end

        local var23 = MarqueeTextMotion.advance(
            {
                offset = var13:getValue(),
                loopsCompleted = var15.current,
                finished = false
            },
            var18,
            var3,
            num1,
            var4
        )
        var15.current = var23.loopsCompleted

        if not var23.finished then
            var14(var23.offset)
            local current = var17.current
            if current ~= nil then
                current(var23.offset)
            end

            return
        end

        if var16.current then
            return
        end
        var16.current = true
        var14(0)
        var11(true)
        if tbl1.onFinished then
            tbl1.onFinished()
        end
    end, {
        var20,
        var18,
        var3,
        var4,
        tbl1.onFinished,
        var13,
        var17
    })
    React.useEffect(function()
        if not var20 then
            return function() end
        end

        local connection = var7:Connect(var23)
        return function()
            connection:Disconnect()
        end
    end, { var20, var7, var23 })

    React.useEffect(function()
        return function()
            if var16.current then
                return
            end
            local current = var17.current
            if current ~= nil then
                current(var13:getValue())
            end
        end
    end, { var13, var17 })

    local bool3 = var6 == Enum.TextDirection.RightToLeft

    local var24 = var13:map(function(num1: number): UDim2
        if not var21 then
            return UDim2.fromOffset(0, 0)
        end
        local xOffset2 = MarqueeTextMotion.signedOffset(num1, var6)
        if bool3 then
            return UDim2.new(1, xOffset2, 0, 0)
        end
        return UDim2.fromOffset(xOffset2, 0)
    end)

    local element

    if var21 then
        local xOffset2 = var18 + xOffset
        element = React.createElement(View, {
            Size = UDim2.fromOffset(xOffset2, 0),
            tag = "auto-y no-clip",
            AnchorPoint = if bool3 then Vector2.new(1, 0) else Vector2.new(0, 0),
            Position = var24
        }, {
            Leading = renderCopy(tbl1.text, fontStyle, if bool3 then var18 else 0, xOffset),
            Trailing = renderCopy(tbl1.text, fontStyle, if bool3 then 0 else var18, xOffset)
        })
    else
        element = React.createElement(FoundationText, {
            Text = tbl1.text,
            fontStyle = fontStyle,
            TextTruncate = if var22 then Enum.TextTruncate.AtEnd else Enum.TextTruncate.None,
            tag = {
                ["size-full-0 auto-y text-align-x-center text-truncate-end content-default"] = var22,
                ["size-full-0 auto-y text-align-x-center content-default"] = not var22
            },
            testId = "marquee-text"
        })
    end

    return React.createElement(View, {
        tag = "size-full-0 auto-y clip",
        LayoutOrder = tbl1.LayoutOrder,
        onAbsoluteSizeChanged = function(arg1)
            var10(arg1.AbsoluteSize.X)
        end
    }, {
        Measure = React.createElement(FoundationText, {
            Text = tbl1.text,
            fontStyle = fontStyle,
            TextTransparency = 1,
            TextTruncate = Enum.TextTruncate.None,
            tag = "size-0 auto-x",
            onAbsoluteSizeChanged = function(arg1)
                var8(arg1.AbsoluteSize.X)
            end
        }),
        Content = element
    })
end

return MarqueeText
