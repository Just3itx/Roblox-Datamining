-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChatService = game:GetService("TextChatService")
local GameSettings = UserSettings().GameSettings

local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local ExpChatShared = require(ExpChatParent.ExpChatShared)

local EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint = require(ExpChatParent.SharedFlags).EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint

local _createPresetChatStore = require(ExpChat.Stores.GetPresetChatStore.createPresetChatStore)

local var1 = ExpChatShared.Logger:new("ExpChat/PresetChat/initializePresetChat")

local function getPresetsFromEngine()
    return TextChatService:GetPresetsAsync()
end

local function fetchPresets(arg1, bool1: boolean?, callback: (...any) -> (...any)) -- Luacid: Inlined by compiler; 3 call sites recovered
    task.spawn(function()
        local success, result = pcall(callback)

        if bool1 then
            if not success then
                var1:warning("GetPresetsAsync failed: {}", tostring(result))
            end

            return
        end

        if not success then
            var1:warning("GetPresetsAsync failed: {}", tostring(result))
            arg1.setIsLoading(false)
            return
        end

        if not result then
            arg1.setIsLoading(false)
            return
        end

        local var2 = (if EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint then result.status else result.accessLevel) or "Disabled"
        arg1.setAccessLevel(var2)

        if var2 ~= "Disabled" then
            local version = result.version
            if not EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint and (not version or version == "") then
                var1:warning("Missing version in GetPresetsAsync response, treating as disabled")
                arg1.setAccessLevel("Disabled")
                arg1.setIsLoading(false)
                return
            end

            local categoryGroups = result.categoryGroups
            if categoryGroups and #categoryGroups > 0 then
                arg1.setCategoryGroups(categoryGroups)
                arg1.setVersion(version or "")
                arg1.setIsEnabled(true)
            end
        end

        arg1.setIsLoading(false)
    end)
end

local function initializePresetChat(arg1, bool1: boolean?, func1: ((...any) -> (...any))?)
    local var2 = func1 or getPresetsFromEngine
    fetchPresets(arg1, bool1, var2)

    GameSettings:GetPropertyChangedSignal("ChatTranslationLocale"):Connect(function()
        if not bool1 then
            arg1.setIsLoading(true)
        end
        fetchPresets(arg1, bool1, var2)
    end)

    GameSettings:GetPropertyChangedSignal("ChatTranslationEnabled"):Connect(function()
        if not bool1 then
            arg1.setIsLoading(true)
        end
        fetchPresets(arg1, bool1, var2)
    end)
end

return initializePresetChat
