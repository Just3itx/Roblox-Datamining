-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")

local Enums = require(AvatarExperienceProfilePictureEditor.Common.Enums)
local closeProfilePictureEditor = require(script.Parent.closeProfilePictureEditor)
local entrySurface = require(script.Parent.entrySurface)

local function readCallback(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    if tbl1.getParam == nil then
        return nil
    end
    local param = tbl1.getParam("callback")
    return if typeof(param) == "string" and param ~= "" then param else nil
end

local function leaveEditProfileImage(tbl1, func1: ((...any) -> (...any))?)
    local var1 = readCallback(tbl1)

    if func1 == nil or var1 == nil then
        closeProfilePictureEditor(tbl1)
        return
    end

    if tbl1.setParams ~= nil then
        tbl1.setParams({ callback = "", mode = Enums.EditProfileImageMode.Default })
    end

    entrySurface.park(tbl1, (entrySurface.resolve(tbl1)))
    if not func1(var1) then
        closeProfilePictureEditor(tbl1)
    end
end

return leaveEditProfileImage
