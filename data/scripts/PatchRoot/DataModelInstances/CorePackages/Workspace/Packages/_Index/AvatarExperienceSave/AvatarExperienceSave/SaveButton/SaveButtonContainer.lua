-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:30:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSave = script:FindFirstAncestor("AvatarExperienceSave")

local AvatarExperienceSaveParent = AvatarExperienceSave.Parent
local React = require(AvatarExperienceSaveParent.React)
local Dash = require(AvatarExperienceSaveParent.Dash)

local useSaveButtonProps = require(AvatarExperienceSave.SaveButton.useSaveButtonProps)
local SaveButton = require(AvatarExperienceSave.SaveButton.SaveButton)

local function SaveButtonContainer(arg1)
    return React.createElement(SaveButton, Dash.assign(arg1, useSaveButtonProps()))
end

return SaveButtonContainer
