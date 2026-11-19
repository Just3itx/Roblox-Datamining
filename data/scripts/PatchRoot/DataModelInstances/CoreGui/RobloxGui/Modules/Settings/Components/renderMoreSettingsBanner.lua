-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)
local ReactRoblox = require(CorePackages.Packages.ReactRoblox)
local CoreScriptsCommon = require(CorePackages.Workspace.Packages.CoreScriptsCommon)

local scriptParentParent = script.Parent.Parent
local InExperienceMenuReact = require(scriptParentParent.InExperienceMenuReact)
local MoreSettingsBanner = require(script.Parent.MoreSettingsBanner)
local Create = require(CorePackages.Workspace.Packages.AppCommonLib).Create
local isPioneerLaunch = require(CorePackages.Workspace.Packages.PioneerUtils).isPioneerLaunch

local SettingsShowSignal = CoreScriptsCommon.SettingsShowSignal

local function renderMoreSettingsBanner(tbl1)
    if not (tbl1.isPioneerLaunch or isPioneerLaunch)() then
        return nil
    end

    local var1 = Create("Frame")({
        Name = "MoreSettingsBannerWrapper",
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
            React.createElement(InExperienceMenuReact, nil, { MoreSettingsBanner = React.createElement(MoreSettingsBanner) })
        )
    end)

    return var1
end

return renderMoreSettingsBanner
