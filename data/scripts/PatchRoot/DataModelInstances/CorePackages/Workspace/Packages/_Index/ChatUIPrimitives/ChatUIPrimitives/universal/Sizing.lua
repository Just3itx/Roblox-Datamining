-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:41:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local Responsive = require(ChatUIPrimitivesParent.Responsive)

local FFlagExpChatMessageListScrollParity = require(ChatUIPrimitives.Flags.FFlagExpChatMessageListScrollParity)

local Keys = Responsive.Keys
local getMinWidthFor = Responsive.BreakpointConfig.getMinWidthFor

local tbl1 = {
    {
        Key = Keys.Large,
        minWidth = getMinWidthFor(Keys.Large)
    },
    {
        Key = Keys.Medium,
        minWidth = getMinWidthFor(Keys.Medium)
    },
    { Key = "Regular", minWidth = 480 },
    { Key = "Compact", minWidth = 1 }
}

local tbl2 = {
    [Keys.Large] = { density = "regular", widthUnits = 3 },
    [Keys.Medium] = { density = "regular", widthUnits = 2 },
    Regular = { density = "regular", widthUnits = 1 },
    Compact = { density = "compact", widthUnits = 1 }
}

local Context = React.createContext(nil)

local function toFontStyle(tbl3) -- Luacid: Inlined by compiler; 4 call sites recovered
    return {
        Font = tbl3.Font,
        FontSize = tbl3.FontSize,
        LineHeight = tbl3.LineHeight
    }
end

local function getLineHeight(tbl3): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return math.round(tbl3.FontSize * tbl3.LineHeight)
end

