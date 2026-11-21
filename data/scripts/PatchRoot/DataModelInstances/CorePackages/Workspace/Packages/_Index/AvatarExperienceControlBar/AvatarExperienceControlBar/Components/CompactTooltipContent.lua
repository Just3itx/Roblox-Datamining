-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceControlBarParent = script:FindFirstAncestor("AvatarExperienceControlBar").Parent
local React = require(AvatarExperienceControlBarParent.React)
local Foundation = require(AvatarExperienceControlBarParent.Foundation)
local FocusNavigationUtils = require(AvatarExperienceControlBarParent.FocusNavigationUtils)
local InputHandlers = require(AvatarExperienceControlBarParent.InputHandlers)
local ReactFocusNavigation = require(AvatarExperienceControlBarParent.ReactFocusNavigation)
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum

local selection = { Selectable = false }
local tbl2 = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

local function CompactTooltipContent(tbl3)
    local var1 = Foundation.Hooks.useTokens()
    local var2 = Foundation.Hooks.useScaledValue(296)
    local bool1 = tbl3.onDismiss ~= nil
    local xOffset = if bool1 then var1.Size.Size_800 else 0
    local var3 = if bool1 then var1.Gap.XSmall else 0
    local x = var2 - var1.Padding.Medium * 2 - xOffset - var3
    local sizeConstraint = React.useMemo(function()
        return {
            MaxSize = Vector2.new(x, math.huge)
        }
    end, { x })
    local var5 = React.useMemo(function()
        return {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(function(arg1)
                    if tbl3.onDismiss then
                        tbl3.onDismiss()
                        arg1:cancel()
                    end
                end)
            }
        }
    end, { tbl3.onDismiss })
    local var6 = ReactFocusNavigation.useEventMap(tbl2)
    local ref = ReactFocusNavigation.useEventHandlerMap(var5, var6)

    local createElement = React.createElement
    local view = Foundation.View
    local tbl4 = {
        ref = ref,
        selectionGroup = false,
        selection = selection,
        tag = "row align-y-center gap-xsmall auto-xy padding-medium",
        testId = "--control-bar-compact-tooltip"
    }

    local tbl5 = {
        Body = React.createElement(Foundation.Text, {
            LayoutOrder = 1,
            Text = tbl3.bodyText,
            tag = "auto-xy text-body-medium text-wrap text-align-x-left content-inverse-default",
            sizeConstraint = sizeConstraint
        }),
        CloseSlot = 0
    }
    local element

    if bool1 then
        element = React.createElement(
            Foundation.View,
            {
                LayoutOrder = 2,
                Size = UDim2.fromOffset(xOffset, var1.Size.Size_500 + var1.Size.Size_50)
            },
            {
                Close = React.createElement(Foundation.View, {
                    onActivated = tbl3.onDismiss,
                    tag = "position-center-center anchor-center-center size-800-800 radius-medium",
                    stateLayer = {
                        mode = Foundation.Enums.StateLayerMode.Inverse
                    },
                    selection = { Selectable = true },
                    testId = "--control-bar-tooltip-close"
                }, {
                    Icon = React.createElement(Foundation.Icon, {
                        name = Foundation.Enums.IconName.X,
                        size = Foundation.Enums.IconSize.Medium,
                        style = var1.Inverse.Content.Emphasis,
                        Position = UDim2.fromScale(0.5, 0.5),
                        AnchorPoint = Vector2.new(0.5, 0.5)
                    })
                })
            }
        )
    else
        element = nil
    end

    tbl5.CloseSlot = element
    return createElement(view, tbl4, tbl5)
end

return CompactTooltipContent
