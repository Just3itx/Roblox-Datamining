-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T09:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PlayerContextualMenuParent = script:FindFirstAncestor("PlayerContextualMenu").Parent

local Images = require(PlayerContextualMenuParent.UIBlox).App.ImageSet.Images
local _Types = require(script.Parent.Types)

local function getPresenceIcon(arg1, tbl1)
    if arg1 then
        if arg1.status == "InGame" then
            return Images["icons/menu/games_small"], tbl1.iconEmphasis
        end

        if arg1.status == "Online" or arg1.status == "InStudio" then
            return Images["component_assets/circle_16"], tbl1.onlinePresence
        end
    end

    return nil, nil
end

return getPresenceIcon
