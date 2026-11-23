-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent

local React = require(AppBloxParent.React)
local Foundation = require(AppBloxParent.Foundation)
local useLocalization = require(AppBloxParent.Localization).Hooks.useLocalization

local FoundationText = Foundation.Text
local View = Foundation.View
local ControlState = Foundation.Enums.ControlState
local useProperty = require(AppBloxParent.GuiObjectUtils).useProperty
local useTokens = Foundation.Hooks.useTokens
local SignalsReact = require(AppBloxParent.SignalsReact)
local TextSize = require(AppBloxParent.TextSize)
local Cryo = require(AppBloxParent.Cryo)

local tbl1 = { Selectable = true }
local function func1() end

local tbl2 = {
    affordance = Foundation.Enums.StateLayerAffordance.None
}

local function getCompactLineMeasureText(compactNumberOfLines: number): string
    if compactNumberOfLines <= 0 then
        return ""
    end
    local tbl3 = {}
    for _ = 1, compactNumberOfLines do
        table.insert(tbl3, "A")
    end
    return table.concat(tbl3, "\n")
end

local function calculateBlankLineAdjustedHeight(num1: number, compactNumberOfLines: number, num2: number, num3: number) -- Luacid: Inlined by compiler; 1 call site recovered
    local num4 = if compactNumberOfLines > 0 and num1 > 0 then num1 / compactNumberOfLines else 0
    if num4 > 0 and num2 > 0 and math.floor(num2 / num4 + 0.5) + 1 == compactNumberOfLines then
        local num5 = num1 + num4
        if num5 < num3 then
            return math.ceil(num5)
        end
    end

    return num1
end

