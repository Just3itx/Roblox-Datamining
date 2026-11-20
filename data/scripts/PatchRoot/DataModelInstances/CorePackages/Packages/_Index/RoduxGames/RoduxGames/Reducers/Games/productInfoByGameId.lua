-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:01:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxGames = script:FindFirstAncestor("RoduxGames")
local RoduxGamesParent = RoduxGames.Parent
local Rodux = require(RoduxGamesParent.Rodux)
local Dash = require(RoduxGamesParent.Dash)
local ProductModel = require(RoduxGames.Models.ProductModel)

local tbl1 = {}

return function(arg1)
    local networkingGames = arg1.networkingGames

    local createReducer = Rodux.createReducer
    local tbl2 = tbl1
    local tbl3 = {}
    tbl3[networkingGames.GetExperiencesProductInfo.Succeeded.name] = function(arg2, arg3)
        return Dash.reduce(arg3.responseBody.data, function(arg4, arg5)
            local str1 = tostring(arg5.universeId)

            return Dash.join(arg4, { [str1] = ProductModel.format(arg5) })
        end, arg2)
    end

    return createReducer(tbl2, tbl3)
end
