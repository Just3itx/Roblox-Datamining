-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:41:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local React = require(MomentsParent.React)

local _getSheetStructure = require(script.Parent.getSheetStructure)

local function useHiddenBackdrop(bool1: boolean, bool2: boolean)
    React.useLayoutEffect(function()
        local backdrop = if bool1 == nil or not bool2 then nil else bool1.backdrop

        if backdrop == nil then
            return nil
        end

        local uiGradient = Instance.new("UIGradient")
        uiGradient.Transparency = NumberSequence.new(1)
        uiGradient.Parent = backdrop
        return function()
            uiGradient:Destroy()
        end
    end, { bool1, bool2 })
end

return useHiddenBackdrop
