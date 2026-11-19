-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local t = InGameMenuDependencies.t

local UserGameSettings = UserSettings():GetService("UserGameSettings")
local Rendering = settings().Rendering

local SavedQualityLevelChanged = UserGameSettings:GetPropertyChangedSignal("SavedQualityLevel")

local scriptParentParentParent = script.Parent.Parent.Parent

local ToggleEntry = require(script.Parent.ToggleEntry)
local ExternalEventConnection = require(scriptParentParentParent.Utility.ExternalEventConnection)
local SliderEntry = require(script.Parent.SliderEntry)

local SendAnalytics = require(scriptParentParentParent.Utility.SendAnalytics)
local Constants = require(scriptParentParentParent.Resources.Constants)

local num1 = #Enum.SavedQualitySetting:GetEnumItems() - 1

local function mapInteger(savedQualityLevel, num2: number, num3: number, num4: number, arg1): number -- Luacid: Inlined by compiler; 1 call site recovered
    return math.clamp(math.floor(num4 + (savedQualityLevel - num2) * (arg1 - num4) / (num3 - num2)), num4, arg1)
end

local var1 = Roact.PureComponent:extend("GraphicsQualityEntry")
var1.validateProps = t.strictInterface(
    {
        LayoutOrder = t.integer,
        canCaptureFocus = t.optional(t.boolean),
        isMenuOpen = t.optional(t.boolean)
    }
)
function var1.init(arg1)
    local automatic = UserGameSettings.SavedQualityLevel == Enum.SavedQualitySetting.Automatic
    arg1:setState({ quality = if automatic then 5 else UserGameSettings.SavedQualityLevel.Value, automatic = automatic })

    function arg1.onQualityChanged()
        local savedQualityLevel = UserGameSettings.SavedQualityLevel
        local bool2 = savedQualityLevel == Enum.SavedQualitySetting.Automatic

        arg1:setState({
            quality = if bool2 then nil else savedQualityLevel.Value or nil,
            automatic = savedQualityLevel == Enum.SavedQualitySetting.Automatic
        })
    end

    if automatic then
        arg1:setAutomaticQualityLevel()
        return
    end
    arg1:setManualQualityLevel(arg1.state.quality)
end

function var1.setAutomaticQualityLevel(_)
    UserGameSettings.SavedQualityLevel = Enum.SavedQualitySetting.Automatic
    Rendering.QualityLevel = 0
end

function var1.setManualQualityLevel(_, savedQualityLevel)
    local qualityLevel = mapInteger(savedQualityLevel, 1, num1, 1, Rendering:GetMaxQualityLevel() - 1)

    UserGameSettings.SavedQualityLevel = savedQualityLevel
    Rendering.QualityLevel = qualityLevel
    return nil
end

function var1.render(arg1)
    return Roact.createElement(
        "Frame",
        {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 156),
            LayoutOrder = arg1.props.LayoutOrder
        },
        {
            Layout = Roact.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }),
            AutoToggle = Roact.createElement(ToggleEntry, {
                LayoutOrder = 1,
                labelKey = "CoreScripts.InGameMenu.GameSettings.AutoGraphicsQuality",
                checked = arg1.state.automatic,
                onToggled = function()
                    if arg1.state.automatic then
                        arg1:setManualQualityLevel(arg1.state.quality)
                    else
                        arg1:setAutomaticQualityLevel()
                    end
                    SendAnalytics(Constants.AnalyticsSettingsChangeName, nil, {}, true)
                end
            }),
            Slider = Roact.createElement(SliderEntry, {
                LayoutOrder = 2,
                labelKey = "CoreScripts.InGameMenu.GameSettings.ManualGraphicsQuality",
                min = 1,
                max = 10,
                stepInterval = 1,
                value = arg1.state.quality,
                disabled = arg1.state.automatic,
                valueChanged = function(arg2)
                    arg1:setManualQualityLevel(arg2)
                    SendAnalytics(Constants.AnalyticsSettingsChangeName, nil, {}, true)
                end,
                canCaptureFocus = arg1.props.canCaptureFocus,
                isMenuOpen = arg1.props.isMenuOpen
            }),
            QualityListener = Roact.createElement(ExternalEventConnection, { event = SavedQualityLevelChanged, callback = arg1.onQualityChanged })
        }
    )
end

return var1
