-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:40:45Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Constants = require(Foundation.Constants)
local ControlState = require(Foundation.Enums.ControlState)

local StateLayerMode = require(Foundation.Enums.StateLayerMode)
local Text = require(Foundation.Components.Text)
local View = require(Foundation.Components.View)
local useTokens = require(Foundation.Providers.Style.useTokens)

local function buildDayTags(bool1: boolean, bandRadiusTag: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    local tbl1 = {
        ["size-full text-title-small text-align-x-center text-align-y-center"] = true,
        ["radius-circle"] = not bool1
    }
    if bool1 and bandRadiusTag and bandRadiusTag ~= "" then
        tbl1[bandRadiusTag] = true
    end
    return tbl1
end

local function CalendarGridDayLabel(tbl1)
    local var1 = useTokens()
    local color3 = if tbl1.isSelected then var1.Inverse.Content.Emphasis.Color3 elseif tbl1.isSelectable and tbl1.emphasizeText then var1.Color.Content.Emphasis.Color3 else var1.Color.Content.Muted.Color3
    local var2 = if tbl1.isSelected or tbl1.isSelectable and tbl1.emphasizeText then 0 else Constants.DISABLED_TRANSPARENCY
    local bool1 = tbl1.highlight == true and not tbl1.isSelected
    local tag = buildDayTags(bool1, tbl1.bandRadiusTag)

    local var3 = React.useMemo(function(): ((any) -> ())?
        return if tbl1.onHoverEnter == nil then nil else function(hover)
            if hover == ControlState.Hover then
                tbl1.onHoverEnter()
            end
        end
    end, { tbl1.onHoverEnter })

    local createElement = React.createElement
    local var4 = Text
    local tbl2 = {
        backgroundStyle = if tbl1.isSelected then var1.Color.System.Contrast elseif tbl1.highlight then var1.Color.ActionStandard.Background else nil,
        onActivated = if tbl1.isSelectable then tbl1.onActivated else nil,
        onStateChanged = 0,
        RichText = 0,
        stateLayer = 0,
        tag = 0,
        testId = 0,
        Text = 0,
        textStyle = 0
    }

    if not tbl1.isSelectable then
        var3 = nil
    end

    tbl2.onStateChanged = var3
    tbl2.RichText = not tbl1.isSelectable
    tbl2.stateLayer = {
        mode = if tbl1.isSelected then StateLayerMode.Inverse else StateLayerMode.Default
    }
    tbl2.tag = tag
    tbl2.testId = tbl1.testId
    tbl2.Text = if tbl1.isSelectable then tbl1.label else `<s>{tbl1.label}</s>`
    tbl2.textStyle = { Color3 = color3, Transparency = var2 }
    local day = createElement(var4, tbl2)

    local createElement2 = React.createElement
    local var5 = View
    local tbl3 = {
        LayoutOrder = tbl1.LayoutOrder,
        tag = "size-full"
    }
    local tbl4 = { Band = 0, Day = 0 }
    local element2

    if tbl1.bandPosition and tbl1.bandSize then
        element2 = React.createElement(View, {
            backgroundStyle = var1.Color.ActionStandard.Background,
            Position = tbl1.bandPosition,
            Size = tbl1.bandSize,
            tag = if tbl1.bandRadiusTag and tbl1.bandRadiusTag ~= "" then tbl1.bandRadiusTag else nil,
            ZIndex = 0
        })
    else
        element2 = nil
    end

    tbl4.Band = element2

    tbl4.Day = day
    return createElement2(var5, tbl3, tbl4)
end

return CalendarGridDayLabel
