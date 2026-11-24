-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local getCaptureMetadata = require(scriptParentParent.Utils.getCaptureMetadata)
local _Types = require(scriptParentParent.Types)

return function(arg1)
    local captureMetadata = getCaptureMetadata(arg1)
    return if captureMetadata then captureMetadata.placeId else nil
end
