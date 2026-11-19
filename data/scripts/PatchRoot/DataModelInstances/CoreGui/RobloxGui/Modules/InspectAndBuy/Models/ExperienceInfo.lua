-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:20:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local MockId = require(script.Parent.Parent.MockId)
local PlayabilityStatusEnum = require(CorePackages.Workspace.Packages.DiscoveryTypes).PlayabilityStatusEnum

local module = {}

function module.mock()
    return {
        universeId = MockId(),
        name = "",
        rootPlaceId = MockId(),
        isPlayable = true,
        playabilityStatus = PlayabilityStatusEnum.Playable
    }
end

function module.fromGetPlayabilityStatus(arg1)
    return {
        universeId = tostring(arg1.universeId),
        isPlayable = arg1.isPlayable,
        playabilityStatus = arg1.playabilityStatus
    }
end

function module.fromGetExperienceInfo(arg1)
    return {
        universeId = tostring(arg1.id),
        rootPlaceId = tostring(arg1.rootPlaceId),
        name = arg1.name
    }
end
return module
