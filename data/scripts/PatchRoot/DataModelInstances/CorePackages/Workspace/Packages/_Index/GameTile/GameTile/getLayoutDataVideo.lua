-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")
local GameTileParent = GameTile.Parent

local _GameTileTypes = require(GameTile.GameTileTypes)

local FFlagLuaAppHomeMomentVideoPrecedence = require(GameTileParent.SharedFlags).FFlagLuaAppHomeMomentVideoPrecedence
local FFlagLuaAppDiscoveryMomentVideoTelemetry = require(GameTileParent.SharedFlags).FFlagLuaAppDiscoveryMomentVideoTelemetry

local function isNonEmptyString(arg1): boolean -- Luacid: Inlined by compiler; 6 call sites recovered
    return type(arg1) == "string" and arg1 ~= ""
end

local function getMomentVideo(tbl1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if not (isNonEmptyString(tbl1.momentVideoAssetId) and isNonEmptyString(tbl1.momentVideoAssetAccessContext)) then
        return nil
    end

    return {
        assetId = tbl1.momentVideoAssetId,
        accessContext = tbl1.momentVideoAssetAccessContext,
        isMoment = if FFlagLuaAppDiscoveryMomentVideoTelemetry then true else nil
    }
end

local function getLayoutDataVideo(arg1, assetId: string?)
    local primaryMediaAsset = arg1 and arg1.primaryMediaAsset

    if FFlagLuaAppHomeMomentVideoPrecedence then
        local momentVideo = if primaryMediaAsset then getMomentVideo(primaryMediaAsset) else nil

        if momentVideo then
            return momentVideo
        end
    end

    if assetId then
        return { assetId = assetId }
    elseif not primaryMediaAsset then
        return nil
    elseif primaryMediaAsset.wideVideoAssetId then
        return {
            assetId = primaryMediaAsset.wideVideoAssetId
        }
    elseif not FFlagLuaAppHomeMomentVideoPrecedence then
        return getMomentVideo(primaryMediaAsset)
    end

    return nil
end

return getLayoutDataVideo
