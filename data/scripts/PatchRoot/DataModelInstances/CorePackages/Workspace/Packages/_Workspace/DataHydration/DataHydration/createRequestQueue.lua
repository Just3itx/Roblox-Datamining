-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:11:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent
local FFlagSduiReleaseSearchResultsPageState = require(DataHydrationParent.SharedFlags).FFlagSduiReleaseSearchResultsPageState

local function createRequestQueue()
    local tbl1 = ({})

    local num1 = 1

    return {
        push = function(str1: string)
            if tbl1[str1] == nil then
                tbl1[str1] = num1
                num1 += 1
            end
        end,
        pop = function(num2: number)
            local tbl2 = {}
            for value, _ in tbl1 do
                table.insert(tbl2, value)
            end
            table.sort(tbl2, function(arg1, arg2): boolean
                return tbl1[arg1] < tbl1[arg2]
            end)

            if not (num2 < #tbl2) then
                table.clear(tbl1)
                return tbl2
            end

            local result = {}
            for i = 1, num2 do
                local var1 = tbl2[i]
                table.insert(result, var1)
                tbl1[var1] = nil
            end
            return result
        end,
        isEmpty = function()
            for _, _ in tbl1 do
                return false
            end
            return true
        end,
        hasItem = function(str1: string): boolean
            return tbl1[str1] ~= nil
        end,
        remove = FFlagSduiReleaseSearchResultsPageState and function(str1: string) -- name: remove
            tbl1[str1] = nil
        end or nil,
        clear = function()
            table.clear(tbl1)
            num1 = 1
        end
    }
end
return createRequestQueue
