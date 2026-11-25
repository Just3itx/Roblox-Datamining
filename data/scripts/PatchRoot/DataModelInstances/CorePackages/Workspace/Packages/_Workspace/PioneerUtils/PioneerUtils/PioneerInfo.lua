-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PioneerUtilsParent = script:FindFirstAncestor("PioneerUtils").Parent

local GetFStringPioneerLaunchPlaceId = require(PioneerUtilsParent.SharedFlags).GetFStringPioneerLaunchPlaceId

local engineFeature = game:GetEngineFeature("PioneerDataModelApi")

local module = {}

function module.isPioneerApp(): boolean
    return if engineFeature then game:IsPioneerApp() == true else false
end

function module.getPioneerSource()
    if not engineFeature then
        return nil
    end

    return game:GetPioneerSource()
end

function module.isDaveyBazooka()
    local success, result = pcall(function(): boolean
        return module.getPioneerSource() == Enum.PioneerSource.DaveyBazooka
    end)
    return success and result
end

function module.getPioneerRootPlaceId()
    local fStringPioneerLaunchPlaceId = GetFStringPioneerLaunchPlaceId()
    if fStringPioneerLaunchPlaceId then
        return fStringPioneerLaunchPlaceId
    end

    if not engineFeature then
        return nil
    end

    local pioneerRootPlaceId = game:GetPioneerRootPlaceId()
    return if type(pioneerRootPlaceId) == "number" and not (pioneerRootPlaceId <= 0) then pioneerRootPlaceId else nil
end

return module
