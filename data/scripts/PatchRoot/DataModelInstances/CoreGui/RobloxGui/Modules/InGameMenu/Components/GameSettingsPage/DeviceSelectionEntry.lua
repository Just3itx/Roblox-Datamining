-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local SoundService = game:GetService("SoundService")

local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local t = InGameMenuDependencies.t

local scriptParentParentParent = script.Parent.Parent.Parent
local DropDownSelection = require(scriptParentParentParent.Components.DropDownSelection)
local ThemedTextLabel = require(scriptParentParentParent.Components.ThemedTextLabel)
local default = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default
local var1 = require(CorePackages.Workspace.Packages.CoreScriptsInitializer).CoreLogger:new(script.Name)

local var2 = Roact.PureComponent:extend("DeviceSelectionEntry")

local Flags = scriptParentParentParent.Flags
local GetFFlagTruncateDeviceSelection = require(Flags.GetFFlagTruncateDeviceSelection)

local GetFFlagVoiceChatUILogging = require(RobloxGui.Modules.Flags.GetFFlagVoiceChatUILogging)

var2.DeviceType = { Input = "Input", Output = "Output" }

var2.validateProps = t.strictInterface({
    LayoutOrder = t.integer,
    deviceType = t.string,
    isMenuOpen = t.boolean,
    canOpen = t.optional(t.boolean),
    canCaptureFocus = t.optional(t.boolean)
})

var2.defaultProps = { canOpen = true }

function var2.init(arg1)
    arg1:setState({ deviceNames = {}, deviceGuids = {}, selectedIndex = 0, ready = false })

    default:asyncInit():andThen(function()
        arg1:setState({ ready = true })

        default:SetupParticipantListeners()
        if not SoundService.DeviceListChanged then
            return
        end

        SoundService.DeviceListChanged:Connect(function()
            if arg1.props.isMenuOpen then
                arg1:pollDevices(arg1.props.deviceType)
            end
        end)
    end):catch(function()
        if GetFFlagVoiceChatUILogging() then
            var1:warning("Failed to init VoiceChatServiceManager")
        end
    end)
end

function var2.render(arg1)
    if not arg1.state.ready or arg1.state.deviceNames == nil or #arg1.state.deviceNames == 0 then
        return nil
    end

    return Roact.createElement(
        "Frame",
        {
            Size = UDim2.new(1, 0, 0, 120),
            BackgroundTransparency = 1,
            LayoutOrder = arg1.props.LayoutOrder,
            ZIndex = 2
        },
        {
            Padding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, 24), PaddingRight = UDim.new(0, 24) }),
            InputLabel = Roact.createElement(ThemedTextLabel, {
                fontKey = "Body",
                themeKey = "TextDefault",
                Size = UDim2.new(1, 0, 0, 56),
                Position = UDim2.new(0, 0, 0, 0),
                AnchorPoint = Vector2.new(0, 0),
                Text = if arg1.props.deviceType == var2.DeviceType.Input then "Input Device" else "Output Device",
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextXAlignment = Enum.TextXAlignment.Left
            }),
            Dropdown = Roact.createElement(DropDownSelection, {
                Size = UDim2.new(1, 0, 0, 44),
                Position = UDim2.new(0, 0, 0, 56),
                truncate = GetFFlagTruncateDeviceSelection(),
                selections = arg1.state.deviceNames,
                selectedIndex = arg1.state.selectedIndex,
                placeHolderText = "",
                enabled = true,
                localize = false,
                selectionParentName = arg1.props.deviceType .. "DeviceSelectionEntryDropdown",
                canOpen = arg1.props.canOpen,
                canCaptureFocus = arg1.props.canCaptureFocus,
                selectionChanged = function(selectedIndex)
                    default:SwitchDevice(
                        arg1.props.deviceType,
                        arg1.state.deviceNames[selectedIndex],
                        arg1.state.deviceGuids[selectedIndex]
                    )

                    arg1:setState({ selectedIndex = selectedIndex })
                end
            })
        }
    )
end

function var2.pollDevices(arg1, arg2)
    spawn(function()
        local var3, deviceNames, deviceGuids, selectedIndex = default:GetDevices(arg2)
        if var3 then
            arg1:setState({ deviceNames = deviceNames, deviceGuids = deviceGuids, selectedIndex = selectedIndex })
            return
        end

        if GetFFlagVoiceChatUILogging() then
            var1:warning("Errors in get {} Device info", arg2)
        end
        arg1:setState({ deviceNames = {}, deviceGuids = {}, selectedIndex = 0 })
    end)
end

function var2.willUpdate(arg1, arg2)
    if not arg1.props.isMenuOpen and arg2.isMenuOpen then
        arg1:pollDevices(arg2.deviceType)
    end
end

return var2
