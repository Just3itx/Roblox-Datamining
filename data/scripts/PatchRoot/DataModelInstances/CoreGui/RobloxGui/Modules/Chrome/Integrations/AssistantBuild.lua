-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:41:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CorePackages = game:GetService("CorePackages")
local VRService = game:GetService("VRService")

local FFlagBuildExperienceInGameShell = require(CorePackages.Workspace.Packages.SharedFlags).FFlagBuildExperienceInGameShell

local React = require(CorePackages.Packages.React)
local Foundation = require(CorePackages.Packages.Foundation)
local Signals = if FFlagBuildExperienceInGameShell then require(CorePackages.Packages.Signals) else nil
local BuildExperience = require(CorePackages.Workspace.Packages.BuildExperience)
local BuildModeLaunch = require(CorePackages.Workspace.Packages.BuildExperiencePlaytestLaunch.BuildModeLaunch)
local Display = if FFlagBuildExperienceInGameShell then require(CorePackages.Workspace.Packages.Display) else nil
local Service = require(Chrome.Service)

local ButtonVariant = Foundation.Enums.ButtonVariant

local function canShowAssistantBuild(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    if not BuildModeLaunch:hasBuildMode() or VRService.VREnabled then
        return false
    end
    if not FFlagBuildExperienceInGameShell then
        return true
    end
    local var1 = Display.GetDisplayStore(arg1).getDisplaySize(arg1)
    return var1 == nil or var1 == Enum.DisplaySize.Small
end

local tbl1 = {
    id = "assistant_build",
    label = "CommonUI.Features.NavBar.Build",
    initialAvailability = if canShowAssistantBuild(false) then Service.AvailabilitySignal.Available else Service.AvailabilitySignal.Unavailable,
    activated = 0,
    components = 0
}

function tbl1.activated(_)
    local assistantBuildStore = BuildExperience.GetAssistantBuildStore()
    if FFlagBuildExperienceInGameShell then
        assistantBuildStore.activate()
    elseif not assistantBuildStore.getIsDisabled() then
        assistantBuildStore.setIsDisabledTooltipOpen(false)
        BuildExperience.GetPlayButtonStore().setIsActive(true)
    else
        assistantBuildStore.setIsDisabledTooltipOpen(not assistantBuildStore.getIsDisabledTooltipOpen())
    end
end
tbl1.components = {
    Icon = function(_)
        return React.createElement(BuildExperience.AssistantBuild, { variant = ButtonVariant.Utility })
    end
}

local var1 = Service:register(tbl1)

if FFlagBuildExperienceInGameShell then
    var1._disposeDisplaySizeEffect = Signals.createEffect(function(arg1)
        if canShowAssistantBuild(arg1) then
            var1.availability:available()
            return
        end
        var1.availability:unavailable()
    end)
end

return var1
