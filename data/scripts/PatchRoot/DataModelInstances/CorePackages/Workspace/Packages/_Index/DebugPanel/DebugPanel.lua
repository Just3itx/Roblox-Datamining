-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AnalyticsFeedNoopShim = require(script.AnalyticsFeedNoopShim)

local function NoopComponent()
    return nil
end

local function func1() end

local function noopRegisterSection(_)
    return func1
end

local function noopRegisterSections(_)
    return func1
end

local function noopGetRootSignal()
    return {
        title = "root",
        children = {},
        leafId = nil,
        component = nil,
        order = 0,
        defaultCollapsed = nil
    }
end

if _G.ENVIRONMENT == "PRODUCTION" or script:FindFirstChild("DevOnly") == nil then
    return {
        ["jest.config"] = script["jest.config"],
        DebugPanel = NoopComponent,
        registerSection = noopRegisterSection,
        registerSections = noopRegisterSections,
        getRootSignal = noopGetRootSignal,
        DebugPanelWindow = NoopComponent,
        DebugPanelSection = NoopComponent,
        AnalyticsFeed = AnalyticsFeedNoopShim
    }
end

local DevOnly = script.DevOnly
local DebugPanelSectionRegistry = require(DevOnly.DebugPanelSectionRegistry)
local AnalyticsFeed = require(DevOnly.AnalyticsFeed)

return {
    ["jest.config"] = script["jest.config"],
    DebugPanel = require(DevOnly.DebugPanel),
    registerSection = DebugPanelSectionRegistry.registerSection,
    registerSections = DebugPanelSectionRegistry.registerSections,
    getRootSignal = DebugPanelSectionRegistry.getRootSignal,
    DebugPanelWindow = require(DevOnly.DebugPanelWindow),
    DebugPanelSection = require(DevOnly.DebugPanelSection),
    AnalyticsFeed = AnalyticsFeed
}
