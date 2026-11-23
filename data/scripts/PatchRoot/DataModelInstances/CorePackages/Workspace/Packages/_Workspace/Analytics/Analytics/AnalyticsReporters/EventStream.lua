-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:10:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AnalyticsParent = script:FindFirstAncestor("Analytics").Parent
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
end or require(script.Parent.Parent.getPlatformTarget)

local module = ({})
module.__index = module

function module.new(_reporter)
    local str1 = type(_reporter)
    assert(str1 == "table" or str1 == "userdata", "Unexpected value for reportingService")

    local tbl1 = { _reporter = _reporter, _isEnabled = true }

    setmetatable(tbl1, module)

    return tbl1
end

function module:setEnabled(_isEnabled: boolean)
    assert(type(_isEnabled) == "boolean", "Expected isEnabled to be a boolean")
    self._isEnabled = _isEnabled
end

function module:setRBXEvent(str1: string, str2: string, tbl1)
    local platformTarget = getPlatformTarget()
    tbl1 = tbl1 or {}

    assert(type(str1) == "string", "Expected eventContext to be a string")
    assert(type(str2) == "string", "Expected eventName to be a string")
    assert(type(tbl1) == "table", "Expected additionalArgs to be a table")
    assert(self._isEnabled, "This reporting service is disabled")

    self._reporter:SetRBXEvent(platformTarget, str1, str2, tbl1)
end

function module:setRBXEventStream(str1: string, str2: string, tbl1)
    local platformTarget = getPlatformTarget()
    tbl1 = tbl1 or {}

    assert(type(str1) == "string", "Expected eventContext to be a string")
    assert(type(str2) == "string", "Expected eventName to be a string")
    assert(type(tbl1) == "table", "Expected additionalArgs to be a table")
    assert(self._isEnabled, "This reporting service is disabled")

    self._reporter:SetRBXEventStream(platformTarget, str1, str2, tbl1)
end

function module:releaseRBXEventStream()
    assert(self._isEnabled, "This reporting service is disabled")

    self._reporter:ReleaseRBXEventStream(getPlatformTarget())
end

function module:sendEventDeferred(str1: string, str2: string, tbl1)
    local platformTarget = getPlatformTarget()
    tbl1 = tbl1 or {}

    assert(type(str1) == "string", "Expected eventContext to be a string")
    assert(type(str2) == "string", "Expected eventName to be a string")
    assert(type(tbl1) == "table", "Expected additionalArgs to be a table")
    assert(self._isEnabled, "This reporting service is disabled")

    self._reporter:SendEventDeferred(platformTarget, str1, str2, tbl1)
end

function module:sendEventImmediately(str1: string, str2: string, tbl1)
    local platformTarget = getPlatformTarget()
    tbl1 = tbl1 or {}

    assert(type(str1) == "string", "Expected eventContext to be a string")
    assert(type(str2) == "string", "Expected eventName to be a string")
    assert(type(tbl1) == "table", "Expected additionalArgs to be a table")
    assert(self._isEnabled, "This reporting service is disabled")

    self._reporter:SendEventImmediately(platformTarget, str1, str2, tbl1)
end

function module:updateHeartbeatObject(tbl1)
    tbl1 = tbl1 or {}

    assert(type(tbl1) == "table", "Expected additionalArgs to be a table")
    assert(self._isEnabled, "This reporting service is disabled")

    self._reporter:UpdateHeartbeatObject(tbl1)
end

return module
