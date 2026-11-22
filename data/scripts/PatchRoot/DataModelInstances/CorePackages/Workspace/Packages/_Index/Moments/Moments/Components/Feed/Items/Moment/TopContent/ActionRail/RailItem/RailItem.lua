-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)
local ReactUtils = require(MomentsParent.ReactUtils)
local Foundation = require(MomentsParent.Foundation)

local getColorStyleWithTransparency = require(Moments.Utils.getColorStyleWithTransparency)
local FFlagMomentsActionRailSpacing = require(Moments.Flags.FFlagMomentsActionRailSpacing)

local Icon = Foundation.Icon
local FoundationText = Foundation.Text
local View = Foundation.View

local IconSize = Foundation.Enums.IconSize
local useTokens = Foundation.Hooks.useTokens

local function formatCount(num1: number?, bool1: boolean): string
    if num1 == nil then
        return ""
    end

    local str1 = if num1 >= 1000000 then string.format("%.1fM", num1 / 1000000) elseif num1 >= 1000 then string.format("%.1fK", num1 / 1000) else tostring(num1)

    if bool1 then
        return `{str1}+`
    end

    return str1
end

return React.memo(function(tbl1) -- name: RailItem
    local count = tbl1.count

    local nextOrder = ReactUtils.createNextOrder()
    local var1 = useTokens()

    local var2 = tbl1.animationRatio:map(function(num1: number)
        return getColorStyleWithTransparency(var1.Color.Content.Emphasis, num1)
    end)

    local tag = if FFlagMomentsActionRailSpacing then "col align-x-center align-y-center gap-small size-1200-1200 auto-xy radius-medium" else "col align-x-center align-y-center gap-xsmall size-1200-1200 radius-medium"

    return React.createElement(View, {
        LayoutOrder = tbl1.LayoutOrder,
        tag = tag,
        isDisabled = tbl1.isDisabled,
        onActivated = tbl1.onActivated,
        ref = tbl1.nativeRef,
        testId = tbl1.testId
    }, {
        Slot = if type(tbl1.slot) == "string" then React.createElement(Icon, { LayoutOrder = nextOrder(), name = tbl1.slot, size = IconSize.Large, style = var2 }) else React.createElement(View, { tag = "auto-xy", Active = tbl1.isDisabled ~= false, LayoutOrder = nextOrder() }, tbl1.slot),
        Count = if count then React.createElement(FoundationText, {
            LayoutOrder = nextOrder(),
            tag = "auto-xy text-caption-large text-align-x-center content-emphasis",
            Text = count:map(function(num1: number?): string
                return (formatCount(num1, tbl1.countIsCapped == true))
            end),
            Visible = count:map(function(num1: number?): boolean
                return num1 ~= nil
            end),
            textStyle = var2
        }) else nil
    })
end)
