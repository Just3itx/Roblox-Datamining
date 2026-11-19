-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:31:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local RunService = game:GetService("RunService")
local TelemetryService = game:GetService("TelemetryService")

local GameSettings = UserSettings().GameSettings

local BoxButton = require(script.Parent.Parent.BoxButton)
local Constants = require(script.Parent.Parent.Parent.Constants)
local Checkbox = require(script.Parent.Parent.Checkbox)
local MicroProfilerPanel = require(script.Parent.MicroProfilerPanel)
local Roact = require(CorePackages.Packages.Roact)

local var1 = Roact.Component:extend("LocalActionsView")

local bool1 = game:DefineFastFlag("DevConsoleMpEnableOpenDumpsFolderButton", false)

local config = {
    eventName = "DevConsoleMpToggleOnScreenMpCounter",
    backends = { "RobloxTelemetryCounter" },
    lastUpdated = { 2025, 11, 17 },
    description = "\t\tCounter to track toggling the on-screen MicroProfiler on or off via the Developer Console.\n\t"
}

function var1.init(arg1)
    arg1:setState({ OnScreenMicroProfilerVisible = GameSettings.OnScreenProfilerEnabled })

    arg1.onScreenMpToggledConn = GameSettings:GetPropertyChangedSignal("OnScreenProfilerEnabled"):Connect(function()
        arg1:setState({ OnScreenMicroProfilerVisible = GameSettings.OnScreenProfilerEnabled })
    end)
end

function var1.willUnmount(arg1)
    if not arg1.onScreenMpToggledConn then
        return
    end

    if arg1.onScreenMpToggledConn.Connected then
        arg1.onScreenMpToggledConn:Disconnect()
    end
    arg1.onScreenMpToggledConn = nil
end

function var1.toggleOnScreenMicroProfiler(_, onScreenProfilerEnabled: boolean)
    GameSettings.OnScreenProfilerEnabled = onScreenProfilerEnabled

    TelemetryService:LogCounter(config, { customFields = { visible = `{onScreenProfilerEnabled}` } }, 1)
end

function var1.render(arg1)
    return Roact.createElement(MicroProfilerPanel, {
        Title = "Local actions",
        LayoutOrder = arg1.props.LayoutOrder,
        Sections = {{
            Name = "LocalActions",
            Rows = {
                {
                    UIListLayout = Roact.createElement(
                        "UIListLayout",
                        {
                            FillDirection = Enum.FillDirection.Horizontal,
                            SortOrder = Enum.SortOrder.LayoutOrder
                        }
                    ),
                    UIPadding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, Constants.MicroProfilerFormatting.OptionTextPadding) }),
                    OptionLabel = Roact.createElement(
                        "TextLabel",
                        {
                            Size = UDim2.fromScale(0, 1),
                            Position = UDim2.new(0, 8, 0, 0),
                            BackgroundTransparency = 1,
                            Text = "On-screen MicroProfiler visible",
                            TextXAlignment = Enum.TextXAlignment.Left,
                            Font = Constants.Font.MainWindow,
                            TextSize = Constants.MicroProfilerFormatting.OptionTextSize,
                            TextColor3 = Color3.new(1, 1, 1),
                            LayoutOrder = 1
                        },
                        { Roact.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Grow }) }
                    ),
                    CheckboxFrame = Roact.createElement("Frame", {
                        Size = UDim2.fromOffset(Constants.MicroProfilerFormatting.OptionRowHeight, Constants.MicroProfilerFormatting.OptionRowHeight),
                        BackgroundTransparency = 1,
                        LayoutOrder = 2
                    }, {
                        OnScreenMicroProfilerVisibleCheckbox = Roact.createElement(Checkbox, {
                            Name = "OnScreenMicroProfilerVisibleCheckbox",
                            IsSelected = arg1.state.OnScreenMicroProfilerVisible,
                            Size = UDim2.fromOffset(
                                Constants.MicroProfilerFormatting.OptionCheckboxSize,
                                Constants.MicroProfilerFormatting.OptionCheckboxSize
                            ),
                            Position = UDim2.fromOffset(
                                (Constants.MicroProfilerFormatting.OptionRowHeight - Constants.MicroProfilerFormatting.OptionCheckboxSize) / 2,
                                (Constants.MicroProfilerFormatting.OptionRowHeight - Constants.MicroProfilerFormatting.OptionCheckboxSize) / 2
                            ),
                            OnSelectedStateChanged = function(_, bool2: boolean)
                                arg1:toggleOnScreenMicroProfiler(bool2)
                            end
                        })
                    })
                },
                bool1
                    and game:GetEngineFeature("OpenLogsFolderApi")
                    and not RunService:IsStudio()
                    and {
                        UIPadding = Roact.createElement("UIPadding", {
                            PaddingBottom = UDim.new(0, 2),
                            PaddingLeft = UDim.new(0, 2),
                            PaddingRight = UDim.new(0, 2),
                            PaddingTop = UDim.new(0, 2)
                        }),
                        Button = Roact.createElement(BoxButton, {
                            text = "Open dump folder",
                            size = UDim2.fromScale(1, 1),
                            pos = UDim2.new(0, 0, 0, 0),
                            onClicked = function()
                                game:OpenLogsFolder()
                            end
                        })
                    }
                    or nil
            }
        }}
    })
end

return var1
