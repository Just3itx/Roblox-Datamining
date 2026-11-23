-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:10:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local IconButton = Foundation.IconButton
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize

local DisabledPlaytestTooltip = require(script.Parent.DisabledPlaytestTooltip)

local function PlayButton(tbl1)
    local icon = if tbl1.isActive then tbl1.activeIcon else tbl1.inActiveIcon
    local isDisabled = tbl1.isDisabled == true
    local isOpen, var3 = React.useState(false)

    local onActivated = React.useCallback(function()
        if isDisabled then
            var3(function(bool2: boolean): boolean
                return not bool2
            end)
            return
        end

        tbl1.onActivated()
    end, { isDisabled, tbl1.onActivated })
    local onPressedOutside = React.useCallback(function()
        var3(false)
    end, {})

    local tbl2 = {
        icon = icon,
        variant = tbl1.variant or ButtonVariant.OverMedia,
        size = InputSize.Medium,
        isCircular = true,
        isDisabled = isDisabled or tbl1.isUnavailable == true,
        onActivated = onActivated,
        LayoutOrder = if isDisabled then nil else tbl1.LayoutOrder,
        testId = if isDisabled then nil else "build-header-play-button"
    }
    local button = React.createElement(IconButton, tbl2)

    if not isDisabled then
        return button
    end

    return React.createElement(
        DisabledPlaytestTooltip,
        {
            LayoutOrder = tbl1.LayoutOrder,
            isOpen = isOpen,
            onPressedOutside = onPressedOutside
        },
        {
            PlayButtonAnchor = React.createElement(
                View,
                {
                    onActivated = onActivated,
                    selection = { Selectable = true },
                    tag = "auto-xy",
                    testId = "build-header-play-button"
                },
                { Button = button }
            )
        }
    )
end
return PlayButton
