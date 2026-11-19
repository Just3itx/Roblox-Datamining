-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux
local t = InGameMenuDependencies.t
local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle
local scriptParentParentParent = script.Parent.Parent.Parent
local Page = require(script.Parent.Parent.Page)
local CloseMenu = require(scriptParentParentParent.Thunks.CloseMenu)
local VRComfortAutoToggleEntry = nil
local ComfortSettingsEntry = nil
if game:GetEngineFeature("VRMoreComfortSettings") then
    VRComfortAutoToggleEntry = require(script.Parent.VRComfortAutoToggleEntry)
    ComfortSettingsEntry = require(script.Parent.ComfortSettingsEntry)
end

local var1 = Roact.PureComponent:extend("VRComfortSettingsPage")

var1.validateProps = t.strictInterface({ closeMenu = t.callback, pageTitle = t.string })

local function createLayoutOrderGenerator(): () -> number -- Luacid: Inlined by compiler; 1 call site recovered
    local num1 = 0
    return function(): number
        num1 += 1
        return num1
    end
end

function var1.render(arg1)
    return withFoundationOrUIBloxStyle(function(_)
        return {}
    end, function(_)
        local layoutOrderGenerator = createLayoutOrderGenerator()
        return Roact.createElement(Page, {
            pageTitle = arg1.props.pageTitle,
            zIndex = 2,
            position = arg1.props.position
        }, {
            Layout = Roact.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Right,
                VerticalAlignment = Enum.VerticalAlignment.Top
            }),
            VRComfortSettings = if game:GetEngineFeature("VRMoreComfortSettings") then Roact.createElement(ComfortSettingsEntry, { LayoutOrder = layoutOrderGenerator() }) else nil,
            VignetteEnabled = if game:GetEngineFeature("VRMoreComfortSettings") then Roact.createElement(
                VRComfortAutoToggleEntry,
                {
                    LayoutOrder = layoutOrderGenerator(),
                    labelKey = "CoreScripts.InGameMenu.GameSettings.VignetteEnabled",
                    customValueKey = "VignetteEnabledCustomOption",
                    derivedValueKey = "VignetteEnabled"
                }
            ) else nil,
            VRSteppedRotationEnabled = if game:GetEngineFeature("VRMoreComfortSettings") then Roact.createElement(
                VRComfortAutoToggleEntry,
                {
                    LayoutOrder = layoutOrderGenerator(),
                    labelKey = "CoreScripts.InGameMenu.GameSettings.VRSteppedRotationEnabled",
                    customValueKey = "VRSmoothRotationEnabledCustomOption",
                    derivedValueKey = "VRSmoothRotationEnabled",
                    checkedValue = false
                }
            ) else nil,
            VRThirdPersonFixedCamEnabled = if game:GetEngineFeature("VRMoreComfortSettings") then Roact.createElement(
                VRComfortAutoToggleEntry,
                {
                    LayoutOrder = layoutOrderGenerator(),
                    labelKey = "CoreScripts.InGameMenu.GameSettings.VRThirdPersonFixedCamEnabled",
                    customValueKey = "VRThirdPersonFollowCamEnabledCustomOption",
                    derivedValueKey = "VRThirdPersonFollowCamEnabled",
                    checkedValue = false
                }
            ) else nil
        })
    end)
end

return RoactRodux.UNSTABLE_connect2(nil, function(callback)
    return {
        closeMenu = function()
            callback(CloseMenu)
        end
    }
end)(var1)
