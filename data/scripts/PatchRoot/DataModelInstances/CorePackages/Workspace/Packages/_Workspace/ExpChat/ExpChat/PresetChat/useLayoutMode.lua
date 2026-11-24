-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local SignalsReact = require(ExpChatParent.SignalsReact)

local GetPresetChatStore = require(ExpChat.Stores.GetPresetChatStore)
local Constants = require(script.Parent.Constants)
local FFlagExpChatPresetChatGamepadEnabled = require(ExpChat.Flags.FFlagExpChatPresetChatGamepadEnabled)

local FFlagLuaSupportMicroGamepadPreferredInput = require(ExpChatParent.SharedFlags).FFlagLuaSupportMicroGamepadPreferredInput

local function isTouchDevice(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return UserInputService.TouchEnabled and not UserInputService.MouseEnabled
end

local function useLayoutMode()
    local presetChatStore = GetPresetChatStore(false)
    local var1 = SignalsReact.useSignalState(presetChatStore.getLayoutModeOverride)

    if var1 == Constants.LayoutMode.Tray or var1 == Constants.LayoutMode.FlyOut then
        return var1
    end

    if FFlagExpChatPresetChatGamepadEnabled
        and (UserInputService.PreferredInput == Enum.PreferredInput.Gamepad
            or FFlagLuaSupportMicroGamepadPreferredInput and UserInputService.PreferredInput == Enum.PreferredInput.MicroGamepad)
    then
        return Constants.LayoutMode.FlyOut
    end

    if isTouchDevice() then
        return Constants.LayoutMode.Tray
    end

    return Constants.LayoutMode.FlyOut
end

return useLayoutMode
