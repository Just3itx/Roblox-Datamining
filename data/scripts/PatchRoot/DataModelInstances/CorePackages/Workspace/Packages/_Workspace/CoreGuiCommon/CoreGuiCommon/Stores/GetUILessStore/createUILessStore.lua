-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:00:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local CoreGuiCommon = script:FindFirstAncestor("CoreGuiCommon")
local CoreGuiCommonParent = CoreGuiCommon.Parent
local IXPServiceWrapper = require(CoreGuiCommonParent.IXPServiceWrapper).IXPServiceWrapper
local Signals = require(CoreGuiCommonParent.Signals)
local createSignal = Signals.createSignal
local createEffect = Signals.createEffect
local LogTopBarToggled = require(CoreGuiCommon.Telemetry).LogTopBarToggled

local bool1 = game:DefineFastFlag("EnableDesktopUILessMode", false)
local str1 = game:DefineFastString("AddUILessModeIxpLayer", "")

return function()
    local getUiLessModeEnabled, _ = createSignal(bool1 and UserInputService.PreferredInput == Enum.PreferredInput.KeyboardAndMouse)

    local getUiVisible, setUiVisible = createSignal(not getUiLessModeEnabled(false))

    local effect = createEffect(function(arg1)
        if getUiLessModeEnabled(false) then
            LogTopBarToggled(getUiVisible(arg1))
        end
    end)

    local function cleanup()
        effect()
    end

    if getUiLessModeEnabled(false) then
        IXPServiceWrapper:LogFlagLinkedUserLayerExposure(str1)
    end

    return {
        getUILessModeEnabled = getUiLessModeEnabled,
        getUIVisible = getUiVisible,
        setUIVisible = setUiVisible,
        cleanup = cleanup
    }
end
