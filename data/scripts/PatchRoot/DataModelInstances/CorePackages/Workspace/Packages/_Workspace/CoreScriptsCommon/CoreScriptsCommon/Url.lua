-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:10:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {}

local function getBaseDomain(baseUrl: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    local _, var1 = baseUrl:find("%.")
    local str1 = baseUrl:sub(var1 + 1)

    if str1:sub(-1) ~= "/" then
        str1 ..= "/"
    end
    return str1
end

local baseDomain = getBaseDomain(game:GetService("ContentProvider").BaseUrl)

local tbl2 = {
    GAME_URL = string.format("https://games.%s", baseDomain),
    RCS_URL = string.format("https://apis.rcs.%s", baseDomain),
    APIS_URL = string.format("https://apis.%s", baseDomain),
    ACCOUNT_SETTINGS_URL = string.format("https://accountsettings.%s", baseDomain),
    GAME_INTERNATIONALIZATION_URL = string.format("https://gameinternationalization.%s", baseDomain),
    LOCALE_URL = string.format("https://locale.%s", baseDomain),
    ROLES_URL = string.format("https://users.%s", baseDomain),
    CATALOG_URL = string.format("https://catalog.%s", baseDomain),
    CREATE_URL = string.format("https://create.%s", baseDomain),
    DEVELOP_URL = string.format("https://develop.%s", baseDomain)
}

setmetatable(tbl1, {
    __newindex = function(_, _, _) end,
    __index = function(_, arg1)
        return tbl2[arg1]
    end
})

return tbl1
