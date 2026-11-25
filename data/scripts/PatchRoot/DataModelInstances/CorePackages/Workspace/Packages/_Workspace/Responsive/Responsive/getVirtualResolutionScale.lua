-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ResponsiveParent = script:FindFirstAncestor("Responsive").Parent
local isTenFootInterface = require(ResponsiveParent.AppCommonLib).isTenFootInterface
local GetFFlagApplyResolutionScale = require(ResponsiveParent.SharedFlags).GetFFlagApplyResolutionScale

function getVirtualResolutionScale(): number?
    return if GetFFlagApplyResolutionScale() then if isTenFootInterface() then 1.5 else 1 else nil
end

return getVirtualResolutionScale
