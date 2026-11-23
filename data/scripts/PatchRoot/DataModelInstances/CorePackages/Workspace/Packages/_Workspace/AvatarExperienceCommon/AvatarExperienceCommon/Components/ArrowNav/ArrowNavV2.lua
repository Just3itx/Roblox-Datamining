-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")

local AvatarExperienceCommonParent = AvatarExperienceCommon.Parent

local React = require(AvatarExperienceCommonParent.React)
local Foundation = require(AvatarExperienceCommonParent.Foundation)
local Icon = Foundation.Icon
local Enums = Foundation.Enums

local Constants = require(AvatarExperienceCommon.Constants)
local useArrowNavScrollBehavior = require(AvatarExperienceCommon.Hooks.useArrowNavScrollBehavior)

local function ArrowNavV2(tbl1)
    local var1 = useArrowNavScrollBehavior({
        navDirection = tbl1.navDirection,
        onPressHoldInputBegan = tbl1.onPressHoldInputBegan,
        onPressHoldInputEnded = tbl1.onPressHoldInputEnded,
        defaultUseProps = tbl1.defaultUseProps
    })

    local handleInputBegan = var1.handleInputBegan
    local handleInputEnded = var1.handleInputEnded

    local onActivated = React.useCallback(function() end, {})

    local name = if tbl1.navDirection == Constants.NAVIGATION_DIRECTION.IS_LEFT then "chevron-small-left" else "chevron-small-right"

    local actionStandard = tbl1.tokens.Color.ActionStandard

    local color3 = tbl1.tokens.Color.Surface.Surface_0.Color3
    local surface0Transparency = tbl1.tokens.Color.Surface.Surface_0.Transparency

    local size900 = tbl1.tokens.Size.Size_900
    local medium = tbl1.tokens.Padding.Medium
    local size700 = tbl1.tokens.Size.Size_700
    local size100 = tbl1.tokens.Size.Size_100

    local createElement = React.createElement
    local str2 = "Frame"
    local tbl2 = {
        AnchorPoint = tbl1.AnchorPoint,
        Position = tbl1.Position,
        Visible = tbl1.Visible,
        Size = UDim2.fromOffset(size900, size900 + medium),
        BackgroundColor3 = color3,
        BackgroundTransparency = surface0Transparency,
        BorderSizePixel = 0
    }
    local tbl3 = {
        GradientFrame = React.createElement("Frame", {
            AnchorPoint = if tbl1.navDirection == Constants.NAVIGATION_DIRECTION.IS_LEFT then Vector2.new(0, 0.5) else Vector2.new(1, 0.5),
            Position = if tbl1.navDirection == Constants.NAVIGATION_DIRECTION.IS_LEFT then UDim2.new(1, 0, 0.5, 0) else UDim2.new(0, 0, 0.5, 0),
            Size = UDim2.fromOffset(size700, size900 + medium),
            BackgroundColor3 = color3,
            BackgroundTransparency = 0,
            BorderSizePixel = 0
        }, {
            UIGradient = React.createElement("UIGradient", {
                Transparency = NumberSequence.new(
                    { NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.9, 0), NumberSequenceKeypoint.new(1, 0) }
                ),
                Rotation = if tbl1.navDirection == Constants.NAVIGATION_DIRECTION.IS_LEFT then 180 else 0
            })
        }),
        InnerFrame = 0
    }

    local createElement2 = React.createElement
    local view = Foundation.View
    local tbl4 = {
        AnchorPoint = if tbl1.navDirection == Constants.NAVIGATION_DIRECTION.IS_LEFT then Vector2.new(0, 0.5) else Vector2.new(1, 0.5),
        Position = if tbl1.navDirection == Constants.NAVIGATION_DIRECTION.IS_LEFT then UDim2.new(0, size100, 0.5, 0) else UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.fromOffset(size900, size900),
        backgroundStyle = actionStandard.Background,
        cornerRadius = UDim.new(0.5, 0),
        onActivated = onActivated
    }
    local tbl5 = {
        ArrowIcon = React.createElement(Icon, {
            name = name,
            size = Enums.IconSize.Medium,
            style = actionStandard.Foreground,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5)
        }),
        StopPropagationOverlay = React.createElement("TextButton", {
            Active = false,
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            Selectable = false,
            Size = UDim2.new(1, 0, 1, 0),
            Text = "",
            ZIndex = 0,
            [React.Event.InputBegan] = handleInputBegan,
            [React.Event.InputEnded] = handleInputEnded
        })
    }
    tbl3.InnerFrame = createElement2(view, tbl4, tbl5)
    return createElement(str2, tbl2, tbl3)
end

return ArrowNavV2
