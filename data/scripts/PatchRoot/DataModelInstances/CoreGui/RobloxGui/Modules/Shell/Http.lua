-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local CorePackages = game:GetService("CorePackages")

local Modules = game:GetService("CoreGui").RobloxGui.Modules
local Utility = require(Modules.Shell.Utility)
local Url = require(CorePackages.Workspace.Packages.Http).Url

local module = {}

local str1 = game:GetService("ContentProvider").BaseUrl:lower()
local var1 = string.gsub(str1, "/m.", "/www.")
local BaseUrl = string.gsub(var1, "http://", "https://")

local AssetGameBaseUrl = string.gsub(BaseUrl, "https://www.", "https://assetgame.")
string.gsub(BaseUrl, "https://www.", "https://accountsettings.")

module.BaseUrl = BaseUrl
module.AssetGameBaseUrl = AssetGameBaseUrl

local GetFStringAppLocationForAppPresence = require(Modules.Shell.Flags.GetFStringAppLocationForAppPresence)

local function decodeJSON(input) -- Luacid: Inlined by compiler; 43 call sites recovered
    if input == nil or #input == 0 then
        return nil
    end

    local success, result = pcall(function()
        return HttpService:JSONDecode(input)
    end)
    return if success then result else nil
end

local function rbxGetAsync(url: string, bool1: boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
    local success, result = pcall(function(): string
        return game:HttpGetAsync(url)
    end)

    if not success then
        return nil
    elseif bool1 then
        return result
    end

    return decodeJSON(result)
end

local function rbxPostAsync(url: string, str2: string, contentType: string?) -- Luacid: Inlined by compiler; 7 call sites recovered
    local success, result = pcall(function(): string
        return game:HttpPostAsync(url, str2, contentType)
    end)

    if not success then
        return nil
    end

    return decodeJSON(result)
end

local function rbxApiGetAsync(apiUrlPath: string) -- Luacid: unused: defined but never referenced
    local success, result = pcall(function(): string
        return HttpRbxApiService:GetAsync(apiUrlPath)
    end)

    if not success then
        return nil
    end

    return decodeJSON(result)
end

local function rbxApiPostAsync(apiUrlPath: string, str2: string, throttlingPriority: Enum.ThrottlingPriority?, httpContentType: Enum.HttpContentType?) -- Luacid: unused: defined but never referenced
    local success, result = pcall(function(): string
        return HttpRbxApiService:PostAsync(apiUrlPath, str2, throttlingPriority, httpContentType)
    end)

    if not success then
        return nil
    end

    return decodeJSON(result)
end

local function rbxApiPostAsyncFullUrl(apiUrl: string, str2: string, throttlingPriority: Enum.ThrottlingPriority, httpContentType: Enum.HttpContentType) -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(function(): string
        return HttpRbxApiService:PostAsyncFullUrl(apiUrl, str2, throttlingPriority, httpContentType)
    end)

    if not success then
        return nil
    end

    return decodeJSON(result)
end

local function rbxRequestInternal(options) -- Luacid: Inlined by compiler; 10 call sites recovered
    local var4 = nil
    local var5 = Utility.Signal()
    HttpService:RequestInternal(options):Start(function(arg1, arg2)
        if arg1 and arg2.StatusCode ~= 401 and not (arg2.StatusCode < 200 or arg2.StatusCode >= 400) then
            var4 = decodeJSON(arg2.Body)
        end

        var5:fire()
    end)

    var5:wait()
    return var4
end

local function buildServiceUrl(str2: string)
    return string.gsub(BaseUrl, "https://www.", "https://" .. str2 .. ".")
end

local function isStringNilOrEmpty(arg1): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    return arg1 == nil or #arg1 == 0
end

function module.GetCuratedSortAsync(arg1, arg2)
    return rbxGetAsync(string.format("%sgames/set?GameSetTargetId=%d&MaxRows=%d", BaseUrl, arg1, arg2), false)
end

function module.GetCuratedSortByUrlAsync(url)
    return rbxGetAsync(url, false)
end

function module.GetUserPlacesAsync(arg1, arg2, arg3)
    local url = string.format("%sgames/list-users-games-json?userid=%d&startIndex=%d&pageSize=%d", BaseUrl, arg3, arg1, arg2)

    local success, result = pcall(function(): string
        return game:HttpGetAsync(url)
    end)

    if not success then
        return nil
    end

    return decodeJSON(result)
end

function module.SearchGamesAsync(arg1, arg2, input: string)
    local url = string.format(
        "%sgames/list-json?keyword=%s&StartRows=%d&MaxRows=%d&filterByDeviceType=true",
        BaseUrl,
        HttpService:UrlEncode(input),
        arg1,
        arg2
    )

    local success, result = pcall(function(): string
        return game:HttpGetAsync(url)
    end)

    if not success then
        return nil
    end

    return decodeJSON(result)
end

function module.GetGamesAsync(arg1)
    local url = string.gsub(BaseUrl, "https://www.", "https://games.") .. "v1/games?universeIds=" .. table.concat(arg1, ",")

    local success, result = pcall(function(): string
        return game:HttpGetAsync(url)
    end)

    if not success then
        return nil
    end

    return decodeJSON(result)
end

function module.PostExperienceGuidelines(universeId)
    return rbxRequestInternal({
        Url = string.format("%sexperience-guidelines-api/experience-guidelines/get-age-recommendation", buildServiceUrl("apis")),
        Method = "POST",
        Body = HttpService:JSONEncode({ universeId = universeId }),
        Headers = { ["Content-Type"] = "application/json", Accept = "application/json" }
    })
end

function module.GetGameIconIdAsync(arg1)
    local url = BaseUrl .. "places/icons/json?placeId=" .. tostring(arg1)

    local success, result = pcall(function(): string
        return game:HttpGetAsync(url)
    end)

    if not success then
        return nil
    end

    return decodeJSON(result)
end

function module.GetGameVotesAsync(arg1)
    local url = BaseUrl .. "PlaceItem/GameDetailsVotingPanelJson?placeId=" .. tostring(arg1)

    local success, result = pcall(function(): string
        return game:HttpGetAsync(url)
    end)

    if not success then
        return nil
    end

    return decodeJSON(result)
end

function module.GetRecommendedGamesAsync(arg1)
    local url = BaseUrl .. "Games/GetRecommendedGamesJson?currentPlaceId=" .. tostring(arg1)

    local success, result = pcall(function(): string
        return game:HttpGetAsync(url)
    end)

    if not success then
        return nil
    end

    return decodeJSON(result)
end

function module.GetGameThumbnailsAsync(arg1)
    local url = BaseUrl .. "thumbnail/place-thumbnails?placeId=" .. tostring(arg1)

    local success, result = pcall(function(): string
        return game:HttpGetAsync(url)
    end)

    if not success then
        return nil
    end

    return decodeJSON(result)
end

function module.GetBadgesForUniverseAsync(arg1, arg2)
    local url = string.format(
        "%sv1/universes/%d/badges?sortOrder=Asc&limit=100",
        string.gsub(BaseUrl, "https://www.", "https://badges."),
        arg1
    )
    if arg2 then
        url = string.format(url .. "&cursor=%s", arg2)
    end

    local success, result = pcall(function(): string
        return game:HttpGetAsync(url)
    end)

    if not success then
        return nil
    end

    return decodeJSON(result)
end

function module.GetUserAwardedBadgesAsync(arg1, arg2)
    local str2 = table.concat(arg2, ",")
    local url = string.format(
        "%sv1/users/%d/badges/awarded-dates?badgeIds=%s",
        string.gsub(BaseUrl, "https://www.", "https://badges."),
        arg1,
        str2
    )

    local success, result = pcall(function(): string
        return game:HttpGetAsync(url)
    end)

    if not success then
        return nil
    end

    return decodeJSON(result)
end

function module.PostFavoriteToggleAsync(arg1)
    return rbxPostAsync(BaseUrl .. "favorite/toggle?assetID=" .. tostring(arg1), "favoriteToggle", nil)
end

function module.PostGameVoteAsync(arg1, arg2)
    return rbxPostAsync(BaseUrl .. "voting/vote?assetId=" .. tostring(arg1) .. "&vote=" .. tostring(arg2), "vote", nil)
end

function module.RegisterAppPresence()
    local url = string.format("%s/v1/presence/register-app-presence", buildServiceUrl("presence"))

    local input = {
        location = GetFStringAppLocationForAppPresence()
    }
    return rbxPostAsync(url, HttpService:JSONEncode(input), nil)
end

function module.GetCrossplayEnabledStatusAsync()
    return rbxRequestInternal({
        Url = string.format(
            "%suser-settings-api/v1/user-settings?requestedUserSettings=xboxCrossPlayStatusIsEnabled",
            buildServiceUrl("apis")
        ),
        Method = "GET"
    })
end

function module.PostCrossplayStatusAsync(xboxCrossPlayStatusIsEnabled)
    return rbxRequestInternal({
        Url = string.format("%suser-settings-api/v1/user-settings", buildServiceUrl("apis")),
        Method = "POST",
        Body = HttpService:JSONEncode({ xboxCrossPlayStatusIsEnabled = xboxCrossPlayStatusIsEnabled }),
        Headers = { ["Content-Type"] = "application/json", Accept = "application/json" }
    })
end

function module.GetRecommendedUsersndsAsync()
    local url = string.format("%s/v1/recommended-users", buildServiceUrl("friends"))

    local success, result = pcall(function(): string
        return game:HttpGetAsync(url)
    end)

    if not success then
        return nil
    end

    return decodeJSON(result)
end

function module.GetUsersPresenceAsync(userIds)
    local str2 = HttpService:JSONEncode({ userIds = userIds })
    return rbxPostAsync(string.format("%s/v1/presence/users", buildServiceUrl("presence")), str2, nil)
end

function module.GetPlatformUserBalanceAsync()
    local url = string.format("%sv1/user/currency", buildServiceUrl("economy"))

    local success, result = pcall(function(): string
        return game:HttpGetAsync(url)
    end)

    if not success then
        return nil
    end

    return decodeJSON(result)
end

function module.GetTotalUserBalanceAsync()
    local url = string.format("%sv1/user/currency", buildServiceUrl("economy"))

    local success, result = pcall(function(): string
        return game:HttpGetAsync(url)
    end)

    if not success then
        return nil
    end

    return decodeJSON(result)
end

function module.GetUserOwnedPackagesAsync(arg1, arg2)
    local url = BaseUrl .. "users/inventory/list-json?userId=" .. tostring(arg1) .. "&assetTypeId=" .. tostring(32) .. "&pageNumber=" .. tostring(arg2 or 1)

    local success, result = pcall(function(): string
        return game:HttpGetAsync(url)
    end)

    if not success then
        return nil
    end

    return decodeJSON(result)
end

function module.GetCurrentlyWearingAsync(arg1)
    local url = string.format("%s/v1/users/%d/currently-wearing", string.gsub(BaseUrl, "https://www.", "https://avatar."), arg1)

    local success, result = pcall(function(): string
        return game:HttpGetAsync(url)
    end)

    if not success then
        return nil
    end

    return decodeJSON(result)
end

function module.SetWearingAssetsAsync(assetIds)
    local body = HttpService:JSONEncode({ assetIds = assetIds })
    return rbxRequestInternal({
        Url = string.format("%s/v1/avatar/set-wearing-assets", buildServiceUrl("avatar")),
        Method = "POST",
        Body = body,
        Headers = { ["Content-Type"] = "application/json" }
    })
end

function module.PurchaseProductAsync(arg1, expectedPrice, expectedSellerId, expectedCurrency)
    return rbxPostAsync(
        string.format("%s/v1/purchases/products/%d", string.gsub(BaseUrl, "https://www.", "https://economy."), arg1),
        HttpService:JSONEncode(
            {
                expectedCurrency = expectedCurrency,
                expectedPrice = expectedPrice,
                expectedSellerId = expectedSellerId
            }
        ),
        nil
    )
end

function module.MultiGetBundleDetailsAsync(arg1)
    local str2 = table.concat(arg1, ",")
    local url = string.format("%sv1/bundles/details?bundleIds=%s", string.gsub(BaseUrl, "https://www.", "https://catalog."), str2)

    local success, result = pcall(function(): string
        return game:HttpGetAsync(url)
    end)

    if not success then
        return nil
    end

    return decodeJSON(result)
end

function module.GetUserOwnedBundlesAsync(arg1, arg2)
    local url = string.format(
        "%sv1/users/%s/bundles?sortOrder=Asc&limit=100",
        string.gsub(BaseUrl, "https://www.", "https://catalog."),
        tostring(arg1)
    )
    if arg2 then
        url = string.format(url .. "&cursor=%s", arg2)
    end

    local success, result = pcall(function(): string
        return game:HttpGetAsync(url)
    end)

    if not success then
        return nil
    end

    return decodeJSON(result)
end

function module.GetAssetThumbnailBatchAsync(arg1, arg2, arg3)
    local var4 = string.gsub(BaseUrl, "https://www.", "https://games.") .. "v1/games/game-thumbnails?%s&height=" .. tostring(arg3) .. "&width=" .. tostring(arg2)
    local str2 = "imageTokens=" .. table.concat(arg1, "&imageTokens=")
    local url = string.format(var4, str2)

    local success, result = pcall(function(): string
        return game:HttpGetAsync(url)
    end)

    if not success then
        return nil
    end

    return decodeJSON(result)
end

function module.ReportAbuseAsyncV2(str2: string, str3: string, str4: string, str5: string, str6: string, str7: string, str8: string, str9: string, str10: string)
    local str11 = HttpService:JSONEncode({
        tags = {
            ENTRY_POINT = {
                valueList = {{ data = str7 }}
            },
            SUBMITTER_USER_ID = {
                valueList = {{ data = str2 }}
            },
            REPORT_TARGET_USER_ID = {
                valueList = {{ data = str4 }}
            },
            REPORTED_ABUSE_CATEGORY = {
                valueList = {{ data = str9 }}
            },
            REPORTED_ABUSE_VECTOR = {
                valueList = {{ data = str8 }}
            },
            REPORTER_COMMENT = {
                valueList = {{ data = str10 }}
            },
            REPORT_TARGET_ASSET_ID = {
                valueList = {{ data = str3 }}
            },
            REPORT_TARGET_ASSET_NAME = {
                valueList = {{ data = str5 }}
            },
            REPORT_TARGET_ASSET_DESCRIPTION = {
                valueList = {{ data = str6 }}
            }
        }
    })
    local apiUrl = Url.APIS_URL .. "abuse-reporting/v2/abuse-report"

    if str11 then
        return rbxApiPostAsyncFullUrl(apiUrl, str11, Enum.ThrottlingPriority.Default, Enum.HttpContentType.ApplicationJson)
    end

    return nil
end

function module.GetConsecutiveDaysLoggedInAsync()
    return rbxRequestInternal(
        {
            Url = string.format("%sv1/xbox/get-login-consecutive-days", buildServiceUrl("auth")),
            Method = "GET"
        }
    )
end

function module.IsValidUsername(input: string, arg1)
    if not (isStringNilOrEmpty(input) or isStringNilOrEmpty(arg1)) then
        return rbxRequestInternal({
            Url = string.format(
                "%sv2/usernames/validate?request.username=%s&request.birthday=%s",
                string.gsub(BaseUrl, "https://www.", "https://auth."),
                HttpService:UrlEncode(input),
                arg1
            ),
            Method = "GET"
        })
    end
end

function module.IsValidPassword(input: string, input2: string)
    if not (isStringNilOrEmpty(input) or isStringNilOrEmpty(input2)) then
        return rbxRequestInternal({
            Url = string.format(
                "%sv2/passwords/validate?request.username=%s&request.password=%s",
                string.gsub(BaseUrl, "https://www.", "https://auth."),
                HttpService:UrlEncode(input),
                HttpService:UrlEncode(input2)
            ),
            Method = "GET"
        })
    end
end

function module.PostSponsoredGameClickAsync(arg1)
    local url = string.format("%sv1/sponsored-games/click", buildServiceUrl("ads"))
    local str2, var4 = string.format("\"%s\"", arg1)
    return rbxPostAsync(url, str2, var4)
end

function module.GetUserVoteCountFromVotingApiAsync()
    return rbxRequestInternal(
        {
            Url = string.format("%svoting-api/user/get-vote-count?targetType=Place", buildServiceUrl("apis")),
            Method = "GET"
        }
    )
end

function module.CreateCrossDeviceLoginCode()
    return rbxPostAsync(string.format("%sauth-token-service/v1/login/create", buildServiceUrl("apis")), "", nil)
end

function module.CheckCrossDeviceLoginStatus(code, privateKey)
    return rbxRequestInternal({
        Url = string.format("%sauth-token-service/v1/login/status", buildServiceUrl("apis")),
        Method = "POST",
        Body = HttpService:JSONEncode({ code = code, privateKey = privateKey }),
        Headers = { ["Content-Type"] = "application/json", Accept = "application/json" }
    })
end

function module.CancelCrossDeviceLogin(code)
    return rbxRequestInternal({
        Url = string.format("%sauth-token-service/v1/login/cancel", buildServiceUrl("apis")),
        Method = "POST",
        Body = HttpService:JSONEncode({ code = code }),
        Headers = { ["Content-Type"] = "application/json", Accept = "application/json" }
    })
end

return module
