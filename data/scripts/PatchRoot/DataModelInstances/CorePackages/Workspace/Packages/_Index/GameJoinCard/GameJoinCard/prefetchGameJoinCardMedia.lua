-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContentProvider = game:GetService("ContentProvider")

local GameJoinCardParent = script:FindFirstAncestor("GameJoinCard").Parent

local DataHydration = require(GameJoinCardParent.DataHydration)
local DataStatus = DataHydration.DataStatus
local getGameMediaStore = DataHydration.Game.getGameMediaStore
local GameMediaImageType = require(GameJoinCardParent.DiscoveryTypes).GameMediaImageType
local Signals = require(GameJoinCardParent.Signals)

local Foundation = require(GameJoinCardParent.Foundation)
local getRbxThumb = Foundation.Utility.getRbxThumb
local ThumbnailType = Foundation.Enums.ThumbnailType
local ThumbnailSize = Foundation.Enums.ThumbnailSize

local BannerImageConstants = require(script.Parent.BannerImageConstants)
local FFlagMobileGameJoinCardThumbnail = require(script.Parent.Flags.FFlagMobileGameJoinCardThumbnail)

local function preloadFirstImage(tbl1)
    if not tbl1 then
        return
    end
    for _, value in tbl1 do
        if value.assetTypeId ~= GameMediaImageType.Image or not value.imageId then
            continue
        end

        local var1 = string.format(
            "rbxthumb://type=Asset&id=%s&w=%d&h=%d",
            tostring(value.imageId),
            BannerImageConstants.DEFAULT_BANNER_WIDTH,
            BannerImageConstants.DEFAULT_BANNER_HEIGHT
        )
        task.spawn(function()
            pcall(function()
                ContentProvider:PreloadAsync({ var1 })
            end)
        end)
        return
    end
end

local function prefetchUniverseMedia(str1: string)
    local var1 = getGameMediaStore(false).getAndFetchGameMedia(str1)

    local var2 = var1.status(false)
    if var2 ~= DataStatus.NotReady then
        if var2 == DataStatus.Ready then
            preloadFirstImage(var1.data(false))
        end
        return
    end

    local effect = nil
    effect = Signals.createEffect(function(arg1)
        local var3 = var1.status(arg1)
        if var3 == DataStatus.NotReady then
            return
        end
        if effect then
            effect()
            effect = nil
        end
        if var3 == DataStatus.Ready then
            preloadFirstImage(var1.data(false))
        end
    end)
end

local function preloadGameThumbnail(str1: string, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = arg1 or ContentProvider
    local rbxThumb = getRbxThumb(ThumbnailType.GameIcon, str1, ThumbnailSize.Medium)
    task.spawn(function()
        pcall(function()
            var1:PreloadAsync({ rbxThumb })
        end)
    end)
end

local function prefetchGameJoinCardMedia(tbl1, arg1)
    if not tbl1 then
        return
    end

    for _, value in tbl1 do
        if not value.universeId or value.universeId == "" then
            continue
        end

        if FFlagMobileGameJoinCardThumbnail then
            local universeId = value.universeId
            preloadGameThumbnail(tostring(universeId), arg1)
        end
        prefetchUniverseMedia(tostring(value.universeId))
    end
end

return prefetchGameJoinCardMedia
