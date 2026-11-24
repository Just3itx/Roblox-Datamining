-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:11:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local CaptureService = game:GetService("CaptureService")

local CaptureType = require(scriptParentParent.Enums.CaptureType)
local _Types = require(scriptParentParent.Types)

local FFlagUseRbxstorageInGallery = require(scriptParentParent.Flags.FFlagUseRbxstorageInGallery)

local function getCaptureUploadData(arg1)
    if FFlagUseRbxstorageInGallery and arg1.type == CaptureType.Video then
        return nil
    end

    local success, result = pcall(function()
        return CaptureService:GetCaptureUploadDataAsync(arg1.filePath)
    end)

    return if success then result else nil
end

return getCaptureUploadData
