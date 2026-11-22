-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:00:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SponsoredTilesParent = script:FindFirstAncestor("SponsoredTiles").Parent

local React = require(SponsoredTilesParent.React)

local useOverflowMenuOpen = require(SponsoredTilesParent.AppBlox).useOverflowMenuOpen
local gameTileOverflowMenuAction = require(SponsoredTilesParent.DiscoveryAnalytics).Events.gameTileOverflowMenuAction

local GameTile = require(SponsoredTilesParent.GameTile)
local GameTileContextualActions = GameTile.GameTileContextualActions
local GameTileOverflowMenu = GameTile.GameTileOverflowMenu

local SharedFlags = require(SponsoredTilesParent.SharedFlags)
local FFlagLuaAppGameTileNotInterestedDirectAction = SharedFlags.FFlagLuaAppGameTileNotInterestedDirectAction
local FFlagLuaAppEnableNxMRoduxApportioning = SharedFlags.FFlagLuaAppEnableNxMRoduxApportioning

local function SpanTileOverflowMenu(tbl1)
    local hoverKey = tbl1.hoverKey
    local var1 = useOverflowMenuOpen(hoverKey)

    local var2 = React.useMemo(function(): string
        local tbl2 = {}
        for k, _ in tbl1.availableMenuItems do
            table.insert(tbl2, k)
        end
        return table.concat(tbl2, ",")
    end, { tbl1.availableMenuItems })

    local var3 = React.useCallback(function(bool1: boolean, availableMenuItems: string?)
        local tbl2 = {
            universeId = if FFlagLuaAppEnableNxMRoduxApportioning then tostring(tbl1.universeId or "") else tbl1.universeId,
            sortId = tbl1.topicId,
            actionType = if bool1 then "GameTileOverflowMenuClosed" else "GameTileOverflowMenuOpened",
            availableMenuItems = availableMenuItems,
            contentType = if FFlagLuaAppEnableNxMRoduxApportioning then tbl1.contentType else nil
        }

        gameTileOverflowMenuAction(tbl2, tbl1.appPage or "Unknown")
    end, {
        tbl1.universeId,
        tbl1.appPage,
        tbl1.topicId,
        if FFlagLuaAppEnableNxMRoduxApportioning then tbl1.contentType else nil
    })

    local var4 = React.useRef(false)
    local onMenuOpenChanged = React.useCallback(function(bool1: boolean, str1: string?)
        var4.current = true
        var3(bool1, str1)
    end, { var3 })

    local var6 = React.useRef(var1)
    React.useEffect(function()
        if var1 == var6.current then
            return
        end

        var6.current = var1
        if var1 and not var4.current then
            var3(false, var2)
        end
        var4.current = false
    end, { var1, var2, var3 })

    if not (if tbl1.isHovered or tbl1.isSelected or var1 then next(tbl1.availableMenuItems) ~= nil else var1) then
        return nil
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        ZIndex = tbl1.zIndex
    }
    local tbl3 = {
        OverflowMenu = React.createElement(
            if FFlagLuaAppGameTileNotInterestedDirectAction then GameTileContextualActions else GameTileOverflowMenu,
            {
                isHovered = tbl1.isHovered,
                isSelected = tbl1.isSelected,
                universeId = tostring(tbl1.universeId or ""),
                placeId = tbl1.placeId,
                collectionId = tbl1.topicId,
                appPage = tbl1.appPage,
                setGameHidden = tbl1.setGameHidden,
                menuKey = hoverKey,
                menuOpen = var1,
                onMenuOpenChanged = onMenuOpenChanged,
                parentRef = tbl1.parentRef,
                isSponsored = tbl1.isSponsored,
                payerName = tbl1.payerName,
                sponsoredUserCohort = tbl1.sponsoredUserCohort,
                adId = tbl1.adId,
                availableMenuItems = tbl1.availableMenuItems,
                contentType = if FFlagLuaAppEnableNxMRoduxApportioning then tbl1.contentType else nil
            }
        )
    }
    return createElement(str1, tbl2, tbl3)
end

return SpanTileOverflowMenu
