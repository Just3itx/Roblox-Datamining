-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:31:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTileParent = script:FindFirstAncestor("GameTile").Parent
local React = require(GameTileParent.React)

local function useHasInGameFriends(arg1, arg2, tbl1)
    return (React.useMemo(function()
        if not (arg1 and arg2 and tbl1) then
            return false
        end

        for _, value in pairs(tbl1) do
            if value == arg1 then
                continue
            end

            local var1 = arg2[value]
            if var1 and var1.isFriend then
                return true
            end
        end

        return false
    end, { arg1, arg2, tbl1 }))
end

return useHasInGameFriends
