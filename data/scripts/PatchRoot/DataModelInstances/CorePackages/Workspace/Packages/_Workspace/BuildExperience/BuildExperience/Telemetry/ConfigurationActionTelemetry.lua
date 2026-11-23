-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:01:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")

local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)

local function getEventParameters(action: string, str1: string?, tbl1)
    local tbl2 = {
        action = action,
        context = if str1 == nil then "unknown" else str1,
        isInExperience = if game.GameId == 0 then "false" else "true"
    }
    if tbl1 ~= nil then
        for value, value2 in tbl1 do
            tbl2[value] = value2
        end
    end
    return tbl2
end

return {
    Action = {
        ArchiveGame = "archive_game",
        AudienceChange = "audience_change",
        ExperienceDetailsSave = "experience_details_save",
        Publish = "publish",
        Share = "share",
        UpdateRating = "update_rating",
        VersionDetailsSave = "version_details_save"
    },
    Context = {
        AudienceBanner = "audience_banner",
        GamesList = "games_list",
        PublishFooter = "publish_footer",
        PublishSnackbar = "publish_snackbar",
        Settings = "settings"
    },
    FailureReason = {
        AccountTooNew = "account_too_new",
        AudienceNotPublic = "audience_not_public",
        ContentUnrated = "content_unrated",
        RatingRequired = "rating_required",
        RequestFailed = "request_failed"
    },
    Stage = {
        RefreshEligibility = "refresh_eligibility",
        RefreshSummary = "refresh_summary",
        SaveAndPublish = "save_and_publish",
        SetAudience = "set_audience"
    },
    getChangedFields = function(bool1: boolean, bool2: boolean): string
        return if bool1 and bool2 then "title,description" elseif bool1 then "title" else "description"
    end,
    sendClick = function(action: string, arg1, str1: string?, tbl1)
        sendBuildExperienceEvent("CONFIGURATION_ACTION_CLICK", arg1, (getEventParameters(action, str1, tbl1)))
    end,
    sendSuccess = function(action: string, arg1, str1: string?, tbl1)
        sendBuildExperienceEvent("CONFIGURATION_ACTION_SUCCESS", arg1, (getEventParameters(action, str1, tbl1)))
    end,
    sendFailure = function(action: string, arg1, tbl1, str1: string?, tbl2)
        local eventParameters = getEventParameters(action, str1, tbl2)
        eventParameters.reason = tbl1.reason
        local stage = tbl1.stage
        if stage ~= nil then
            eventParameters.stage = stage
        end

        local error = if type(tbl1.error) == "table" then tbl1.error else nil
        local var1 = if error == nil then nil else tonumber(error.responseCode)
        local response = if error == nil or type(error.response) ~= "table" then nil else error.response
        local var2 = if response == nil then nil else tonumber(response.statusCode)

        if var1 ~= nil then
            eventParameters.errorCode = tostring(var1)
        end
        if var2 ~= nil then
            eventParameters.httpStatus = tostring(var2)
        end

        sendBuildExperienceEvent("CONFIGURATION_ACTION_FAILURE", arg1, eventParameters)
    end
}
