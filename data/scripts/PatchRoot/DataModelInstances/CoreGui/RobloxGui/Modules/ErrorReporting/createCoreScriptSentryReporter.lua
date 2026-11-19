-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStorageService = game:GetService("AppStorageService")
local CorePackages = game:GetService("CorePackages")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local SentryReporter = require(CorePackages.Workspace.Packages.ErrorReporters).SentryReporter

local FFlagCoreScriptSentryReportDeviceContext = require(script.Parent.Parent.Flags.FFlagCoreScriptSentryReportDeviceContext)
local SystemInfoProtocol = if FFlagCoreScriptSentryReportDeviceContext then require(CorePackages.Workspace.Packages.SystemInfoProtocol).SystemInfoProtocol else nil
local FFlagCoreScriptSentrySetUser = require(script.Parent.Parent.Flags.FFlagCoreScriptSentrySetUser)
local FFlagCoreScriptSentryReportTags = require(script.Parent.Parent.Flags.FFlagCoreScriptSentryReportTags)

local function getDeviceAttributes(arg1)
    local deviceAttributes = {}

    local success, result = pcall(function()
        return SystemInfoProtocol.default:getSystemInfo(SystemInfoProtocol.ALL_INFO_NAMES)
    end)
    if success and typeof(result) == "table" then
        for value, value2 in result do
            deviceAttributes[value] = value2
        end
    end

    local success2, result2, result2_2 = pcall(function()
        return arg1:GetControlAndVariantRolloutFlags()
    end)
    if success2 then
        if result2 ~= nil and result2 ~= "" then
            deviceAttributes.RolloutFlagsInControl = result2
        end
        if result2_2 ~= nil and result2_2 ~= "" then
            deviceAttributes.RolloutFlagsInVariant = result2_2
        end
    end

    return deviceAttributes
end

local function getSentryUserId(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(function()
        return arg1:GetItem("AppInstallationId")
    end)
    if success and result ~= nil and result ~= "" then
        return result
    end
    return HttpService:GenerateGUID(false)
end

local tbl1 = {
    client_platform = "Platform",
    place_id = "PlaceId",
    app_version = "LocalVersion",
    roblox_channel = "RobloxChannel"
}

local function getTags(attributes)
    local tags = ({})
    for value, value2 in tbl1 do
        local var1 = attributes[value2]
        if var1 ~= nil then
            tags[value] = tostring(var1)
        end
    end
    return tags
end

local function createCoreScriptSentryReporter(tbl2)
    local var1 = tbl2.runService or RunService
    local var2 = tbl2.appStorageService or AppStorageService
    local isStudio = false

    local function processErrorReport(arg1)
        local var3 = tbl2.processErrorReportMethod(arg1)
        var3:addCustomMetadata({ CoreScripts = var3.attributes })

        if FFlagCoreScriptSentryReportTags then
            var3.tags = getTags(var3.attributes)
        end
        if FFlagCoreScriptSentryReportDeviceContext then
            var3:addAttributes((getDeviceAttributes(var1)))
        end
        return var3
    end

    local success, result = pcall(function()
        isStudio = var1:IsStudio()

        local sentryReporter = SentryReporter.new({
            httpService = HttpService,
            processErrorReportMethod = processErrorReport,
            dsn = tbl2.dsn,
            environment = if isStudio then "development" else "production",
            release = var1:GetCoreScriptVersion() or "unknown",
            disableDevelopmentLogging = true
        })

        if FFlagCoreScriptSentrySetUser and sentryReporter ~= nil then
            sentryReporter:setUser({ id = getSentryUserId(var2) })
        end

        return sentryReporter
    end)

    if success then
        return result
    end

    if isStudio then
        warn(("[CoreScriptSentryReporter] Failed to initialize: %s"):format(tostring(result)))
    end
    return nil
end

return createCoreScriptSentryReporter
