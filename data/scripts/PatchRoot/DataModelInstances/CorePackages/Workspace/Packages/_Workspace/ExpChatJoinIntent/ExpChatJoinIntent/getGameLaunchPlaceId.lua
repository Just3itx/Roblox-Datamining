-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    "^roblox://placeid=",
    "^robloxmobile://placeid=",
    "^roblox://experiences/start%?",
    "^robloxmobile://experiences/start%?"
}

local tbl2 = { "roblox.com", "robloxlabs.com" }

local function isRobloxWebHost(str1: string)
    for _, value in tbl2 do
        if str1 == value then
            return true
        end

        if string.sub(str1, -(#value + 1)) == "." .. value then
            return true
        end
    end
    return false
end

local function isGameLaunchUrl(str1: string)
    for _, value in tbl1 do
        if string.find(str1, value) then
            return true
        end
    end
    local var1 = string.match(str1, "^https?://([^/]+)/games/start%?")
    return not (var1 == nil) and isRobloxWebHost(var1)
end

local function getGameLaunchPlaceId(str1: string)
    local str2 = string.lower(str1)
    if not isGameLaunchUrl(str2) then
        return nil
    end
    local var1 = string.match(str2, "[/?&]placeid=(%d+)")
    if var1 then
        return tonumber(var1)
    end

    return nil
end

return getGameLaunchPlaceId
