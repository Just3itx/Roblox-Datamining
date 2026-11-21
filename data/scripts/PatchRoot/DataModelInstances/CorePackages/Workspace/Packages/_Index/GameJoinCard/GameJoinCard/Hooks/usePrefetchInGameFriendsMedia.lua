-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCard = script:FindFirstAncestor("GameJoinCard")
local GameJoinCardParent = GameJoinCard.Parent

local React = require(GameJoinCardParent.React)

local prefetchGameJoinCardMedia = require(GameJoinCard.prefetchGameJoinCardMedia)

local function usePrefetchInGameFriendsMedia(tbl1)
    local var1 = React.useMemo(function(): string
        if not tbl1 then
            return ""
        end
        local tbl2 = ({})
        local tbl3 = {}
        for _, value in tbl1 do
            local presence = value.presence
            if not presence or presence.userPresenceType ~= "InGame" then
                continue
            end

            local str1 = tostring(presence.universeId or "")
            if str1 ~= "" and not tbl2[str1] then
                tbl2[str1] = true
                table.insert(tbl3, str1)
            end
        end
        table.sort(tbl3)
        return table.concat(tbl3, ",")
    end, { tbl1 })

    React.useEffect(function()
        if var1 == "" then
            return
        end
        local tbl2 = {}
        for _, universeId in string.split(var1, ",") do
            table.insert(tbl2, { universeId = universeId })
        end
        prefetchGameJoinCardMedia(tbl2)
    end, { var1 })
end

return usePrefetchInGameFriendsMedia
