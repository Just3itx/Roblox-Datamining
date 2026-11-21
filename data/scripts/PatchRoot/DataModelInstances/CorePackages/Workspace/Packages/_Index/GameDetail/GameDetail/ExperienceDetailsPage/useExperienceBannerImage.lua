-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailParent = script:FindFirstAncestor("GameDetail").Parent

local React = require(GameDetailParent.React)
local SignalsReact = require(GameDetailParent.SignalsReact)

local GameMediaImageType = require(GameDetailParent.DiscoveryTypes).GameMediaImageType

local DataHydration = require(GameDetailParent.DataHydration)
local DataStatus = DataHydration.DataStatus
local getGameMediaStore = DataHydration.Game.getGameMediaStore

local Url = require(GameDetailParent.Http).Url

local bool1 = game:DefineFastFlag("ExperienceBannerImageAllowCustomDimensions", false)
local bool2 = game:DefineFastFlag("ExperienceBannerImageDefaultFallback", false)

local function useExperienceBannerImage(str1: string, str2: string?, num1: number?, num2: number?)
    local var1 = getGameMediaStore(false).getAndFetchGameMedia(str1)
    local var2 = SignalsReact.useSignalState(var1.data)
    local var3 = SignalsReact.useSignalState(var1.status)

    local num3 = bool1 and num1 or 768

    local num4 = bool1 and num2 or 432

    return React.useMemo(function()
        if var3 == DataStatus.NotReady then
            return { status = "Loading", url = nil }
        elseif bool2 then
            if var3 == DataStatus.Failed then
                return { status = "Failed", url = nil }
            end

            if var2 then
                for _, value in var2 do
                    if value.assetTypeId == GameMediaImageType.Image and value.imageId then
                        return {
                            status = "Success",
                            url = string.format("rbxthumb://type=Asset&id=%s&w=%d&h=%d", tostring(value.imageId), num3, num4)
                        }
                    end
                end
            end
            return if str2 == nil or str2 == "" then { status = "NotFound", url = nil } else {
                status = "Fallback",
                url = Url:getPlaceDefaultThumbnailUrl(str2, num3, num4)
            }
        else
            if var3 == DataStatus.Failed or not var2 then
                return { status = "NotFound", url = nil }
            end

            for _, value in var2 do
                if value.assetTypeId == GameMediaImageType.Image and value.imageId then
                    return {
                        status = "Success",
                        url = string.format("rbxthumb://type=Asset&id=%s&w=%d&h=%d", tostring(value.imageId), num3, num4)
                    }
                end
            end
            return { status = "NotFound", url = nil }
        end
    end, {
        var3,
        var2,
        num3,
        num4,
        str2
    })
end
return useExperienceBannerImage
