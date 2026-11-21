-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:30:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local User = require(AuthCommon.Thunks.User)

local default = require(AuthCommonParent.LinkingProtocol).LinkingProtocol.default

local PreAuthDeepLinkMap = require(script.Parent.PreAuthDeepLinkMap)

local function parseQueryParams(str1: string)
    local result = {}
    local _, var1 = string.find(str1, "?")

    if not var1 then
        return result
    end

    local str2 = string.sub(str1, var1 + 1)

    for value in string.gmatch(str2, "[^&]+") do
        local var2, var3 = string.match(value, "([^=]+)=?(.*)")
        if var2 then
            result[string.lower(var2)] = var3 or ""
        end
    end

    return result
end

local function matchesPattern(regexPattern: string, str1: string): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return string.match(str1, regexPattern) ~= nil
end

local function userIsAuthenticated(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return User.fromLocalStorage().userId ~= -1
end

local function isPreauthDeeplink(str1: string)
    if not str1 or str1 == "" then
        return false
    end

    local str2 = string.lower(str1)

    for _, value in ipairs(PreAuthDeepLinkMap) do
        if matchesPattern(value.regexPattern, str2) then
            return true
        end
    end

    return false
end

local function firePreauthDeeplink(str1: string, tbl1)
    if not str1 or str1 == "" then
        return nil
    end

    local str2 = string.lower(str1)
    local bool1 = not not userIsAuthenticated()

    for _, value in ipairs(PreAuthDeepLinkMap) do
        if not matchesPattern(value.regexPattern, str2) then
            continue
        end
        if value.preauthOnly and bool1 then
            return nil
        end

        local tbl2 = parseQueryParams(str1)
        return value.handler(tbl2, tbl1)
    end

    return nil
end

local function registerPatterns()
    for _, value in ipairs(PreAuthDeepLinkMap) do
        local var1 = value.regexPattern:gsub("%%", "\\")
        default:registerURL(var1)
    end
end

if require(AuthCommon.Flags.FFlagEnablePreAuthDeepLinkHandler) then
    registerPatterns()
end

return { isPreauthDeeplink = isPreauthDeeplink, firePreauthDeeplink = firePreauthDeeplink }
