-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent

local FFlagAEGIS2UseGuacToShowEnabledMessage = require(ExpChatParent.SharedFlags).FFlagAEGIS2UseGuacToShowEnabledMessage

local UniversalAppPolicy = if FFlagAEGIS2UseGuacToShowEnabledMessage then require(ExpChatParent.UniversalAppPolicy) else nil

return function()
    if not FFlagAEGIS2UseGuacToShowEnabledMessage then
        return false
    end

    return UniversalAppPolicy.getAppFeaturePolicies().getInCommsRegionBubble()
end
