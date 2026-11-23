-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local React = require(AvatarExperienceCommonParent.React)
local ReactRoblox = require(AvatarExperienceCommonParent.ReactRoblox)
local Foundation = require(AvatarExperienceCommonParent.Foundation)

local function func1(arg1, ref)
    return React.createElement(Foundation.View, {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        ZIndex = 5,
        ref = ref,
        selectionGroup = {
            SelectionBehaviorUp = Enum.SelectionBehavior.Stop,
            SelectionBehaviorDown = Enum.SelectionBehavior.Stop,
            SelectionBehaviorLeft = Enum.SelectionBehavior.Stop,
            SelectionBehaviorRight = Enum.SelectionBehavior.Stop
        }
    }, arg1)
end

local function wrapForReactPortal(arg1, arg2, ref)
    return ReactRoblox.createPortal(func1(arg1, ref), arg2)
end

return wrapForReactPortal
