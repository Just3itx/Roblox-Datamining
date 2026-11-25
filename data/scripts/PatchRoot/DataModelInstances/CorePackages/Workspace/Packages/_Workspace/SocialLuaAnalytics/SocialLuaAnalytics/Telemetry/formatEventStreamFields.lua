-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local SocialLuaAnalyticsParent = script:FindFirstAncestor("SocialLuaAnalytics").Parent
local Cryo = require(SocialLuaAnalyticsParent.Cryo)

local function formatEventStreamFields(arg1)
    return Cryo.Dictionary.map(arg1, function(arg2, arg3)
        if type(arg2) ~= "table" then
            return tostring(arg2), arg3
        end

        local success, result = pcall(function(): string
            return HttpService:JSONEncode(arg2)
        end)
        if success then
            return result, arg3
        end

        return "", arg3
    end)
end

return formatEventStreamFields
