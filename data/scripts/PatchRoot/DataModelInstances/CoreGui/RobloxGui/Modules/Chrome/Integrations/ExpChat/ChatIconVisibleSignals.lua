-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local CorePackages = game:GetService("CorePackages")
local Packages = CorePackages.Packages
local Signals = require(Packages.Signals)

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local GetFFlagExpChatGuacChatDisabledReason = SharedFlags.GetFFlagExpChatGuacChatDisabledReason
local FFlagExpChatWindowSyncUnibar = SharedFlags.FFlagExpChatWindowSyncUnibar
local FFlagEnableAEGIS2CommsFAEUpsell = SharedFlags.FFlagEnableAEGIS2CommsFAEUpsell

local bool1 = game:DefineFastFlag("ExpChatOnShowIconChatAvailabilityStatus", false)
local GetChatStatusStore = if bool1 then require(CorePackages.Workspace.Packages.ExpChat).Stores.GetChatStatusStore else nil
local UniversalAppPolicy = if GetFFlagExpChatGuacChatDisabledReason() then require(CorePackages.Workspace.Packages.UniversalAppPolicy) else nil

local function new(arg1)
    local var1, setCoreGuiEnabled = Signals.createSignal(true)
    local var3, setLocalUserChat = Signals.createSignal(false)
    local var5, setChatActiveCalledByDeveloper = Signals.createSignal(false)
    local var7, setVisibleViaChatSelector = Signals.createSignal(false)
    local var9 = nil
    local var10

    if FFlagExpChatWindowSyncUnibar then
        local var11
        var11, var10 = Signals.createSignal(false)
        var9 = var11
    else
        var10 = nil
    end

    local bool2 = if GetFFlagExpChatGuacChatDisabledReason() and UniversalAppPolicy then UniversalAppPolicy.getAppFeaturePolicies().getExperienceChatAvailability() == "regionLocked" else false

    local var11 = FFlagEnableAEGIS2CommsFAEUpsell and bool1

    local getIsChatIconVisible = Signals.createComputed(function(arg2): boolean
        if not var1(arg2) then
            return false
        end

        if not var11 and var3(arg2) then
            return true
        end

        if not FFlagExpChatWindowSyncUnibar and var7(arg2) then
            return true
        end

        if not FFlagExpChatWindowSyncUnibar and var5(arg2) then
            return true
        end

        if FFlagExpChatWindowSyncUnibar and var9(arg2) then
            return true
        end

        if var11 and arg1.getChatStatus(arg2) ~= "NoOne" then
            return true
        end

        return not not (GetFFlagExpChatGuacChatDisabledReason() and bool2)
    end)

    local getIsChatWindowVisible = if FFlagExpChatWindowSyncUnibar then Signals.createComputed(function(arg2): boolean
        return not not (getIsChatIconVisible(arg2) and var9(arg2))
    end) else nil

    return {
        getIsChatIconVisible = getIsChatIconVisible,
        getIsChatWindowVisible = getIsChatWindowVisible,
        setCoreGuiEnabled = setCoreGuiEnabled,
        setLocalUserChat = setLocalUserChat,
        setChatActiveCalledByDeveloper = setChatActiveCalledByDeveloper,
        setVisibleViaChatSelector = setVisibleViaChatSelector,
        setGameSettingsChatVisible = var10
    }
end

return {
    new = new,
    default = new(if bool1 then GetChatStatusStore(false) else nil)
}
