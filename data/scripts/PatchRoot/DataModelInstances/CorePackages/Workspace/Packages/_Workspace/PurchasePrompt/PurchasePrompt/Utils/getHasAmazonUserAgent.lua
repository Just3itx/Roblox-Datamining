-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

return function()
    return string.find(HttpService:GetUserAgent(), "AmazonAppStore")
end
