-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:50:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Cryo = require(scriptParentParent.Cryo)
local StringUtilities = require(scriptParentParent.StringUtilities)
local StringTrim = StringUtilities.StringTrim
local StringSplit = StringUtilities.StringSplit
local encodeURIComponent = require(script.Parent.encodeURIComponent)
local UrlBase = require(script.Parent.UrlBase)

local GameUrlPatterns = require(script.Parent.UrlPatterns.GameUrlPatterns)
local UserUrlPatterns = require(script.Parent.UrlPatterns.UserUrlPatterns)
local StaticUrlPatterns = require(script.Parent.UrlPatterns.StaticUrlPatterns)
local CatalogUrlPatterns = require(script.Parent.UrlPatterns.CatalogUrlPatterns)
local EconomyUrlPatterns = require(script.Parent.UrlPatterns.EconomyUrlPatterns)
local ShareLinksUrlPatterns = require(script.Parent.UrlPatterns.ShareLinksUrlPatterns)
local UserModerationPatterns = require(script.Parent.UrlPatterns.UserModerationPatterns)
local AccountInformationPatterns = require(script.Parent.UrlPatterns.AccountInformationPatterns)
local VirtualEventsUrlPatterns = require(script.Parent.UrlPatterns.VirtualEventsUrlPatterns)
local PlatformAuthPatterns = require(script.Parent.UrlPatterns.PlatformAuthPatterns)

local module = {}

local function splitAndTrim(arg1, arg2, arg3)
    local var1 = StringSplit(arg1, arg2, arg3)
    local var2 = Cryo.List.map(var1, function(arg4)
        return StringTrim(arg4)
    end)
    return (Cryo.List.filter(var2, function(arg4): boolean
        return #arg4 > 0
    end))
end

local function validateValueType(arg1)
    local str1 = type(arg1)
    if str1 == "string" then
        return true
    elseif str1 == "number" then
        return true
    end

    if str1 ~= "table" then
        return false
    end

    for _, value in ipairs(arg1) do
        local str2 = type(value)
        if str2 ~= "string" and str2 ~= "number" then
            return false
        end
    end
    return true
end

