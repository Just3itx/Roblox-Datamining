-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local DiscoveryAnalytics = require(SduiSharedContentParent.DiscoveryAnalytics)

local default = require(SduiSharedContentParent.ExternalContentSharingProtocol).ExternalContentSharingProtocol.default
local Foundation = require(SduiSharedContentParent.Foundation)
local HttpRequest = require(SduiSharedContentParent.HttpRequest)
local Promise = require(SduiSharedContentParent.Promise)
local SduiCoreSystem = require(SduiSharedContentParent.SduiCoreSystem)
local UrlBuilder = require(SduiSharedContentParent.UrlBuilder)

local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local getActionTelemetryFieldValue = SduiCoreSystem.getActionTelemetryFieldValue
local getSduiPageEntrySnackbarStore = require(SduiSharedContentParent.SduiSharedUtilities).getSduiPageEntrySnackbarStore
local UrlBase = UrlBuilder.UrlBase
local UrlBuilder2 = UrlBuilder.UrlBuilder

local gameCopyExperienceLink = DiscoveryAnalytics.Events.gameCopyExperienceLink
local gameShareExperienceLink = DiscoveryAnalytics.Events.gameShareExperienceLink

local FFlagLuaAppAddUniverseIdToEngagementEvents = require(SduiSharedContentParent.SharedFlags).FFlagLuaAppAddUniverseIdToEngagementEvents

local function isDesktopPlatform(): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    local platform = UserInputService:GetPlatform()
    return platform == Enum.Platform.Windows or platform == Enum.Platform.OSX or platform == Enum.Platform.UWP
end

local function logExperienceDetailsShareAnalytics(placeId: string, ctx: string, linkId: string?, stamp: string?, str1: string?)
    local localPlayer = Players.LocalPlayer
    if not localPlayer then
        return
    end
    local uid = tostring(localPlayer.UserId)

    if isDesktopPlatform() then
        local var1 = gameCopyExperienceLink
        local tbl1 = { ctx = ctx, uid = uid, placeId = placeId, stamp = stamp, targetId = 0 }
        if not FFlagLuaAppAddUniverseIdToEngagementEvents then
            str1 = nil
        end

        tbl1.targetId = str1
        var1(tbl1, ctx)
        return
    end

    local var1 = gameShareExperienceLink
    local tbl1 = {
        ctx = ctx,
        uid = uid,
        placeId = placeId,
        shortShareLinkFailed = linkId == nil,
        shareToAppsflyer = true,
        stamp = stamp,
        linkId = linkId,
        targetId = 0
    }

    if not FFlagLuaAppAddUniverseIdToEngagementEvents then
        str1 = nil
    end

    tbl1.targetId = str1
    var1(tbl1, ctx)
end

local function fetchShareLinkId(linkType: string, input)
    local var1 = UrlBuilder2.new({ base = UrlBase.APIS, path = "sharelinks/v1/get-or-create-link" })()

    local postBody = HttpService:JSONEncode({ linkType = linkType, data = HttpService:JSONEncode(input) })

    return HttpRequest.config({
        requestFunction = function(str2: string, str3: string, arg1)
            return HttpRequest.requestFunctions.RequestInternal(str2, str3, arg1)
        end
    })(var1, "POST", { postBody = postBody }):andThen(function(arg1)
        local var2 = arg1.responseBody or arg1.result
        if var2 and var2.linkId then
            return var2.linkId
        end
        error("Share link response missing linkId")
    end)
end

return function(arg1, arg2, arg3)
    local actionParams = if arg1 then arg1.actionParams or nil else nil

    if actionParams == nil then
        arg3.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.Share,
                message = "Missing actionParams"
            },
            arg3.appPage
        )
        return
    end

    local shareLinkData = actionParams.shareLinkData or {}
    local entryPointKey = actionParams.entryPointKey or nil
    local shareUrlContext = shareLinkData.shareUrlContext or ""
    local bool1 = shareLinkData.linkType ~= nil

    local currentLinkId = nil
    local var1 = nil
    local var2

    if bool1 then
        local linkType = shareLinkData.linkType
        local linkData = shareLinkData.linkData

        if linkData == nil then
            var2 = Promise.reject(`Missing linkData in ShareLinkFetchData (linkType={linkType})`)
        else
            var2 = fetchShareLinkId(linkType, linkData):andThen(function(linkId: string)
                currentLinkId = linkId
                var1 = tostring(DateTime.now().UnixTimestampMillis)
                return UrlBuilder2.sharelinks.shortUrl({ linkId = linkId, type = linkType, stamp = var1 })
            end)
        end
    else
        local url = shareLinkData.url
        if url == nil then
            var2 = Promise.reject("Missing url in shareLinkData")
        else
            var2 = Promise.resolve(url)
        end
    end

    var2:andThen(function(url: string)
        default:shareUrl({ context = shareUrlContext, url = url })

        if isDesktopPlatform() and entryPointKey then
            local title = arg3.dependencies.localization:Format("Feature.GameDetails.Toast.LinkCopied")
            getSduiPageEntrySnackbarStore().show(entryPointKey, { title = title, icon = Foundation.Enums.IconName.CircleCheck })
        end

        if shareLinkData.linkType ~= "ExperienceDetails" then
            return
        end

        local actionTelemetryFieldValue = getActionTelemetryFieldValue(arg1, arg2, "rootPlaceId") or getActionTelemetryFieldValue(arg1, arg2, "placeId")
        if actionTelemetryFieldValue == nil then
            return
        end

        local actionTelemetryFieldValue2 = getActionTelemetryFieldValue(arg1, arg2, "ctx") or "ExperienceDetailsShare"

        if not FFlagLuaAppAddUniverseIdToEngagementEvents then
            logExperienceDetailsShareAnalytics(tostring(actionTelemetryFieldValue), actionTelemetryFieldValue2, currentLinkId, var1)
            return
        end

        local actionTelemetryFieldValue3 = getActionTelemetryFieldValue(arg1, arg2, "universeId")
        if actionTelemetryFieldValue3 == nil and type(shareLinkData.linkData) == "table" then
            actionTelemetryFieldValue3 = shareLinkData.linkData.universeId
        end
        logExperienceDetailsShareAnalytics(
            tostring(actionTelemetryFieldValue),
            actionTelemetryFieldValue2,
            currentLinkId,
            var1,
            if actionTelemetryFieldValue3 == nil then nil else tostring(actionTelemetryFieldValue3)
        )
    end):catch(function(arg4)
        arg3.dependencies.logger.reportError(
            SduiErrorType.FailedToExecuteAction,
            {
                name = SduiActionType.Share,
                message = tostring(arg4)
            },
            arg3.appPage
        )

        if not entryPointKey then
            return
        end
        local title = arg3.dependencies.localization:Format("Feature.Toast.NetworkingError.SomethingIsWrong")
        getSduiPageEntrySnackbarStore().show(
            entryPointKey,
            {
                title = title,
                icon = Foundation.Enums.IconName.TriangleExclamation
            }
        )
    end)
end
