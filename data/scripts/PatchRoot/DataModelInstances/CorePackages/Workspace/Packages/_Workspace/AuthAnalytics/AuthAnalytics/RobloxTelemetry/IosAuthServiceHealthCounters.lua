-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local AuthAnalyticsParent = script:FindFirstAncestor("AuthAnalytics").Parent
local default = require(AuthAnalyticsParent.LoggingProtocol).default
local TelemetryConfigs = require(script.Parent.TelemetryConfigs)
local GetFFlagEnableIosAuthServiceLuaIXP = require(AuthAnalyticsParent.SharedFlags).GetFFlagEnableIosAuthServiceLuaIXP

local function isIos(): boolean -- Luacid: Inlined by compiler; 8 call sites recovered
    return UserInputService:GetPlatform() == Enum.Platform.IOS
end

local function majorMinor(robloxVersion: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    if robloxVersion == nil or robloxVersion == "" then
        return nil
    end
    local tbl1 = string.split(robloxVersion, ".")

    if #tbl1 == 0 then
        return nil
    elseif #tbl1 == 1 then
        return tbl1[1]
    end

    return tbl1[1] .. "." .. tbl1[2]
end

local function buildCustomFields(surface: string, credentialType: string?, errorCode: string?, iosAuthServiceEnabled: boolean)
    local tbl1 = {
        source = "lua",
        surface = surface,
        iosAuthServiceEnabled = if iosAuthServiceEnabled then "true" else "false"
    }
    if credentialType ~= nil and credentialType ~= "" then
        tbl1.credentialType = credentialType
    end
    if errorCode ~= nil and errorCode ~= "" then
        tbl1.errorCode = errorCode
    end

    local robloxVersion = majorMinor((RunService:GetRobloxVersion()))
    if robloxVersion ~= nil and robloxVersion ~= "" then
        tbl1.robloxVersion = robloxVersion
    end
    return tbl1
end

local function logCounter(arg1, surface: string, credentialType: string?, errorCode: string?, iosAuthServiceEnabled: boolean) -- Luacid: Inlined by compiler; 7 call sites recovered
    if GetFFlagEnableIosAuthServiceLuaIXP() and isIos() then
        default:logRobloxTelemetryCounter(
            arg1,
            1,
            (buildCustomFields(surface, credentialType, errorCode, iosAuthServiceEnabled))
        )
    end
end
local module = {}

function module.reportLoginSuccess(tbl1)
    logCounter(
        TelemetryConfigs.IosAuthServiceLoginSuccessConfig,
        "login",
        tbl1.credentialType,
        nil,
        tbl1.iosAuthServiceEnabled
    )
end

function module.reportLoginFailure(tbl1)
    logCounter(
        TelemetryConfigs.IosAuthServiceLoginFailureConfig,
        "login",
        tbl1.credentialType,
        tbl1.errorCode,
        tbl1.iosAuthServiceEnabled
    )
end

function module.reportLoginTwoStepRequired(tbl1)
    logCounter(
        TelemetryConfigs.IosAuthServiceLoginTwoStepRequiredConfig,
        "login",
        tbl1.credentialType,
        nil,
        tbl1.iosAuthServiceEnabled
    )
end

function module.reportSignupSuccess(tbl1)
    logCounter(
        TelemetryConfigs.IosAuthServiceSignupSuccessConfig,
        "signup",
        tbl1.credentialType,
        nil,
        tbl1.iosAuthServiceEnabled
    )
end

function module.reportSignupFailure(tbl1)
    logCounter(
        TelemetryConfigs.IosAuthServiceSignupFailureConfig,
        "signup",
        tbl1.credentialType,
        tbl1.errorCode,
        tbl1.iosAuthServiceEnabled
    )
end

function module.reportPasswordSaveSuccess(tbl1)
    logCounter(
        TelemetryConfigs.IosAuthServicePasswordSaveSuccessConfig,
        "passwordSave",
        tbl1.credentialType,
        nil,
        tbl1.iosAuthServiceEnabled
    )
end

function module.reportPasswordSaveFailure(tbl1)
    logCounter(
        TelemetryConfigs.IosAuthServicePasswordSaveFailureConfig,
        "passwordSave",
        tbl1.credentialType,
        tbl1.errorCode,
        tbl1.iosAuthServiceEnabled
    )
end

return module
