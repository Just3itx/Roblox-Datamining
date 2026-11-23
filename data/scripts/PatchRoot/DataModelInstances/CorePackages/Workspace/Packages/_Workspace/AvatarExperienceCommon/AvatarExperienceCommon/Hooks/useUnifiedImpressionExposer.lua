-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:31:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local React = require(AvatarExperienceCommonParent.React)
local IXPUtils = require(AvatarExperienceCommonParent.IXPUtils)

local function unifiedImpressionExposer(tbl1, str1: string)
    return React.useCallback(function(tbl2)
        local current = tbl1.current
        if current and tbl2.visibleInstance:IsDescendantOf(current) then
            IXPUtils.logLayerExposure(str1)
        end
    end, { str1 })
end

return unifiedImpressionExposer
