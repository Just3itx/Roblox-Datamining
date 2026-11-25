-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local React = require(ServerDrivenUiParent.React)
local RoactUtils = require(ServerDrivenUiParent.RoactUtils)
local UniversalAppPolicy = require(ServerDrivenUiParent.UniversalAppPolicy)

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local default = require(ServerDrivenUiParent.ExternalContentSharingProtocol).ExternalContentSharingProtocol.default
local UrlBuilder = require(ServerDrivenUiParent.UrlBuilder)
local RobloxAppEnums = require(ServerDrivenUiParent.RobloxAppEnums)
local NavigationRodux = require(ServerDrivenUiParent.NavigationRodux)
local ToastRodux = require(ServerDrivenUiParent.ToastRodux)
local HttpRequest = require(ServerDrivenUiParent.HttpRequest)
local _LuauPolyfill = require(ServerDrivenUiParent.LuauPolyfill)
local DiscoveryAnalytics = require(ServerDrivenUiParent.DiscoveryAnalytics)
local DiscoveryUtils = require(ServerDrivenUiParent.DiscoveryUtils)

local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useAppPolicy = UniversalAppPolicy.useAppPolicy

local UrlBuilder2 = UrlBuilder.UrlBuilder
local UrlBase = UrlBuilder.UrlBase
local AppPage = RobloxAppEnums.AppPage
local NavigateDown = NavigationRodux.Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(ServerDrivenUiParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(ServerDrivenUiParent.RobloxAppNavigation).NavigationCommands else nil
local ToastType = ToastRodux.Enums.ToastType
local SetCurrentToastMessage = ToastRodux.Actions.SetCurrentToastMessage
local gameCopyExperienceLink = DiscoveryAnalytics.Events.gameCopyExperienceLink
local gameShareExperienceLink = DiscoveryAnalytics.Events.gameShareExperienceLink
local logResponseError = DiscoveryUtils.logResponseError
local DiscoveryEventErrorLogger = DiscoveryUtils.DiscoveryEventErrorLogger

local FFlagLuaAppAddUniverseIdToEngagementEvents = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppAddUniverseIdToEngagementEvents

local function fetchShareLinkId(universeId: string)
    local var1 = UrlBuilder2.new({ base = UrlBase.APIS, path = "sharelinks/v1/get-or-create-link" })()

    local tbl1 = {
        linkType = "ExperienceDetails",
        data = { universeId = universeId }
    }

    local str1 = HttpService:JSONEncode(tbl1.data)
    local postBody = HttpService:JSONEncode({ linkType = tbl1.linkType, data = str1 })

    return HttpRequest.config({
        requestFunction = function(str3: string, str4: string, arg1)
            return HttpRequest.requestFunctions.RequestInternal(str3, str4, arg1)
        end
    })(var1, "POST", { postBody = postBody }):andThen(function(arg1)
        local var2 = arg1.responseBody or arg1.result
        if var2 and var2.linkId then
            return var2.linkId
        end
        DiscoveryEventErrorLogger.reportError(
            "FetchShareLinkIdInvalidResponse",
            "Share link response missing linkId",
            {
                universeId = universeId,
                responseBody = arg1.responseBody or arg1.result
            }
        )
        error("Failed to fetch share link id")
    end):catch(function(arg1)
        local statusCode = if type(arg1) == "table" and arg1.StatusCode then arg1.StatusCode else nil
        logResponseError("sharelinks/v1/get-or-create-link", { StatusCode = statusCode })
        DiscoveryEventErrorLogger.reportError(
            "FetchShareLinkIdFailed",
            "Failed to fetch share link id",
            {
                universeId = universeId,
                statusCode = statusCode,
                error = tostring(arg1)
            }
        )
        error(arg1)
    end)
end

local function generateExperienceDetailsShareLinkUrl(linkId: string?, universeId: string, placeId: string)
    local var1 = nil
    if not linkId then
        return UrlBuilder2.game.info.appsflyer({ universeId = universeId, placeId = placeId }), var1
    end

    local stamp = tostring(DateTime.now().UnixTimestampMillis)
    return UrlBuilder2.sharelinks.shortUrl({ linkId = linkId, type = "ExperienceDetails", stamp = stamp }), stamp
end

local function handleCopyLink(str1: string, placeId: string, ctx: string, callback)
    fetchShareLinkId(str1):andThen(function(linkId)
        local url, stamp = generateExperienceDetailsShareLinkUrl(linkId, str1, placeId)

        local userId = Players.LocalPlayer and Players.LocalPlayer.UserId
        gameCopyExperienceLink({
            ctx = ctx,
            uid = tostring(userId),
            placeId = placeId,
            stamp = stamp,
            targetId = if FFlagLuaAppAddUniverseIdToEngagementEvents then str1 else nil
        }, ctx)

        default:shareUrl({ context = "GameDetailsMoreWebURL", url = url })

        callback(
            SetCurrentToastMessage(
                {
                    toastMessage = "Feature.GameDetails.Toast.LinkCopied",
                    toastType = ToastType.SuccessConfirmation
                }
            )
        )
    end):catch(function(_)
        callback(
            SetCurrentToastMessage(
                {
                    toastMessage = "Feature.Toast.NetworkingError.SomethingIsWrong",
                    toastType = ToastType.NetworkingError
                }
            )
        )
    end)
end

local function useExperienceDetailsShare(universeId: string, placeId: string?, ctx: string)
    local var1 = useDispatch()
    local var2 = useAppPolicy(function(arg1)
        return arg1.shouldShareToAccountProvider()
    end)

    return React.useCallback(function()
        if not placeId then
            return
        end

        if not var2 then
            handleCopyLink(universeId, placeId, ctx, var1)
            return
        end

        if var2 then
            local tbl1 = {
                name = AppPage.SdkShare,
                extraProps = { universeId = universeId, context = "GameDetailsMoreWebURL" }
            }

            if FFlagSignalsNavP3Dispatch then
                NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
                return
            end
            var1(NavigateDown(tbl1))
            return
        end

        fetchShareLinkId(universeId):andThen(function(linkId)
            local url, stamp = generateExperienceDetailsShareLinkUrl(linkId, universeId, placeId)

            local userId = Players.LocalPlayer and Players.LocalPlayer.UserId
            gameShareExperienceLink({
                ctx = ctx,
                uid = tostring(userId),
                placeId = placeId,
                shortShareLinkFailed = not linkId,
                shareToAppsflyer = true,
                stamp = stamp,
                linkId = linkId,
                targetId = if FFlagLuaAppAddUniverseIdToEngagementEvents then universeId else nil
            }, ctx)

            default:shareUrl({ url = url, context = "GameDetailsMoreWebURL" })
        end):catch(function(_)
            local url = UrlBuilder2.game.info.appsflyer({ universeId = universeId, placeId = placeId })

            local userId = Players.LocalPlayer and Players.LocalPlayer.UserId
            gameShareExperienceLink({
                ctx = ctx,
                uid = tostring(userId),
                placeId = placeId,
                shortShareLinkFailed = true,
                shareToAppsflyer = true,
                stamp = nil,
                linkId = nil,
                targetId = if FFlagLuaAppAddUniverseIdToEngagementEvents then universeId else nil
            }, ctx)

            default:shareUrl({ url = url, context = "GameDetailsMoreWebURL" })
        end)
    end, {
        universeId,
        placeId,
        var2,
        var1,
        ctx
    })
end
return useExperienceDetailsShare
