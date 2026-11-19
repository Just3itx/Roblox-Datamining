-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)
local ReactRoblox = require(CorePackages.Packages.ReactRoblox)
local Foundation = require(CorePackages.Packages.Foundation)
local CoreScriptsCommon = require(CorePackages.Workspace.Packages.CoreScriptsCommon)

local scriptParentParent = script.Parent.Parent
local InExperienceMenuReact = require(scriptParentParent.InExperienceMenuReact)
local Create = require(CorePackages.Workspace.Packages.AppCommonLib).Create

local SettingsShowSignal = CoreScriptsCommon.SettingsShowSignal
local View = Foundation.View
local Divider = Foundation.Divider
local DividerOrientation = Foundation.Enums.DividerOrientation
local useTokens = Foundation.Hooks.useTokens

local function DividerContainer()
    local var1 = useTokens()
    return React.createElement(
        View,
        {
            tag = "auto-xy",
            padding = {
                left = UDim.new(0, 10),
                top = UDim.new(0, var1.Padding.XSmall),
                bottom = UDim.new(0, var1.Padding.Large)
            }
        },
        {
            Divider = React.createElement(Divider, { orientation = DividerOrientation.Horizontal })
        }
    )
end

local function renderSettingsDivider(tbl1)
    local var1 = Create("Frame")({
        Name = "DividerWrapper",
        Size = UDim2.fromScale(1, 0),
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = tbl1.layoutOrder,
        Parent = tbl1.parent
    })

    local root = nil
    SettingsShowSignal:connect(function(arg1)
        if not arg1 then
            if root then
                root:unmount()
                root = nil
                var1.Parent = nil
            end
            return
        end

        var1.Parent = tbl1.parent
        root = ReactRoblox.createRoot(var1)
        root:render(
            React.createElement(InExperienceMenuReact, nil, { DividerContainer = React.createElement(DividerContainer) })
        )
    end)

    return var1
end

return renderSettingsDivider
