-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local platform = game:GetService("UserInputService"):GetPlatform()
local FStringLuaAppEphemeralCounterPrefix = require(AuthCommonParent.SharedFlags).FStringLuaAppEphemeralCounterPrefix

return function(counterName, amount)
    pcall(function()
        assert(type(counterName) == "string", "Expected counterName to be a string")

        counterName = counterName or ""
        amount = amount or 1

        if platform == Enum.Platform.Android then
            counterName = "Android-" .. tostring(counterName)
        elseif platform == Enum.Platform.IOS then
            counterName = "iOS-" .. tostring(counterName)
        elseif platform == Enum.Platform.Windows then
            counterName = "Win32-" .. tostring(counterName)
        elseif platform == Enum.Platform.UWP then
            counterName = "UWP-" .. tostring(counterName)
        elseif platform == Enum.Platform.OSX then
            counterName = "Mac-" .. tostring(counterName)
        elseif FStringLuaAppEphemeralCounterPrefix ~= "" then
            counterName = FStringLuaAppEphemeralCounterPrefix .. tostring(counterName)
        end

        RbxAnalyticsService:ReportCounter(counterName, amount)
    end)
end