local function assertPlaceholder(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if string.sub(arg1, 1, 1) == "{" then
        assert(string.sub(arg1, -1, -1) == "}", "invalid pattern: placeholder items should end with `}`")
    end
end

local function assertElementIsValid(arg1, bool1: boolean)
    assert(type(arg1) == "table", "invalid pattern: elements should all be tables")
    if bool1 then
        assert(type(arg1.name) == "string", "invalid pattern: element name should be a string")
        assert(#arg1.name > 0, "invalid pattern: element name should not be empty")
    end

    local value = arg1.value
    local bool2 = type(value) == "string" or type(arg1.value) == "number"
    assert(bool2, "invalid pattern: element value should be a string or number")

    if type(arg1.value) == "string" then
        assertPlaceholder(arg1.value)
    end
    if arg1.optional ~= nil then
        assert(type(arg1.optional) == "boolean", "invalid pattern: element optional should be a boolean")
    end
    if arg1.default ~= nil then
        assert(
            validateValueType(arg1.default),
            "invalid pattern: element default should be a string, number, or a table of strings and numbers only"
        )
    end

    if arg1.collect ~= nil then
        assert(
            arg1.collect == "multi" or arg1.collect == "csv",
            "invalid pattern: element optional should be one of `multi`, `csv`"
        )
    end
end

local function assertPatternIsValid(tbl1: {base: any, hash: any, path: any, query: any})
    assert(type(tbl1.base) == "string", "invalid pattern: base should be a string")
    assert(#tbl1.base > 0, "invalid pattern: base should not be empty")
    assert(type(tbl1.path) == "table", "invalid pattern: path should be a table")
    for _, value in ipairs(tbl1.path) do
        assertElementIsValid(value, false)
    end
    if tbl1.query ~= nil then
        assert(type(tbl1.query) == "table", "invalid pattern: query should be a table")
    end
    if type(tbl1.query) == "table" then
        for _, value in ipairs(tbl1.query) do
            assertElementIsValid(value, true)
        end
    end
    if tbl1.hash ~= nil then
        assert(type(tbl1.hash) == "table", "invalid pattern: hash should be a table")
    end
end

local function buildElementsFromString(arg1, arg2) -- Luacid: unused: defined but never referenced
    arg1 = splitAndTrim(arg1, if arg2 then "&" else "/")
    return (Cryo.List.map(arg1, function(arg3)
        local var1 = StringTrim(arg3)
        local var2 = nil
        local var3 = nil
        local var4, var5

        if arg2 then
            local var6 = StringSplit(var1, "=", 2)
            var4 = StringTrim(var6[1])
            var1 = var6[2]
            if string.sub(var4, 1, 1) == "{" then
                local var7 = StringTrim(var4, "{}")
                local var8 = StringSplit(var7, "|", 2)[1]
                if var1 == nil then
                    var1 = var6[1]
                end
                var4 = StringTrim(var8)
            end

            var5 = "multi"
        else
            var4 = nil
            var5 = nil
        end

        if var1 ~= nil and string.find(var1, "^{.*}$") then
            local var6 = StringTrim(var1, "{}")
            local var7 = StringSplit(var6, "|", 2)
            local var8 = StringTrim(var7[1])
            if #var7 > 1 then
                var2 = true
                if #var7[2] > 1 then
                    var3 = var7[2]
                end
            end
            var1 = "{" .. var8 .. "}"
        end
        return { name = var4, value = var1, optional = var2, default = var3, collect = var5 }
    end))
end

local function buildQueryStringFromTable(tbl1): string
    local tbl2 = {}
    for k, value in pairs(tbl1) do
        table.insert(tbl2, k .. "=" .. value)
    end
    return table.concat(tbl2, "&")
end

local function simplifyPattern(arg1)
    local base = arg1.base
    local path = arg1.path
    local query = arg1.query
    local hash = arg1.hash
    if base ~= nil and UrlBase[string.upper(base)] ~= nil then
        base = UrlBase[string.upper(base)]
    end
    if type(path) == "string" then
        local var1 = splitAndTrim(path, "/")
        local bool1 = false

        path = Cryo.List.map(var1, function(arg2)
            local var2 = StringTrim(arg2)
            local var3 = nil
            local var4 = nil
            local var5, var6

            if bool1 then
                local var7 = StringSplit(var2, "=", 2)
                var5 = StringTrim(var7[1])
                var2 = var7[2]
                if string.sub(var5, 1, 1) == "{" then
                    local var8 = StringTrim(var5, "{}")
                    local var9 = StringSplit(var8, "|", 2)[1]
                    if var2 == nil then
                        var2 = var7[1]
                    end
                    var5 = StringTrim(var9)
                end

                var6 = "multi"
            else
                var5 = nil
                var6 = nil
            end

            if var2 ~= nil and string.find(var2, "^{.*}$") then
                local var7 = StringTrim(var2, "{}")
                local var8 = StringSplit(var7, "|", 2)
                local var9 = StringTrim(var8[1])
                if #var8 > 1 then
                    var3 = true
                    if #var8[2] > 1 then
                        var4 = var8[2]
                    end
                end
                var2 = "{" .. var9 .. "}"
            end
            return { name = var5, value = var2, optional = var3, default = var4, collect = var6 }
        end)
    end
    if type(query) == "table" and query[1] == nil then
        query = buildQueryStringFromTable(query)
    end
    if type(query) == "string" then
        local var1 = splitAndTrim(query, "&")
        local bool1 = true

        query = Cryo.List.map(var1, function(arg2)
            local var2 = StringTrim(arg2)
            local var3 = nil
            local var4 = nil
            local var5, var6

            if bool1 then
                local var7 = StringSplit(var2, "=", 2)
                var5 = StringTrim(var7[1])
                var2 = var7[2]
                if string.sub(var5, 1, 1) == "{" then
                    local var8 = StringTrim(var5, "{}")
                    local var9 = StringSplit(var8, "|", 2)[1]
                    if var2 == nil then
                        var2 = var7[1]
                    end
                    var5 = StringTrim(var9)
                end

                var6 = "multi"
            else
                var5 = nil
                var6 = nil
            end

            if var2 ~= nil and string.find(var2, "^{.*}$") then
                local var7 = StringTrim(var2, "{}")
                local var8 = StringSplit(var7, "|", 2)
                local var9 = StringTrim(var8[1])
                if #var8 > 1 then
                    var3 = true
                    if #var8[2] > 1 then
                        var4 = var8[2]
                    end
                end
                var2 = "{" .. var9 .. "}"
            end
            return { name = var5, value = var2, optional = var3, default = var4, collect = var6 }
        end)
    end
    if type(hash) == "string" then
        local var1 = splitAndTrim(hash, "/")
        local bool1 = false

        hash = Cryo.List.map(var1, function(arg2)
            local var2 = StringTrim(arg2)
            local var3 = nil
            local var4 = nil
            local var5, var6

            if bool1 then
                local var7 = StringSplit(var2, "=", 2)
                var5 = StringTrim(var7[1])
                var2 = var7[2]
                if string.sub(var5, 1, 1) == "{" then
                    local var8 = StringTrim(var5, "{}")
                    local var9 = StringSplit(var8, "|", 2)[1]
                    if var2 == nil then
                        var2 = var7[1]
                    end
                    var5 = StringTrim(var9)
                end

                var6 = "multi"
            else
                var5 = nil
                var6 = nil
            end

            if var2 ~= nil and string.find(var2, "^{.*}$") then
                local var7 = StringTrim(var2, "{}")
                local var8 = StringSplit(var7, "|", 2)
                local var9 = StringTrim(var8[1])
                if #var8 > 1 then
                    var3 = true
                    if #var8[2] > 1 then
                        var4 = var8[2]
                    end
                end
                var2 = "{" .. var9 .. "}"
            end
            return { name = var5, value = var2, optional = var3, default = var4, collect = var6 }
        end)
    end
    return { base = base, path = path, query = query, hash = hash }
end

local function concatValues(arg1, bool1: boolean): string
    arg1 = Cryo.List.filter(arg1, function(arg2): boolean
        if bool1 then
            return #splitAndTrim(arg2, "=") > 1
        end

        return #arg2 > 0
    end)

    return table.concat(arg1, if bool1 then "&" else "/")
end

local function resolveElement(arg1, arg2, bool1: boolean): string
    arg2 = arg2 == nil and {} or arg2

    local value = arg1.value
    local value2

    if type(value) == "string" and string.sub(arg1.value, 1, 1) == "{" then
        local var1 = arg2[string.sub(arg1.value, 2, -2)]
        if var1 == nil then
            var1 = arg1.default
        end
        if not arg1.optional then
            assert(var1 ~= nil, "UrlBuilder: missing parameter: `" .. arg1.value .. "`")
        end
        value2 = var1 == nil and {} or var1

        assert(
            validateValueType(value2),
            "UrlBuilder: invalid parameter: `" .. arg1.value .. "`, should be a string, number, or a table of strings and numbers only"
        )
    else
        value2 = arg1.value
    end
    local var1 = type(value2) ~= "table" and { value2 } or value2

    local var2 = Cryo.List.map(var1, function(arg3)
        return encodeURIComponent(tostring(arg3))
    end)
    if bool1 then
        local var3 = arg1.collect == "csv" and { table.concat(var2, "%2C") } or var2

        var2 = Cryo.List.map(var3, function(arg3)
            return encodeURIComponent(arg1.name) .. "=" .. arg3
        end)
    end
    return concatValues(var2, bool1)
end

local function resolveElementList(arg1, arg2, bool1: boolean): string
    local var1 = Cryo.List.map(arg1 or {}, function(arg3): string
        return resolveElement(arg3, arg2, bool1)
    end)
    return concatValues(var1, bool1)
end

function module.new(arg1)
    local tbl1 = simplifyPattern(arg1)
    assertPatternIsValid(tbl1)
    return function(arg2, arg3)
        local var1 = StringTrim(tbl1.base, "/", { right = true })
        local str1 = resolveElementList(tbl1.path, arg2, false)
        if #str1 > 0 then
            var1 ..= "/" .. str1
        end

        if string.match(var1, "[^/]/[^/]") == nil then
            var1 ..= "/"
        end
        local str2 = resolveElementList(tbl1.query, arg2, true)
        if #str2 > 0 then
            var1 ..= "?" .. str2
        end
        local str3 = resolveElementList(tbl1.hash, arg2, false)
        if #str3 > 0 then
            var1 ..= "#" .. str3
        end

        if not arg3 then
            return var1
        end

        if var1 ~= arg3 then
            warn("UrlBuilder: unexpected output for pattern:")
            warn("UrlBuilder: expected `" .. arg3 .. "`")
            warn("UrlBuilder: actual `" .. var1 .. "`")
        end
        return arg3
    end
end

function module.fromString(arg1)
    local var1 = StringSplit(arg1, ":", 2)
    local var2 = #var1 < 2 and { "", var1[1] } or var1

    local var3 = var2[1]
    local var4 = StringSplit(var2[2], "%#", 2)
    local var5 = var4[2] or ""
    local var6 = StringSplit(var4[1], "%?", 2)
    local var7 = var6[1] or ""
    local var8 = var6[2] or ""

    if string.sub(var7, 1, 2) == "//" then
        local var9 = StringSplit(string.sub(var7, 3), "/", 2)
        var3 ..= "://" .. var9[1]
        var7 = var9[2] or "/"
    end
    return module.new({ base = StringTrim(var3), path = StringTrim(var7), query = StringTrim(var8), hash = StringTrim(var5) })
end

function module.addQueryString(arg1, arg2)
    local var1 = StringTrim(arg1)
    local var2 = string.find(var1, "%?")
    if var2 == nil then
        var1 ..= "?"
    elseif var2 < #var1 then
        var1 ..= "&"
    end
    local var3 = Cryo.Dictionary.keys(arg2)
    local var4 = Cryo.List.map(var3, function(arg3)
        return "{" .. arg3 .. "}"
    end)
    local var5 = var1 .. table.concat(var4, "&")
    return module.fromString(var5)(arg2)
end

module.game = GameUrlPatterns(module)
module.user = UserUrlPatterns(module)
module.catalog = CatalogUrlPatterns(module)
module.static = StaticUrlPatterns(module)
module.usermoderation = UserModerationPatterns(module)
module.accountinformation = AccountInformationPatterns(module)
module.sharelinks = ShareLinksUrlPatterns(module)
module.economy = EconomyUrlPatterns(module)
module.virtualevents = VirtualEventsUrlPatterns(module)
module.PlatformAuth = PlatformAuthPatterns(module)

return module
