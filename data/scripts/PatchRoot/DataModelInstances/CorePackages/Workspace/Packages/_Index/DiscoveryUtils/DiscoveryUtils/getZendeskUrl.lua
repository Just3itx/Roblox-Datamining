-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:11:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    ["zh-cn"] = "zh-cn",
    zh_cn = "zh-cn",
    ["zh-cjv"] = "zh-cn",
    zh_cjv = "zh-cn",
    ["zh-hans"] = "zh-cn",
    zh_hans = "zh-cn",
    ["zh-tw"] = "zh-tw",
    zh_tw = "zh-tw",
    ["zh-hant"] = "zh-tw",
    zh_hant = "zh-tw",
    ["en-us"] = "en-us",
    en_us = "en-us",
    en = "en-us",
    ["en-gb"] = "en-gb",
    en_gb = "en-gb",
    ["fr-ca"] = "fr-ca",
    fr_ca = "fr-ca",
    nb = "no",
    ["nb-no"] = "no",
    nb_no = "no"
}

local function func1(str1: string)
    if tbl1[str1] then
        return tbl1[str1]
    end

    local tbl2 = {}
    for value in str1:gmatch("([^%-_]+)") do
        table.insert(tbl2, value)
    end

    return if tbl2[1] then tbl2[1] else "en-us"
end

local function func2(str1: string?): boolean | string? -- Luacid: Inlined by compiler; 1 call site recovered
    return str1 and string.match(str1, "^[%w%-_]+$") ~= nil
end

local function func3(str1: string?): boolean | string? -- Luacid: Inlined by compiler; 1 call site recovered
    return str1 and string.match(str1, "^[a-zA-Z0-9]+$") ~= nil
end

local function getZendeskUrl(str1: string?, str2: string?, str3: string?): string
    return `{str1 or "https://en.help.roblox.com/hc"}/{if func2(str2) then func1(str2) else "en-us"}/{if func3(str3) then `articles/{str3}` else ""}`
end

return getZendeskUrl
