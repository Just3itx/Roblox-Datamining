-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInfosRodux = script:FindFirstAncestor("GameInfosRodux")
local GameInfosReducer = require(GameInfosRodux.GameInfosReducer)
local AddGames = require(GameInfosRodux.AddGames)
local syncGameInfosToStore = require(GameInfosRodux.syncGameInfosToStore)

local GameInfosRoduxParent = GameInfosRodux.Parent
local tutils = require(GameInfosRoduxParent.tutils)
local DataHydration = require(GameInfosRoduxParent.DataHydration)
local _DiscoveryTypes = require(GameInfosRoduxParent.DiscoveryTypes)

local function parseAndAddGameInfos(_, arg1, arg2, arg3, callback: ((...any) -> (...any))?, func1: ((...any) -> (...any))?)
    local var1 = arg1:getState().Personalization[GameInfosReducer.key]

    local tbl1 = ({})
    local tbl2 = {}

    local tbl3 = ({})

    for _, value in arg2 do
        arg3(value):match(function(arg4)
            local universeId = arg4.universeId
            tbl3[universeId] = arg4

            if not tutils.shallowEqual(arg4, var1[universeId]) then
                tbl1[universeId] = arg4
                if not func1 or func1(universeId) then
                    table.insert(tbl2, universeId)
                end
            end

            if callback then
                callback(value, arg4)
            end
        end):matchError(function(arg4)
            warn(`parseAndAddGameInfos could not parse gameInfo: {arg4}`)
        end)
    end

    if next(tbl1) then
        arg1:dispatch(AddGames(tbl1))
    end

    if next(tbl3) then
        syncGameInfosToStore(tbl3)
    end

    if #tbl2 > 0 then
        DataHydration.Game.getGameIconStore(false).getAndFetchGameIcons(tbl2)
    end
end

return parseAndAddGameInfos
