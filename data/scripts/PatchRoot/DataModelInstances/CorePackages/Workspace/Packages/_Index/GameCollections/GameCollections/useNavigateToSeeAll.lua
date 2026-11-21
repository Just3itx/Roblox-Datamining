-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameCollectionsParent = script:FindFirstAncestor("GameCollections").Parent
local React = require(GameCollectionsParent.React)
local useDispatch = require(GameCollectionsParent.RoactUtils).Hooks.RoactRodux.useDispatch
local AppPage = require(GameCollectionsParent.RobloxAppEnums).AppPage
local NavigateDown = require(GameCollectionsParent.NavigationRodux).Thunks.NavigateDown
local _DiscoveryTypes = require(GameCollectionsParent.DiscoveryTypes)
local FFlagSignalsNavP3Dispatch = require(GameCollectionsParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(GameCollectionsParent.RobloxAppNavigation).NavigationCommands else nil

local function useNavigateToSeeAll(arg1, isOmni: boolean, num1: number?, sortPageId: string?, str2: string?, pageContext: string?)
    local var1 = useDispatch()

    return (React.useCallback(function()
        if arg1 == nil then
            return
        end

        local tbl1 = {
            name = AppPage.GamesList,
            detail = str2,
            extraProps = {
                sortPageId = sortPageId,
                sortName = str2,
                pageContext = pageContext,
                isOmni = isOmni,
                sortIndex = if isOmni then num1 else nil
            }
        }
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
            return
        end
        var1(NavigateDown(tbl1))
    end, {
        var1,
        isOmni,
        arg1,
        num1,
        str2,
        pageContext,
        sortPageId
    }))
end
return useNavigateToSeeAll
