-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:21:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local PlaceVersionHistory = require(BuildExperienceParent.DataHydration.PlaceVersionHistory)

local VersionHistoryConstants = require(script.Parent.VersionHistoryConstants)

local PublishStatus = PlaceVersionHistory.PublishStatus
local SaveType = PlaceVersionHistory.SaveType

local function toNumber(version) -- Luacid: Inlined by compiler; 1 call site recovered
    if type(version) == "number" then
        return version
    elseif type(version) == "string" then
        return tonumber(version)
    end

    return nil
end

return {
    getBadgeKind = function(arg1)
        if arg1.publishStatus == PublishStatus.Live then
            return "published"
        end

        if arg1.publishStatus == PublishStatus.PreviouslyPublished then
            return "previouslyPublished"
        end

        if arg1.parentAssetVersionId == nil then
            if arg1.saveType == SaveType.AutoSave then
                return "autosaved"
            end

            return nil
        end

        return "restored"
    end,
    getCreatedDateParts = function(str1: string?)
        assert(type(str1) == "string" and str1 ~= "", "Place version createdTime must not be empty")

        local var1, var2, var3 = string.match(str1, "^(%d%d%d%d)%-(%d%d)%-(%d%d)")
        local var4 = if var2 then tonumber(var2) else nil
        local var5 = if var3 then tonumber(var3) else nil
        assert(
            not (var1 == nil or var4 == nil) and var5 ~= nil,
            `Place version createdTime must be an ISO date: {str1}`
        )

        return var4, var5, var1
    end,
    getVersionNumber = function(arg1)
        local var1 = toNumber(arg1.version)
        assert(var1 ~= nil, `Place version must be numeric: {arg1.version}`)

        return var1
    end,
    shouldShowEntry = function(autosavedBadgeText: string?, bool1: boolean): boolean
        return not bool1 or autosavedBadgeText ~= VersionHistoryConstants.AUTOSAVED_BADGE_TEXT
    end
}
