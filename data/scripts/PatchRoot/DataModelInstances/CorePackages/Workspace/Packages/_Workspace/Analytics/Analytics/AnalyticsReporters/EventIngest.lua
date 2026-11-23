-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Analytics = script:FindFirstAncestor("Analytics")
local AnalyticsParent = Analytics.Parent

local UserInputService = game:GetService("UserInputService")

local getPlatformTarget = not require(AnalyticsParent.SharedFlags).GetFFlagShareGetPlatformTargetImpl() and function(): string -- name: getPlatformTarget
    local str1 = "unknownLua"
    local none = Enum.Platform.None

    pcall(function()
        none = UserInputService:GetPlatform()
    end)

    local windows = Enum.Platform.Windows
    local bool1

    if none == windows then
        bool1 = true
    else
        local osx = Enum.Platform.OSX
        bool1 = none == osx
    end
    local ios = Enum.Platform.IOS
    local bool2

    if none == ios then
        bool2 = true
    else
        local android = Enum.Platform.Android
        bool2 = none == android
    end

    if not bool2 then
        local uwp = Enum.Platform.UWP
        bool2 = none == uwp
    end
    local xBox360 = Enum.Platform.XBox360
    local engineFeature

    if none == xBox360 then
        engineFeature = true
    else
        local xBoxOne = Enum.Platform.XBoxOne
        engineFeature = none == xBoxOne
    end

    if not engineFeature then
        local ps3 = Enum.Platform.PS3

        if none == ps3 then
            engineFeature = true
        else
            local ps4 = Enum.Platform.PS4

            if none == ps4 then
                engineFeature = true
            else
                engineFeature = game:GetEngineFeature("PlatformEnumPS5")

                if engineFeature then
                    local ps5 = Enum.Platform.PS5
                    engineFeature = none == ps5
                end
            end
        end
    end

    if not engineFeature then
        local wiiU = Enum.Platform.WiiU
        engineFeature = none == wiiU
    end

    return if bool1 then "client" elseif bool2 then "mobile" elseif engineFeature then "console" else str1 .. tostring(none)
end or require(Analytics.getPlatformTarget)

local module = {}
module.__index = module

function module.new(_eventIngest)
    local str1 = type(_eventIngest)
    assert(str1 == "table" or str1 == "userdata", "Unexpected value for eventIngestService")

    local tbl1 = { _eventIngest = _eventIngest }

    setmetatable(tbl1, module)

    return tbl1
end

function module:setRBXEvent(arg1, arg2, arg3)
    local platformTarget = getPlatformTarget()
    arg3 = arg3 or {}

    assert(type(arg1) == "string", "Expected eventContext to be a string")
    assert(type(arg2) == "string", "Expected eventName to be a string")
    assert(type(arg3) == "table", "Expected additionalArgs to be a table")

    self._eventIngest:SetRBXEvent(platformTarget, arg1, arg2, arg3)
end

function module:setRBXEventStream(arg1, arg2, arg3)
    local platformTarget = getPlatformTarget()
    arg3 = arg3 or {}

    assert(type(arg1) == "string", "Expected eventContext to be a string")
    assert(type(arg2) == "string", "Expected eventName to be a string")
    assert(type(arg3) == "table", "Expected additionalArgs to be a table")

    self._eventIngest:SetRBXEventStream(platformTarget, arg1, arg2, arg3)
end

function module:sendEventDeferred(arg1, arg2, arg3)
    local platformTarget = getPlatformTarget()
    arg3 = arg3 or {}

    assert(type(arg1) == "string", "Expected eventContext to be a string")
    assert(type(arg2) == "string", "Expected eventName to be a string")
    assert(type(arg3) == "table", "Expected additionalArgs to be a table")

    self._eventIngest:SendEventDeferred(platformTarget, arg1, arg2, arg3)
end

function module:sendEventImmediately(arg1, arg2, arg3)
    local platformTarget = getPlatformTarget()
    arg3 = arg3 or {}

    assert(type(arg1) == "string", "Expected eventContext to be a string")
    assert(type(arg2) == "string", "Expected eventName to be a string")
    assert(type(arg3) == "table", "Expected additionalArgs to be a table")

    self._eventIngest:SendEventImmediately(platformTarget, arg1, arg2, arg3)
end

return module
