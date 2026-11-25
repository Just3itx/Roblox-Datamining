-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:01:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local CentralOverlay = require(ServerDrivenUiParent.CentralOverlay)
local SetCentralOverlay = CentralOverlay.Actions.SetCentralOverlay
local CloseCentralOverlay = CentralOverlay.Thunks.CloseCentralOverlay
local CentralOverlayType = require(ServerDrivenUiParent.RobloxAppEnums).CentralOverlayType
local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local sendSocialLinkClickEvent = require(ServerDrivenUiParent.DiscoveryAnalytics).Events.sendSocialLinkClickEvent

return function(arg1, _, arg2, _)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenSocialLink,
                message = "Missing actionParams"
            },
            arg2.appPage
        )
        return
    end

    assert(actionParams, "actionParams must exist")
    local socialLinkUrl = actionParams.socialLinkUrl
    if typeof(socialLinkUrl) ~= "string" or socialLinkUrl == "" then
        arg2.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
            name = SduiActionType.OpenSocialLink,
            message = `Invalid or missing socialLinkUrl: {socialLinkUrl}`,
            propName = "socialLinkUrl"
        }, arg2.appPage)
        return
    end

    local dispatch = arg2.dependencies.dispatch
    local linkingProtocol = arg2.dependencies.linkingProtocol

    local tbl1 = {
        assignment_id = 0,
        assignment_type = 0,
        social_link_type = 0,
        social_link_display_type = 0
    }
    local assignmentId = actionParams.assignmentId
    tbl1.assignment_id = tonumber(assignmentId) or 0
    tbl1.assignment_type = actionParams.assignmentType or ""
    tbl1.social_link_type = actionParams.socialLinkType or ""
    tbl1.social_link_display_type = actionParams.socialLinkDisplayType or ""

    dispatch(SetCentralOverlay(CentralOverlayType.LeaveRobloxAlert, {
        continueFunc = function()
            sendSocialLinkClickEvent({
                assignment_id = tbl1.assignment_id,
                assignment_type = tbl1.assignment_type,
                social_link_type = tbl1.social_link_type,
                social_link_url = socialLinkUrl,
                social_link_display_type = tbl1.social_link_display_type
            })

            linkingProtocol:openURL(socialLinkUrl):catch(function(arg3)
                arg2.dependencies.logger.reportError(
                    SduiErrorType.FailedToOpenLink,
                    {
                        name = SduiActionType.OpenSocialLink,
                        message = if typeof(arg3) ~= "string" then "Unknown reason" else arg3
                    },
                    arg2.appPage
                )
            end)
            dispatch(CloseCentralOverlay())
        end
    }))
end