return React.memo(function(tbl3) -- name: ExpandableText
    local var1 = (tbl3.text or ""):gsub("[\r\n]+$", "")
    local var2 = SignalsReact.useSignalState(function(arg1)
        return TextSize.getTextSizeStore(arg1).getTextSizeOffset(arg1)
    end)
    local var3 = useTokens()

    local var4 = tbl3.fontStyle or var3.Typography.CaptionLarge
    local fontStyle = Cryo.Dictionary.join(var4, { FontSize = var4.FontSize + var2 })

    local textStyle = tbl3.textStyle or var3.Color.Content.Default
    local compactNumberOfLines = tbl3.compactNumberOfLines or 3

    local var7 = tbl3.pressedTextStyle or var3.Color.Content.Muted
    local var8, var9 = React.useBinding(ControlState.Default)
    local var10 = var8:map(function(str1: string)
        return if str1 == ControlState.Pressed or str1 == ControlState.SelectedPressed then var7 else textStyle
    end)

    local var11, var12 = React.useState(tbl3.expandedInitially or false)

    local onActivated = React.useCallback(function()
        var12(function(arg1): boolean
            local bool1 = not arg1
            if tbl3.onExpandChanged then
                tbl3.onExpandChanged(bool1)
            end
            return bool1
        end)
    end, { tbl3.onExpandChanged })

    local var14 = useLocalization(
        {
            moreText = "CommonUI.Features.Action.MoreLowercase",
            lessText = "CommonUI.Features.Action.LessLowercase"
        }
    )

    local ref = React.useRef(nil)
    local var16 = useProperty(ref, "AbsoluteSize")
    local var5 = React.useRef(nil)
    local var18 = useProperty(var5, "AbsoluteSize")
    local var6 = React.useRef(nil)
    local var20 = useProperty(var6, "AbsoluteSize")

    local var21 = var16 and var16.X > 0
    local y = var20 and var20.Y or 0
    local y2 = var18 and var18.Y or 0

    local var13 = React.useRef(nil)
    local var23 = useProperty(var13, "AbsoluteSize")

    local var24 = React.useMemo(function()
        if not tbl3.avoidBlankLineClip then
            return nil
        end
        local var24 = var1:find("\n\n")
        if not var24 then
            return nil
        end
        return var1:sub(1, var24 - 1)
    end, { var1, tbl3.avoidBlankLineClip })

    if var24 then
        y2 = calculateBlankLineAdjustedHeight(y2, compactNumberOfLines, var23 and var23.Y or 0, y)
    end

    local bool1 = not tbl3.expandedInitially and y2 + 1 < y
    local var25 = var11 or not bool1

    local lessText = var14.lessText

    if bool1 and not var11 then
        lessText = var14.moreText
    else
        y2 = y
    end

    if var1 == "" then
        return nil
    end

    local var26 = var25 and {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y
    }
        or {
            Size = UDim2.new(1, 0, 0, math.ceil(y2))
        }

    local createElement = React.createElement
    local var27 = View
    local tbl4 = {
        tag = "col size-full-0 auto-y",
        LayoutOrder = tbl3.LayoutOrder,
        selection = if tbl3.selectable == false then nil else tbl1,
        onActivated = if tbl3.selectable == false then nil else func1,
        stateLayer = if tbl3.selectable == false then nil else tbl2,
        ref = ref
    }
    local tbl5 = {
        TextContent = 0,
        ToggleExpandButton = 0,
        CompactTextMeasure = 0,
        FullTextMeasure = 0,
        PrefixMeasure = 0
    }
    local var28

    if var21 and (var25 or y2 > 0) then
        local createElement2 = React.createElement
        local var29 = FoundationText
        local join = Cryo.Dictionary.join
        local tbl6 = {
            LayoutOrder = 1,
            Text = var1,
            fontStyle = fontStyle,
            textStyle = 0,
            TextWrapped = true,
            TextXAlignment = 0,
            TextYAlignment = 0,
            ClipsDescendants = 0,
            onActivated = 0,
            onStateChanged = 0,
            selection = 0,
            stateLayer = 0
        }

        if not bool1 then
            var10 = textStyle
        end

        tbl6.textStyle = var10

        tbl6.TextXAlignment = Enum.TextXAlignment.Left
        tbl6.TextYAlignment = Enum.TextYAlignment.Top
        tbl6.ClipsDescendants = if bool1 then not var11 else nil
        tbl6.onActivated = if bool1 then onActivated else nil
        if not bool1 then
            var9 = nil
        end

        tbl6.onStateChanged = var9
        tbl6.selection = bool1 and { Selectable = false } or nil
        tbl6.stateLayer = if bool1 then tbl2 else nil
        var28 = createElement2(var29, join(tbl6, var26))
    else
        var28 = nil
    end

    tbl5.TextContent = var28

    tbl5.ToggleExpandButton = if bool1 then React.createElement(FoundationText, {
        LayoutOrder = 2,
        tag = "auto-xy radius-small",
        Text = `<u><b>{lessText}</b></u>`,
        fontStyle = fontStyle,
        textStyle = var3.Color.Content.Emphasis,
        onActivated = onActivated,
        RichText = true
    }) else nil

    tbl5.CompactTextMeasure = React.createElement(FoundationText, {
        Visible = false,
        IgnoreLayout = true,
        ref = var5,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = 3,
        Text = getCompactLineMeasureText(compactNumberOfLines),
        fontStyle = fontStyle,
        textStyle = textStyle,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top
    })

    tbl5.FullTextMeasure = React.createElement(FoundationText, {
        Visible = false,
        IgnoreLayout = true,
        ref = var6,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = 4,
        Text = var1,
        fontStyle = fontStyle,
        textStyle = textStyle,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top
    })
    local element

    if var24 then
        element = React.createElement(FoundationText, {
            Visible = false,
            IgnoreLayout = true,
            ref = var13,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            LayoutOrder = 5,
            Text = var24,
            fontStyle = fontStyle,
            textColor = nil,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top
        })
    else
        element = nil
    end

    tbl5.PrefixMeasure = element
    return createElement(var27, tbl4, tbl5)
end)
