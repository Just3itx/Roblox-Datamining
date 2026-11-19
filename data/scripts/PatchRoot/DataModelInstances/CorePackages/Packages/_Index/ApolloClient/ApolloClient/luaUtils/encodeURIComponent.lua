-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:30:53Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local function encodeURIComponent(input: string)
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
