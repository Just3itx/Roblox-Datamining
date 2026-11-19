-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local t = InGameMenuDependencies.t

local UserGameSettings = UserSettings():GetService("UserGameSettings")
local MasterVolumeChanged = UserGameSettings:GetPropertyChangedSignal("MasterVolume")

local scriptParentParentParent = script.Parent.Parent.Parent

local FFlagRenameVolumeToMainVolume = require(CoreGui.RobloxGui.Modules.Flags.FFlagRenameVolumeToMainVolume)

local ExternalEventConnection = require(scriptParentParentParent.Utility.ExternalEventConnection)
local SliderEntry = require(script.Parent.SliderEntry)

local SendAnalytics = require(scriptParentParentParent.Utility.SendAnalytics)
local Constants = require(scriptParentParentParent.Resources.Constants)

if CoreGui.RobloxGui:FindFirstChild("Sounds") == nil then
    local sounds = Instance.new("Folder")
    sounds.Name = "Sounds"
    sounds.Parent = CoreGui.RobloxGui
end

local VolumeChangeSound = Instance.new("Sound", CoreGui.RobloxGui.Sounds)
VolumeChangeSound.Name = "VolumeChangeSound"
VolumeChangeSound.Volume = 1
VolumeChangeSound.SoundId = "rbxasset://sounds/uuhhh.mp3"

local var1 = Roact.PureComponent:extend("VolumeEntry")
var1.validateProps = t.strictInterface({
    LayoutOrder = t.integer,
    canCaptureFocus = t.optional(t.boolean),
    isMenuOpen = t.optional(t.boolean),
    buttonRef = t.optional(t.table)
})

function var1.init(arg1)
    function arg1.onVolumeChanged()
        arg1:setState({ volume = math.floor(UserGameSettings.MasterVolume * 10 + 0.5) })
    end

    arg1.onVolumeChanged()
end

function var1.render(arg1)
    return Roact.createFragment({
        VolumeSlider = Roact.createElement(SliderEntry, {
            labelKey = if FFlagRenameVolumeToMainVolume then "CoreScripts.InGameMenu.GameSettings.MainVolume" else "CoreScripts.InGameMenu.GameSettings.Volume",
            LayoutOrder = arg1.props.LayoutOrder,
            min = 0,
            max = 10,
            stepInterval = 1,
            value = arg1.state.volume,
            valueChanged = function(arg2)
                UserGameSettings.MasterVolume = arg2 / 10
                VolumeChangeSound:Play()
                SendAnalytics(Constants.AnalyticsSettingsChangeName, nil, {}, true)
            end,
            canCaptureFocus = arg1.props.canCaptureFocus,
            isMenuOpen = arg1.props.isMenuOpen,
            buttonRef = arg1.props.buttonRef
        }),
        VolumeListener = Roact.createElement(ExternalEventConnection, { event = MasterVolumeChanged, callback = arg1.onVolumeChanged })
    })
end

return var1
