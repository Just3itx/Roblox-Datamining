-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:20:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChatService = game:GetService("TextChatService")

local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local ExpChatShared = require(ExpChatParent.ExpChatShared)
local React = require(ExpChatParent.React)

local GetPresetChatStore = require(ExpChat.Stores.GetPresetChatStore)
local sendPreset = require(script.Parent.sendPreset)
local FFlagExpChatUniverseChatPresetEnabled = require(ExpChat.Flags.FFlagExpChatUniverseChatPresetEnabled)

local FFlagExpChatPresetChatAutocompleteEnabled = require(ExpChat.Flags.FFlagExpChatPresetChatAutocompleteEnabled)
local FFlagExpChatPresetTrayDismissAnalytics = require(ExpChat.Flags.FFlagExpChatPresetTrayDismissAnalytics)
local var1 = ExpChatShared.Flags.FIntPresetChatCooldownLuaMs / 1000

local var2 = ExpChatShared.Logger:new("ExpChat/PresetChat/useOnPresetActivated")

local function getRBXGeneralChannel(): TextChannel? -- Luacid: unused: defined but never referenced
    local rbxGeneral = TextChatService:FindFirstChild("RBXGeneral", true)
    return if rbxGeneral and rbxGeneral:IsA("TextChannel") then rbxGeneral else nil
end

local function useOnPresetActivated(tbl1)
    local presetChatStore = GetPresetChatStore(false)
    local textChannel = tbl1.textChannel
    local closePresetTray = tbl1.closePresetTray

    return React.useCallback(function(presetId: string)
        if FFlagExpChatPresetTrayDismissAnalytics and presetChatStore.getIsTrayOpen(false) then
            presetChatStore.incrementPresetClickCount(presetId)
        end

        if FFlagExpChatPresetChatAutocompleteEnabled then
            presetChatStore.setPresetCooldownEndsAt(os.clock() + var1)

            local var3 = sendPreset(presetId, textChannel)
            if var3 ~= "Sent" then
                presetChatStore.setPresetCooldownEndsAt(nil)
            end

            if var3 == "NoChannel" then
                var2:warning("Preset {} activated but no target text channel was provided; skipping send.", presetId)
                closePresetTray()
                return
            end

            if not FFlagExpChatPresetTrayDismissAnalytics then
                presetChatStore.incrementPresetClickCount(presetId)
            end
            closePresetTray()
            return
        end

        local var3 = textChannel

        if var3 ~= nil and var3.Name ~= "RBXGeneral" then
            local rbxGeneral = TextChatService:FindFirstChild("RBXGeneral", true)
            var3 = rbxGeneral and rbxGeneral:IsA("TextChannel") and rbxGeneral or nil
        end

        presetChatStore.setPresetCooldownEndsAt(os.clock() + var1)

        if not var3 then
            if not FFlagExpChatUniverseChatPresetEnabled then
                var2:warning("Preset {} activated but no target text channel was provided; skipping send.", presetId)
                presetChatStore.setPresetCooldownEndsAt(nil)
                closePresetTray()
                return
            end
            if not pcall(function()
                TextChatService:SendUniverseChatPresetAsync(presetId)
            end) then
                presetChatStore.setPresetCooldownEndsAt(nil)
            end
        elseif not pcall(function()
            var3:SendPresetAsync(presetId)
        end) then
            presetChatStore.setPresetCooldownEndsAt(nil)
        end

        if not FFlagExpChatPresetTrayDismissAnalytics then
            presetChatStore.incrementPresetClickCount(presetId)
        end
        closePresetTray()
    end, { textChannel, presetChatStore, closePresetTray })
end

return useOnPresetActivated
