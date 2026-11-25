-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent
local React = require(ServerDrivenUiParent.React)
local SignalsReact = require(ServerDrivenUiParent.SignalsReact)
local abbreviateCount = require(ServerDrivenUiParent.Localization).abbreviateCount
local _Foundation = require(ServerDrivenUiParent.Foundation)
local Images = require(ServerDrivenUiParent.FoundationImages).Images

local _SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiGameTileActiveFriendsFooter = require(ServerDrivenUi.Content.SduiGameTileActiveFriendsFooter)
local SduiTileFooter = require(ServerDrivenUi.Content.SduiTileFooter)
local SduiInGameFriendsData = require(ServerDrivenUi.DataStore.SduiInGameFriendsData)

local FFlagLuaAppFixInlineSignalsReactPattern = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppFixInlineSignalsReactPattern

local FFlagSduiGameTileUseFooterComponentAsDefault = require(ServerDrivenUiParent.SharedFlags).FFlagSduiGameTileUseFooterComponentAsDefault
local FFlagSduiActiveFriendsFooterTreatment = require(ServerDrivenUiParent.SharedFlags).FFlagSduiActiveFriendsFooterTreatment

return React.memo(function(tbl1) -- name: SduiGameTileFooter
    local getInGameFriendsByGame = SduiInGameFriendsData.getInGameFriendsByGame
    local var1

    if FFlagLuaAppFixInlineSignalsReactPattern then
        local var2 = React.useCallback(function(arg1)
            local var2 = getInGameFriendsByGame(arg1)[tbl1.universeId]
            if var2 then
                for _ in var2 do
                    return true
                end
            end
            return false
        end, { getInGameFriendsByGame, tbl1.universeId })
        var1 = SignalsReact.useSignalState(var2)
    else
        var1 = SignalsReact.useSignalState(function(arg1)
            local var2 = getInGameFriendsByGame(arg1)[tbl1.universeId]
            if var2 then
                for _ in var2 do
                    return true
                end
            end
            return false
        end)
    end

    if (tbl1.isSelected or tbl1.isHovered) and tbl1.ageRatingText and tbl1.ageRatingText ~= "" then
        return React.createElement(SduiTileFooter, {
            leftText = tbl1.ageRatingText,
            analyticsContext = tbl1.analyticsContext,
            fontStyle = tbl1.metadataFontStyle,
            testId = "--sdui-game-tile-footer-age-rating"
        })
    elseif var1 then
        if FFlagSduiActiveFriendsFooterTreatment and tbl1.activeFriendsFooterComponent then
            return tbl1.activeFriendsFooterComponent
        end

        return React.createElement(SduiGameTileActiveFriendsFooter, {
            placeId = tbl1.placeId,
            universeId = tbl1.universeId,
            sduiContext = tbl1.sduiContext,
            analyticsContext = tbl1.analyticsContext,
            testId = "--sdui-game-tile-footer-active-friends",
            hideBorder = true
        })
    else
        if FFlagSduiGameTileUseFooterComponentAsDefault and tbl1.useFooterComponentAsDefault
            or not tbl1.ratingText
            or tbl1.ratingText == ""
        then
            return tbl1.footerComponent
        end

        local sduiContext = tbl1.sduiContext
        local ratingText = tbl1.ratingText
        local iconsStatusGamesRatingSmall = if tbl1.ratingText then Images["icons/status/games/rating_small"] else nil
        local var2, iconsStatusGamesPeoplePlayingSmall

        if tbl1.playerCount == nil then
            var2 = nil
            iconsStatusGamesPeoplePlayingSmall = nil
        else
            var2 = if tbl1.playerCount == -1 then "--" else abbreviateCount(tbl1.playerCount, sduiContext.dependencies.localization:GetLocale())
            iconsStatusGamesPeoplePlayingSmall = Images["icons/status/games/people-playing_small"]
        end

        return React.createElement(SduiTileFooter, {
            sduiContext = tbl1.sduiContext,
            leftText = ratingText,
            leftIcon = iconsStatusGamesRatingSmall,
            rightText = var2,
            rightIcon = iconsStatusGamesPeoplePlayingSmall,
            fontStyle = tbl1.metadataFontStyle,
            testId = "--sdui-game-tile-footer-rating"
        })
    end
end)
