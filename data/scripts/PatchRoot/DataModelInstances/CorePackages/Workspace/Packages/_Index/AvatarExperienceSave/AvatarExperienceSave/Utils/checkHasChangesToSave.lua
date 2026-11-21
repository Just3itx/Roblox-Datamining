-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSave = script:FindFirstAncestor("AvatarExperienceSave")

local _AvatarSaveContext = require(AvatarExperienceSave.Context.AvatarSaveContext)
local getSaveDict = require(script.Parent.getSaveDict)

local function checkHasChangesToSave(arg1, arg2)
    for _, value in (getSaveDict(arg1, arg2)) do
        if value then
            return true
        end
    end
    return false
end

return checkHasChangesToSave
