-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local React = require(AvatarExperienceCommonParent.React)
local Foundation = require(AvatarExperienceCommonParent.Foundation)
local AvatarExperienceFlags = require(AvatarExperienceCommonParent.AvatarExperienceFlags)

local CursorType = Foundation.Enums.CursorType
local useCursor = Foundation.Hooks.useCursor

local FFlagAXResetAvatarButton = AvatarExperienceFlags.FFlagAXResetAvatarButton

return (React.forwardRef(function(tbl1, ref)
    local var1 = Foundation.Hooks.useTokens()

    local selectionImageObject = useCursor(CursorType.SmallPill)
    local var3, var4 = React.useBinding(false)

    local onStateChanged = React.useCallback(function(arg1)
        if arg1 == Foundation.Enums.ControlState.Default then
            var4(false)
        elseif arg1 == Foundation.Enums.ControlState.Hover then
            var4(true)
        end
    end, {})

    return React.createElement(Foundation.View, {
        tag = if FFlagAXResetAvatarButton then "row auto-xy align-y-center radius-circle padding-x-large gap-xsmall size-0-1000" else "row auto-xy align-y-center radius-circle padding-x-large gap-xsmall size-0-1100",
        testId = "RobuxBalance",
        ref = ref,
        onActivated = tbl1.onActivated,
        onStateChanged = onStateChanged,
        backgroundStyle = var3:map(function(arg1)
            if arg1 then
                return var1.Color.Shift.Shift_200
            end

            return var1.Color.Surface.Surface_0
        end),
        stateLayer = {
            affordance = Foundation.Enums.StateLayerAffordance.None
        },
        selection = {
            Selectable = true,
            SelectionImageObject = selectionImageObject,
            NextSelectionLeft = tbl1.NextSelectionLeft
        }
    }, {
        RobuxBalanceIcon = React.createElement(Foundation.Icon, {
            name = "robux",
            style = var1.Color.ActionStandard.Foreground,
            size = Foundation.Enums.IconSize.Small,
            LayoutOrder = 1,
            testId = "RobuxBalanceIcon"
        }),
        RobuxBalanceText = React.createElement(Foundation.Text, {
            tag = "auto-xy",
            testId = "RobuxBalanceText",
            Text = tbl1.text,
            textStyle = var1.Color.Content.Emphasis,
            fontStyle = var1.Typography.LabelMedium,
            LayoutOrder = 2,
            selection = { Selectable = false }
        })
    })
end))
