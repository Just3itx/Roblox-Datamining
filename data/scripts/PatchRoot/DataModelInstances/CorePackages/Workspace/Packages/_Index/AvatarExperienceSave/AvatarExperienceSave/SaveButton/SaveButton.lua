-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:30:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSave = script:FindFirstAncestor("AvatarExperienceSave")

local AvatarExperienceSaveParent = AvatarExperienceSave.Parent
local React = require(AvatarExperienceSaveParent.React)
local Foundation = require(AvatarExperienceSaveParent.Foundation)

local _useSaveButtonProps = require(AvatarExperienceSave.SaveButton.useSaveButtonProps)

local function SaveButton(arg1)
    local var1 = Foundation.Hooks.useTokens()
    local text = arg1.text or "Save"

    return React.createElement(Foundation.Button, {
        text = text,
        isDisabled = arg1.disabled,
        size = Foundation.Enums.InputSize.Medium,
        variant = if arg1.disabled then Foundation.Enums.ButtonVariant.Standard else Foundation.Enums.ButtonVariant.Emphasis,
        onActivated = arg1.onActivated,
        width = UDim.new(0, var1.Size.Size_2300),
        LayoutOrder = arg1.LayoutOrder
    })
end

return SaveButton
