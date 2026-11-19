-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local VRService = game:GetService("VRService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local scriptParentParent = script.Parent.Parent
local Actions = scriptParentParent.Actions

local scriptParentParentParent = scriptParentParent.Parent

local EventStream = require(CorePackages.Workspace.Packages.Analytics).AnalyticsReporters.EventStream

local Analytics = require(scriptParentParent.Analytics)
local FFlagEnableNewBackpack = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableNewBackpack
local Features = if FFlagEnableNewBackpack then require(CorePackages.Workspace.Packages.System).Features else nil
local BackpackScript = if FFlagEnableNewBackpack then nil else require(scriptParentParentParent.BackpackScript)
local ShowMenu = require(Actions.ShowMenu)

local var1 = Analytics.new():withEventStream(EventStream.new(RbxAnalyticsService))

local function OpenMenu(_)
    return function(arg1)
        if GuiService.MenuIsOpen then
            if not VRService.VREnabled then
                return
            end

            GuiService:SetMenuIsOpen(false, "VRMenu")
        end

        if FFlagEnableNewBackpack then
            Features.setVisibility(Features.FeatureName.Backpack, false)

            if Features.getVisibility(Features.FeatureName.Backpack) then
                return
            end
        else
            if BackpackScript.IsOpen then
                BackpackScript.OpenClose()
            end

            if BackpackScript.IsOpen then
                return
            end
        end

        var1:onMenuOpened()

        arg1:dispatch(ShowMenu())
    end
end

return OpenMenu
