-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:20:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExperienceStoreServerDrivenUiParent = script:FindFirstAncestor("ExperienceStoreServerDrivenUi").Parent

local UrlBuilder = require(ExperienceStoreServerDrivenUiParent.UrlBuilder).UrlBuilder
local Url = require(ExperienceStoreServerDrivenUiParent.Http).Url
local SduiCapabilities = require(ExperienceStoreServerDrivenUiParent.SduiSharedUtilities).SduiCapabilities

local FFlagLuaAppDevStoreSeeAllAdvertiseCapabilities = require(ExperienceStoreServerDrivenUiParent.SharedFlags).FFlagLuaAppDevStoreSeeAllAdvertiseCapabilities

local urlBuilder = UrlBuilder.new({ base = Url.APIS_URL, path = "experience-store/v1beta1/universes/{universeId}/dev-store-see-all" })

local function getDevStoreSeeAllUrl(universeId: string)
    local var1 = urlBuilder({ universeId = universeId })

    if FFlagLuaAppDevStoreSeeAllAdvertiseCapabilities then
        local tbl1 = {}
        SduiCapabilities.addToQueryParams(tbl1, { "CAPABILITY_SUPPORTS_FOUNDATION_BADGE_OVERMEDIA_LIGHT" })

        if next(tbl1) ~= nil then
            var1 = UrlBuilder.addQueryString(var1, tbl1)
        end
    end
    return var1
end

return getDevStoreSeeAllUrl
