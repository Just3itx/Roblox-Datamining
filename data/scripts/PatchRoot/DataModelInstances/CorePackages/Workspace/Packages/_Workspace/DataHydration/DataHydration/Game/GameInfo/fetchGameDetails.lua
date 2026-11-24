-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Http = require(DataHydrationParent.Http)
local HttpRequest = require(DataHydrationParent.HttpRequest)

local Url = Http.Url

local function requestGameDetails(tbl1)
    local str1 = table.concat(tbl1, ",")

    local str2 = string.format("%sv1/games?universeIds=%s", Url.GAME_URL, str1)
    return HttpRequest.config({
        requestFunction = function(str3: string, str4: string, arg1)
            return HttpRequest.requestFunctions.HttpRbxApi(str3, str4, arg1)
        end
    })(str2, "GET")
end

return requestGameDetails
