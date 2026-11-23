-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContentProvider = game:GetService("ContentProvider")

local var1 = string.gsub(ContentProvider.BaseUrl:lower(), "/m.", "/www.")
local function getRobuxStoreUrl(): string
    return ("%sUpgrades/Robux.aspx"):format(var1)
end

return getRobuxStoreUrl
