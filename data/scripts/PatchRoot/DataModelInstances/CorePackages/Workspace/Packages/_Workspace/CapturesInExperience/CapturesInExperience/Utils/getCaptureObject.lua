-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:11:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local CaptureService = require(scriptParentParent.Services.CaptureService)
local CaptureType = require(scriptParentParent.Enums.CaptureType)
local _Types = require(scriptParentParent.Types)

local engineFeature = game:GetEngineFeature("CaptureServiceGetScreenshotCaptureObject")

local function getCaptureObject(arg1)
    if arg1.CaptureType ~= nil then
        return arg1
    elseif arg1.type == CaptureType.Video then
        return arg1.videoCapture
    elseif arg1.capture ~= nil then
        return arg1.capture
    elseif engineFeature then
        return (CaptureService:GetScreenshotCaptureObject(arg1.filePath))
    end
    return nil
end

return getCaptureObject
