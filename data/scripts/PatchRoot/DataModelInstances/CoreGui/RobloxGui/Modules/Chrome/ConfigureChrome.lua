-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:40:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CorePackages = game:GetService("CorePackages")

if not require(CorePackages.Workspace.Packages.Chrome).Enabled() then
    return nil
end

local Service = require(Chrome.Service)
local Constants = require(Chrome.Integrations.Party.Constants)
local isConnectUnibarEnabled = require(Chrome.Integrations.Connect.isConnectUnibarEnabled)

local isInExperienceUIVREnabled = require(CorePackages.Workspace.Packages.SharedExperimentDefinition).isInExperienceUIVREnabled
local ConfigureShortcuts = require(Chrome.ChromeShared.Shortcuts.ConfigureShortcuts)
local buildMenuOrder = require(Chrome.ChromeShared.Unibar.buildMenuOrder)

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local GetFFlagDebugEnableUnibarDummyIntegrations = SharedFlags.GetFFlagDebugEnableUnibarDummyIntegrations
local FFlagEnableConsoleExpControls = SharedFlags.FFlagEnableConsoleExpControls
local FFlagAppNavMyStatsTab = SharedFlags.FFlagAppNavMyStatsTab

local isSpatial = require(CorePackages.Workspace.Packages.AppCommonLib).isSpatial

local function func1() -- Luacid: Inlined by compiler; 1 call site recovered
    ConfigureShortcuts()
end

local function configureUnibar()
    local menuOrder = buildMenuOrder()

    local tbl1 = { "nine_dot", "chat", "toggle_mic_mute" }
    table.insert(tbl1, 3, "join_voice")

    if GetFFlagDebugEnableUnibarDummyIntegrations() then
        table.insert(tbl1, "dummy_window")
        table.insert(tbl1, "dummy_window_2")
    end

    if isConnectUnibarEnabled() then
        table.insert(tbl1, "party_entrypoint")
    end

    local var1 = table.find(tbl1, "toggle_mic_mute")
    if var1 then
        table.insert(tbl1, var1, Constants.TOGGLE_MIC_INTEGRATION_ID)
    end

    if FFlagAppNavMyStatsTab then
        table.insert(tbl1, "assistant_build")
    end

    if isInExperienceUIVREnabled and isSpatial() then
        Service:configureMenu({ { "vr_toggle_button", "vr_safety_bubble" }, tbl1 })
    else
        Service:configureMenu({ tbl1 })
    end

    Service:configureSubMenu("nine_dot", menuOrder)
end

local function initializeIntegrations()
    require(Chrome.Integrations)
end

initializeIntegrations()

if FFlagEnableConsoleExpControls then
    func1()
end

configureUnibar()

return nil
