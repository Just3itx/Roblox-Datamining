-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local module = {}

function module.enc(input): string
    return HttpService:JSONEncode(input)
end

function module.dec(input: string)
    return HttpService:JSONDecode(input)
end

return module
