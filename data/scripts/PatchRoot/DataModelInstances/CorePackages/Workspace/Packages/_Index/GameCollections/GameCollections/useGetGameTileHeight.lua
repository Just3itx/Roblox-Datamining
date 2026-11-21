-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameCollections = script:FindFirstAncestor("GameCollections")
local GameCollectionsParent = GameCollections.Parent

local React = require(GameCollectionsParent.React)
local useDesignTokens = require(GameCollectionsParent.Style).useDesignTokens
local GameTileConstants = require(GameCollectionsParent.GameTile).GameTileConstants
local Responsive = require(GameCollectionsParent.Responsive)
local useBreakpointXOrSmaller = Responsive.useBreakpointXOrSmaller
local GameCollectionLayoutCalculators = require(GameCollections.GameCollectionLayoutCalculators)

local FFlagLuaAppFixHomeGridPlaceholderFlowIssues = require(GameCollectionsParent.SharedFlags).FFlagLuaAppFixHomeGridPlaceholderFlowIssues
local FFlagLuaAppNarrowTileHideRating = require(GameCollectionsParent.SharedFlags).FFlagLuaAppNarrowTileHideRating
local FFlagLuaAppNarrowTileHidePlayerCount = require(GameCollectionsParent.SharedFlags).FFlagLuaAppNarrowTileHidePlayerCount

local function useGetGameTileHeight(bool1: boolean?, arg1, bool2: boolean?, bool3: boolean?, bool4: boolean?, num1: number?, num2: number?, num3: number?, bool5: boolean?)
    local var1 = useDesignTokens()

    local var2 = useBreakpointXOrSmaller(Responsive.Keys.Small)
    if FFlagLuaAppFixHomeGridPlaceholderFlowIssues then
        if var2 then
            if num1 then
                if num1 > 0 then
                    var2 = not (if FFlagLuaAppNarrowTileHideRating then bool5 else FFlagLuaAppNarrowTileHidePlayerCount and bool5)
                else
                    var2 = false
                end
            else
                var2 = num1
            end
        end
    elseif var2 then
        if num1 > 0 then
            var2 = not (if FFlagLuaAppNarrowTileHideRating then bool5 else FFlagLuaAppNarrowTileHidePlayerCount and bool5)
        else
            var2 = false
        end
    end

    local var3 = if var2 then GameTileConstants.TileTextLines[arg1].largeMetadataTextLines else GameTileConstants.TileTextLines[arg1].metadataTextLines
    local useCallback = React.useCallback
    local function func1(num4: number)
        return GameCollectionLayoutCalculators.calculateTileHeightFromWidth(
            num4,
            bool1,
            arg1,
            var1,
            bool2,
            bool3,
            bool4,
            num1,
            num2,
            num3,
            var3
        )
    end

    local var4 = var3
    if not (FFlagLuaAppNarrowTileHideRating or FFlagLuaAppNarrowTileHidePlayerCount) then
        bool5 = nil
    end

    return useCallback(func1, { var1, bool1, arg1, bool2, bool3, bool4, num1, num2, num3, var4, bool5 })
end

return useGetGameTileHeight
