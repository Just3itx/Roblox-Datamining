-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local RoactAppExperiment = require(scriptParentParentParent.RoactAppExperiment)
local SharedFlags = require(scriptParentParentParent.SharedFlags)

local useUserExperiment = RoactAppExperiment.useUserExperiment
local FStringPaginatedCarouselExperimentLayer = SharedFlags.FStringPaginatedCarouselExperimentLayer

return {
    usePaginatedFriendsCarouselExperiment = function()
        return true, (useUserExperiment({ FStringPaginatedCarouselExperimentLayer }, function(arg1)
            return (arg1[FStringPaginatedCarouselExperimentLayer] or {}).friendsSortVariant
        end))
    end
}
