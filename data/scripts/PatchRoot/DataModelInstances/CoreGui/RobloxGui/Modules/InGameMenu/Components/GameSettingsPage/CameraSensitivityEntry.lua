-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local t = InGameMenuDependencies.t

local tbl1 = {
    UserGameSettings:GetPropertyChangedSignal("GamepadCameraSensitivity"),
    UserGameSettings:GetPropertyChangedSignal("MouseSensitivity"),
    UserGameSettings:GetPropertyChangedSignal("MouseSensitivityFirstPerson"),
    UserGameSettings:GetPropertyChangedSignal("MouseSensitivityThirdPerson")
}

local scriptParentParentParent = script.Parent.Parent.Parent

local ExternalEventConnection = require(scriptParentParentParent.Utility.ExternalEventConnection)
local SliderEntry = require(script.Parent.SliderEntry)

local SendAnalytics = require(scriptParentParentParent.Utility.SendAnalytics)
local Constants = require(scriptParentParentParent.Resources.Constants)

local function guiToEngineSensitivity(arg1): number -- Luacid: Inlined by compiler; 1 call site recovered
    return math.clamp(if arg1 <= 5 then 0.198 * arg1 + 0.01 else 0.6 * arg1 - 2, 0, 10)
end

local function engineToGuiSensitivity(arg1): number -- Luacid: Inlined by compiler; 1 call site recovered
    return math.clamp(math.floor((if arg1 <= 1 then (arg1 - 0.01) / 0.198 else (arg1 + 2) / 0.6) / 0.01 + 0.5) * 0.01, 0, 10)
end

local var1 = Roact.PureComponent:extend("CameraSensitivityEntry")
var1.validateProps = t.strictInterface(
    {
        LayoutOrder = t.integer,
        canCaptureFocus = t.optional(t.boolean),
        isMenuOpen = t.optional(t.boolean)
    }
)
function var1.init(arg1)
    function arg1.onSensitivityChanged()
        arg1:setState({ engineSensitivity = UserGameSettings.MouseSensitivityFirstPerson.X })
    end

    arg1.onSensitivityChanged()
end

function var1.render(arg1)
    local tbl2 = { CameraSensitivityMouseSlider = 0 }

    local createElement = Roact.createElement
    local var2 = SliderEntry
    local tbl3 = {
        LayoutOrder = arg1.props.LayoutOrder,
        labelKey = "CoreScripts.InGameMenu.GameSettings.CameraSensitivity",
        value = 0,
        min = 0,
        max = 10,
        stepInterval = 1,
        keyboardInputStepInterval = 0.01,
        valueChanged = 0,
        canCaptureFocus = 0,
        isMenuOpen = 0
    }
    local engineSensitivity = arg1.state.engineSensitivity
    tbl3.value = engineToGuiSensitivity(engineSensitivity)

    function tbl3.valueChanged(arg2)
        local num1 = guiToEngineSensitivity(arg2)
        local vector2 = Vector2.new(num1, num1)
        UserGameSettings.MouseSensitivityFirstPerson = vector2
        UserGameSettings.MouseSensitivityThirdPerson = vector2
        SendAnalytics(Constants.AnalyticsSettingsChangeName, nil, {}, true)
    end
    tbl3.canCaptureFocus = arg1.props.canCaptureFocus
    tbl3.isMenuOpen = arg1.props.isMenuOpen
    tbl2.CameraSensitivityMouseSlider = createElement(var2, tbl3)

    for _, event in ipairs(tbl1) do
        local str1 = tostring(event) .. "CameraSensitivityControlConnection"
        tbl2[str1] = Roact.createElement(ExternalEventConnection, { event = event, callback = arg1.onSensitivityChanged })
    end

    return Roact.createFragment(tbl2)
end

return var1
