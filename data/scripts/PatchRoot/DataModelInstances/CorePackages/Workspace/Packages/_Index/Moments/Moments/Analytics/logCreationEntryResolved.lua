-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Analytics = require(MomentsParent.MomentsCommon).Analytics

local Outcome = {
    GalleryOpened = "gallery_opened",
    EducationShown = "education_shown",
    PermissionDenied = "permission_denied",
    ReadError = "read_error",
    GalleryUnavailable = "gallery_unavailable",
    RequestInFlight = "request_in_flight"
}

return {
    Outcome = Outcome,
    resolveGalleryOutcome = function(bool1: boolean, num1: number, permissionDenied: string?)
        if bool1 then
            if num1 == 0 then
                return Outcome.EducationShown
            end

            return Outcome.GalleryOpened
        end

        if permissionDenied == Outcome.PermissionDenied then
            return Outcome.PermissionDenied
        end

        return Outcome.ReadError
    end,
    log = function(entryOutcome: string, creationSessionId: string?) -- name: logCreationEntryResolved
        local tbl2 = { entryOutcome = entryOutcome }
        if creationSessionId ~= nil then
            tbl2.creationSessionId = creationSessionId
        end

        Analytics.fireAnalyticsEvent(Analytics.EventNames.MomentCreationEntryResolved, tbl2)
    end
}
