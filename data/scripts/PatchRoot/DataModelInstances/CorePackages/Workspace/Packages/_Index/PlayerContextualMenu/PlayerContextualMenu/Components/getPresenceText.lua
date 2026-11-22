-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T09:40:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _Types = require(script.Parent.Types)

local function getPresenceText(arg1)
    if not arg1 then
        return ""
    end

    if arg1.status == "InGame" or arg1.status == "InStudio" then
        return arg1.locationString
    end

    if arg1.status == "Online" then
        return "Online"
    end

    return "Offline"
end

return getPresenceText
