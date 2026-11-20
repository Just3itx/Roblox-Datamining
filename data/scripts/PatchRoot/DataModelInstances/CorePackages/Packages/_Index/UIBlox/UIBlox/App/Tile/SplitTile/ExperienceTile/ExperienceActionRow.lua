-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParentParent = scriptParentParentParentParent.Parent.Parent

local React = require(scriptParentParentParentParentParentParent.React)

local Button = require(scriptParentParentParentParent.Button.Button)
local ButtonType = require(scriptParentParentParentParent.Button.Enum.ButtonType)
local ComboButton = require(scriptParentParentParentParent.Button.ComboButton)
local Images = require(scriptParentParentParentParent.ImageSet.Images)

local function func1() end

local function ExperienceActionRow(tbl1)
    local isActionable = tbl1.isActionable
    local horizontalPadding = tbl1.horizontalPadding or 6
    local verticalPadding = tbl1.verticalPadding or 6
    local height = tbl1.height or 48
    local text = tbl1.text
    local icon = tbl1.icon

    if tbl1.onOverflowPressed then
        return React.createElement(ComboButton, {
            position = UDim2.new(0, horizontalPadding, 1, -verticalPadding - 36),
            size = UDim2.new(1, -2 * horizontalPadding, 0, height - 2 * verticalPadding),
            button = {
                text = text,
                icon = icon,
                onActivated = tbl1.onPlayPressed or func1,
                isDisabled = not isActionable
            },
            overflow = {
                icon = Images["icons/actions/truncationCollapse"],
                onActivated = tbl1.onOverflowPressed,
                isDisabled = not isActionable
            }
        })
    end
    return React.createElement(Button, {
        buttonType = if tbl1.buttonType then tbl1.buttonType else ButtonType.PrimaryContextual,
        text = text,
        icon = icon,
        size = UDim2.new(1, -2 * horizontalPadding, 0, height - 2 * verticalPadding),
        position = UDim2.new(0, horizontalPadding, 1, -verticalPadding - 36),
        userInteractionEnabled = isActionable,
        onActivated = tbl1.onPlayPressed or func1,
        isDisabled = not isActionable,
        isLoading = tbl1.buttonLoading,
        feedbackType = tbl1.feedbackType,
        DO_NOT_USE_useUIBloxButton = tbl1.DO_NOT_USE_useUIBloxButton
    })
end

return ExperienceActionRow
