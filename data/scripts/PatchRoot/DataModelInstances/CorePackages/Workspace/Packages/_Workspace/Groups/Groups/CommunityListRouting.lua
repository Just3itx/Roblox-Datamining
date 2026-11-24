-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GroupsParent = script:FindFirstAncestor("Groups").Parent

local Display = require(GroupsParent.Display)
local Responsive = require(GroupsParent.Responsive)
local _Signals = require(GroupsParent.Signals)
local SharedFlags = require(GroupsParent.SharedFlags)
local FFlagEnableLuaCommunityList = SharedFlags.FFlagEnableLuaCommunityList
local FFlagEnableGroupOverviewPane = SharedFlags.FFlagEnableGroupOverviewPane

local function getIsCompactTouch(arg1)
    local var1 = Display.GetDisplayStore(false).getViewportSize(arg1)
    local var2 = Responsive.GetInputModeStore(false).getPreferredInputType(arg1)
    return Responsive.getIsCompactTouch(var1, var2)
end

local function getIsDirectionalInput(): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return Responsive.GetInputModeStore(false).getPreferredInputType(false) == Responsive.Input.Directional
end

return {
    getIsCompactTouch = getIsCompactTouch,
    getShouldOpenGroupOverviewPane = function()
        if not FFlagEnableGroupOverviewPane or getIsDirectionalInput() then
            return false
        end

        return getIsCompactTouch(false)
    end,
    getShouldUseLuaCommunityList = function()
        if not FFlagEnableLuaCommunityList or getIsDirectionalInput() then
            return false
        elseif FFlagEnableGroupOverviewPane then
            return true
        end

        return getIsCompactTouch(false)
    end
}
