-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxGames = script:FindFirstAncestor("RoduxGames")
local RoduxGamesParent = RoduxGames.Parent
local Rodux = require(RoduxGamesParent.Rodux)
local Dash = require(RoduxGamesParent.Dash)
local GameMediaModel = require(RoduxGames.Models.GameMediaModel)

local tbl1 = {}

return function(arg1)
    local networkingGames = arg1.networkingGames
    local createReducer = Rodux.createReducer
    local tbl2 = tbl1
    local tbl3 = {}
    tbl3[networkingGames.GetExperienceMedia.Succeeded.name] = function(arg2, arg3)
        local str1 = tostring(arg3.ids[1])
        return Dash.join(arg2, {
            [str1] = Dash.map(arg3.responseBody.data, function(arg4)
                return GameMediaModel.format(arg4)
            end)
        })
    end

    return createReducer(tbl2, tbl3)
end
