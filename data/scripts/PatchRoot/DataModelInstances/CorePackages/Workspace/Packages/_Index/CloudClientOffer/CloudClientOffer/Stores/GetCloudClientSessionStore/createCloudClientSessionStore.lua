-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function createCloudClientSessionStore()
    local tbl1 = ({})

    return {
        isPlaceRefused = function(str1: string): boolean
            return tbl1[str1] == true
        end,
        markPlaceRefused = function(str1: string)
            tbl1[str1] = true
        end,
        reset = function()
            table.clear(tbl1)
        end
    }
end
return createCloudClientSessionStore
