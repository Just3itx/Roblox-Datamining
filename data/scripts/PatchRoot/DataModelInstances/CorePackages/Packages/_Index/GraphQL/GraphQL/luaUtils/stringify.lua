-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local str1 = HttpService:JSONEncode((require(script.Parent.null)))

local function stringify(input)
    return (HttpService:JSONEncode(input):gsub(str1, "null"))
end

return stringify
