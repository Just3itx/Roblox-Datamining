-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:11:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local logMomentsLayerExposure = require(scriptParentParentParent.MomentsCommon).Utils.logMomentsLayerExposure

local function logCaptureEndLayerExposure()
    logMomentsLayerExposure("Moments.CaptureEnd")
end

return logCaptureEndLayerExposure
