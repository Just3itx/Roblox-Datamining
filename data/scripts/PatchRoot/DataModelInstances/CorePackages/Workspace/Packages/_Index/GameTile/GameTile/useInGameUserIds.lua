-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:31:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTileParent = script:FindFirstAncestor("GameTile").Parent
local React = require(GameTileParent.React)

local function useInGameUserIds(str1: string, tbl1)
    return React.useMemo(function()
        if not (str1 and tbl1) then
            return {}
        end

        local result = {}
        for value, _ in tbl1 do
            if value ~= str1 then
                table.insert(result, value)
            end
        end
        return result
    end, { str1, tbl1 })
end

return useInGameUserIds
