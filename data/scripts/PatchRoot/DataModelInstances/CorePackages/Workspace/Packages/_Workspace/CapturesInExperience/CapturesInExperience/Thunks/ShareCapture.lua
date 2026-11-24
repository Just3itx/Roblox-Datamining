-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:10:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local CaptureService = game:GetService("CaptureService")
local LocalizationService = game:GetService("LocalizationService")

local default = require(scriptParentParentParent.ExternalContentSharingProtocol).ExternalContentSharingProtocol.default
local Localization = require(scriptParentParentParent.RobloxAppLocales).Localization
local SocialStopwatch = require(scriptParentParentParent.SocialStopwatch)

local CaptureType = require(scriptParentParent.Enums.CaptureType)
local Constants = require(scriptParentParent.Constants)
local ServerType = require(scriptParentParent.Enums.ServerType)
local EventNames = require(scriptParentParent.Analytics.EventNames)
local _ExternalShareSourceType = require(scriptParentParent.Enums.ExternalShareSourceType)
local FireEvent = require(scriptParentParent.Analytics.FireEvent)
local getPlaceIdFromCapture = require(scriptParentParent.Utils.getPlaceIdFromCapture)
local Networking = require(scriptParentParent.App.Networking)
local _Types = require(scriptParentParent.Types)

local FFlagUseRbxstorageInGallery = require(scriptParentParent.Flags.FFlagUseRbxstorageInGallery)

local FFlagEnableCapturesGalleryRetrievalCoreScript = require(scriptParentParent.Flags.FFlagEnableCapturesGalleryRetrievalCoreScript)

local ShareLinksNetworking = Networking.ShareLinksNetworking
local LinkType = Networking.ShareLinksRodux.Enums.LinkType

local localization = Localization.new(LocalizationService.RobloxLocaleId)

local function shareImage(image: string, url: string?)
    if not default then
        return
    end

    assert(default ~= nil, "ExternalContentSharingProtocol is required")

    default:shareImage({
        context = Constants.CapturesContext,
        image = image,
        shareSheetTitle = localization:Format("Feature.Captures.Action.ShareYourCapture"),
        url = url
    })
end

local function shareVideo(video: string, url: string?)
    if not default then
        return
    end

    assert(default ~= nil, "ExternalContentSharingProtocol is required")

    default:shareVideo({
        context = Constants.CapturesContext,
        shareSheetTitle = localization:Format("Feature.Captures.Action.ShareYourCapture"),
        url = url,
        video = video
    })
end

local function shareCapture(capture: Capture, url: string?)
    if FFlagEnableCapturesGalleryRetrievalCoreScript and capture.CaptureTime ~= nil then
        local str1 = CaptureService:PreCaptureShared(capture)
        if capture.CaptureType == Enum.CaptureType.Video then
            shareVideo(str1, url)
        else
            shareImage(str1, url)
        end
        CaptureService:OnCaptureObjectShared(capture)
    elseif FFlagUseRbxstorageInGallery and capture.type == CaptureType.Video then
        local str1 = CaptureService:PreVideoCaptureShared(capture.videoCapture)
        shareVideo(str1, url)
        CaptureService:OnVideoCaptureShared(capture.videoCapture)
    else
        shareImage(capture.filePath, url)
        CaptureService:OnCaptureShared(capture.filePath)
    end
end

local function sendShareLatencyEvent(externalShareSource) -- Luacid: Inlined by compiler; 3 call sites recovered
    local var1 = SocialStopwatch.Stopwatch.stop(SocialStopwatch.Events.CaptureShared)
    FireEvent(
        EventNames.CapturesShareLatency,
        {
            statValue = if var1 then var1.timeElapsed else nil,
            externalShareSource = externalShareSource
        }
    )
end
return function(capture, externalShareSource, launchData: string?)
    return function(arg1)
        local bool1 = arg1:getState().ServerType == ServerType.StandardServer
        local bool2 = if FFlagEnableCapturesGalleryRetrievalCoreScript then capture.CaptureType == Enum.CaptureType.Video else capture.type == CaptureType.Video

        if not bool1 then
            shareCapture(capture)
            FireEvent(EventNames.CapturesShareFromNonStandardServer)
            sendShareLatencyEvent(externalShareSource)
            return
        end

        local jobId = nil
        local placeId = game.PlaceId
        local var1 = if bool2 then if FFlagEnableCapturesGalleryRetrievalCoreScript then capture.SourcePlaceId else capture.videoCapture.SourcePlaceId else getPlaceIdFromCapture(capture)

        if placeId == var1 then
            jobId = game.JobId
        end

        local tbl1 = {
            instanceId = jobId,
            launchData = launchData,
            linkType = LinkType.ScreenshotInvite.rawValue(),
            placeId = var1
        }

        arg1:dispatch(ShareLinksNetworking.GenerateLink.API(tbl1)):andThen(function(arg2)
            local shortUrl = arg2.responseBody.shortUrl
            shareCapture(capture, shortUrl)
            sendShareLatencyEvent(externalShareSource)
        end):catch(function(arg2)
            warn("GenerateLink failed with error:", arg2)

            FireEvent(EventNames.ShareCaptureGenerateLinkFailed, { httpError = arg2.HttpError })

            shareCapture(capture)
            sendShareLatencyEvent(externalShareSource)
        end)
    end
end
