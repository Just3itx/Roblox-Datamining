-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:31:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInvite = script:FindFirstAncestor("GameInvite")

local ServerType = require(GameInvite.Enums.ServerType)

local function canShareGameInviteLink(num1: number, tbl1, bool1: boolean?)
    local isCoreScript

    if num1 > 0 then
        isCoreScript = tbl1.isCoreScript

        if isCoreScript then
            if tbl1.serverType == ServerType.StandardServer then
                isCoreScript = bool1 == true
            else
                isCoreScript = false
            end
        end
    else
        isCoreScript = false
    end

    return isCoreScript
end

return canShareGameInviteLink
