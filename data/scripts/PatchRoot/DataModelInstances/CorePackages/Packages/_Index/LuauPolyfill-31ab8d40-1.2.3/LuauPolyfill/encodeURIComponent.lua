-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local scriptParentParent = script.Parent.Parent

local charCodeAt = require(scriptParentParent.String).charCodeAt
local Error = require(script.Parent.Error)

local function encodeURIComponent(input: string)
    local var1 = utf8.len(input)
    if var1 == 0 or var1 == nil then
        return ""
    end

    local var2 = charCodeAt(input, 1)
    if var1 == 1 then
        if var2 == 55296 then
            error(Error.new("URI malformed"))
        end
        if var2 == 57343 then
            error(Error.new("URI malformed"))
        end
    end
    if var2 >= 56320 and var2 < 57343 then
        error(Error.new("URI malformed"))
    end
    return (HttpService:UrlEncode(input):gsub("%%2D", "-"):gsub("%%5F", "_"):gsub("%%2E", "."):gsub("%%21", "!"):gsub("%%7E", "~"):gsub(
        "%%2A",
        "*"
    ):gsub(
        "%%27",
        "'"
    ):gsub(
        "%%28",
        "("
    ):gsub(
        "%%29",
        ")"
    ))
end
return encodeURIComponent
