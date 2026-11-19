-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppCommonLibParent = script:FindFirstAncestor("AppCommonLib").Parent

local VRService = require(AppCommonLibParent.MockableProxyServices).VRService
local isVRModeInStudio = require(script.Parent.isVRModeInStudio)

local function isSpatial()
    return if isVRModeInStudio() then true else VRService.VREnabled
end

return isSpatial
