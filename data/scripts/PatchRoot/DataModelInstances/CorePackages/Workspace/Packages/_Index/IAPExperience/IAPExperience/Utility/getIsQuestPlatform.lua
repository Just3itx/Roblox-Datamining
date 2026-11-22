-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

return function(): boolean
    return string.find(HttpService:GetUserAgent(), "OculusQuest3Store") ~= nil
end