local function resolve(density: string, num1: number, arg1)
    local bool1 = density == "compact"
    local paddingX = if bool1 then arg1.Padding.Small else arg1.Padding.Medium
    local maxWidth = arg1.Size.Size_3000 * (if bool1 then 2 else num1)
    local contentMaxWidth = math.max(0, maxWidth - paddingX * 2)
    local var3 = if bool1 then arg1.Typography.CaptionSmall else arg1.Typography.BodyMedium
    local fontStyle = toFontStyle(var3)
    local size100 = arg1.Size.Size_100
    local tbl4 = {
        density = density,
        bubble = 0,
        avatar = 0,
        row = 0,
        username = 0,
        timestamp = 0,
        system = 0,
        reply = 0,
        discussion = 0,
        list = 0
    }
    local bubble = {
        paddingX = paddingX,
        paddingY = if bool1 then arg1.Padding.XSmall else arg1.Padding.Small,
        minHeight = if bool1 then 0 else arg1.Size.Size_1000,
        cornerRadius = if bool1 then arg1.Size.Size_350 else arg1.Size.Size_500,
        maxWidth = maxWidth,
        contentMaxWidth = contentMaxWidth,
        fontStyle = 0
    }
    local var4 = if bool1 then arg1.Typography.BodySmall else arg1.Typography.BodyLarge
    bubble.fontStyle = toFontStyle(var4)
    tbl4.bubble = bubble

    tbl4.avatar = {
        tag = {
            ["size-500-500"] = bool1,
            ["size-700-700"] = not bool1
        }
    }
    tbl4.row = {
        tag = {
            ["padding-x-small"] = bool1,
            ["padding-x-medium"] = not bool1
        }
    }
    tbl4.username = {
        tag = {
            ["padding-left-small text-caption-small"] = bool1,
            ["padding-left-medium text-caption-medium"] = not bool1
        }
    }
    tbl4.timestamp = {
        tag = {
            ["padding-top-small text-caption-small"] = bool1,
            ["text-body-large"] = not bool1
        }
    }
    tbl4.system = {
        tag = {
            ["padding-top-medium text-caption-small"] = bool1,
            ["padding-bottom-xsmall padding-top-large text-caption-medium"] = not bool1
        }
    }
    tbl4.reply = {
        fontStyle = fontStyle,
        markerWidth = size100,
        textMaxWidth = math.max(0, contentMaxWidth - size100 - arg1.Gap.Small),
        textMaxHeight = math.ceil(fontStyle.FontSize * fontStyle.LineHeight * 3),
        leftLabelTag = {
            ["padding-left-small text-align-x-left text-caption-small"] = bool1,
            ["padding-left-medium text-align-x-left text-caption-medium"] = not bool1
        },
        rightLabelTag = {
            ["padding-right-small text-align-x-right text-caption-small"] = bool1,
            ["padding-right-medium text-align-x-right text-caption-medium"] = not bool1
        }
    }
    local discussion = {
        frameTag = if bool1 then "col size-full-0 auto-y padding-x-small" else "col size-full-0 auto-y padding-x-medium",
        headRowTag = if bool1 then "row align-x-left align-y-top size-full-0 auto-y gap-small padding-top-medium" else "row align-x-left align-y-top size-full-0 auto-y gap-medium padding-top-large",
        continuationRowTag = if bool1 then "row align-x-left align-y-top size-full-0 auto-y gap-small padding-top-xxsmall" else "row align-x-left align-y-top size-full-0 auto-y gap-medium padding-top-xxsmall",
        gutterTag = if bool1 then "size-600-0" else "size-800-0",
        avatarTag = if bool1 then "size-600-600" else "size-800-800",
        columnTag = "col grow size-0 auto-y gap-xsmall",
        topLineTag = "row align-y-center size-full-0 auto-y gap-xsmall",
        nameTag = if bool1 then "auto-xy text-align-x-left text-caption-small content-default" else "auto-xy text-align-x-left text-caption-large content-default",
        timestampTag = if bool1 then "auto-xy padding-x-xsmall text-caption-small content-muted" else "auto-xy padding-x-xsmall text-body-small content-muted",
        estimatedRowHeight = 0
    }
    local var5 = if bool1 then arg1.Padding.Medium else arg1.Padding.Large
    local var6 = if bool1 then arg1.Typography.CaptionSmall else arg1.Typography.CaptionLarge
    local var7 = var5 + getLineHeight(toFontStyle(var6)) + arg1.Gap.XSmall
    local tbl8 = toFontStyle(arg1.Typography.BodyLarge)
    discussion.estimatedRowHeight = var7 + getLineHeight(tbl8)
    tbl4.discussion = discussion

    tbl4.list = {
        scrollBarThickness = bool1 and (if FFlagExpChatMessageListScrollParity then 8 else 4) or 12,
        scrollBarInset = if FFlagExpChatMessageListScrollParity then Enum.ScrollBarInset.Always else Enum.ScrollBarInset.ScrollBar,
        scrollBarColor = if FFlagExpChatMessageListScrollParity then arg1.Color.Shift.Shift_400.Color3 else nil
    }
    return tbl4
end

local function useResolvedSizing(density: string, num1: number)
    local var1 = Foundation.Hooks.useTokens()
    return React.useMemo(function()
        return (resolve(density, num1, var1))
    end, { density, num1, var1 })
end

return {
    Context = Context,
    Provider = function(tbl3) -- name: SizingProvider
        local value = useResolvedSizing(tbl3.density, tbl3.widthUnits or 1)
        return React.createElement(Context.Provider, { value = value }, tbl3.children)
    end,
    COMPACT_BELOW_WIDTH = 480,
    resolve = resolve,
    useMeasured = function()
        local var1 = Responsive.useResponsive(tbl1)
        local var2 = React.useRef(nil)
        local current = tbl2[var1]
        if current ~= nil then
            var2.current = current
        end
        return var2.current
    end,
    useResolvedSizing = useResolvedSizing,
    useSizing = function()
        local var1 = React.useContext(Context)
        local var2 = useResolvedSizing("regular", 1)
        return if var1 == nil then var2 else var1
    end
}
