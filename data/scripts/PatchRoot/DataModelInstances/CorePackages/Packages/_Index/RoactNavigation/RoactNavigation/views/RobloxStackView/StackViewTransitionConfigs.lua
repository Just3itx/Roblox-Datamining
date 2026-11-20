-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:30:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParentParent = scriptParent.Parent.Parent.Parent

local Object = require(scriptParentParentParentParent.LuauPolyfill).Object
local StackViewInterpolator = require(scriptParent.StackViewInterpolator)
local StackPresentationStyle = require(scriptParent.StackPresentationStyle)

local transitionSpec = { frequency = 3, dampingRatio = 1 }

local SlideFromRight = {
    transitionSpec = transitionSpec,
    screenInterpolator = StackViewInterpolator.forHorizontal
}

local ModalSlideFromBottom = {
    transitionSpec = transitionSpec,
    screenInterpolator = StackViewInterpolator.forVertical
}

local FadeInPlace = {
    transitionSpec = transitionSpec,
    screenInterpolator = StackViewInterpolator.forFade
}

local function getDefaultTransitionConfig(_, _, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return if arg1 == StackPresentationStyle.Modal then ModalSlideFromBottom elseif arg1 == StackPresentationStyle.Overlay then FadeInPlace else SlideFromRight
end

return {
    getDefaultTransitionConfig = getDefaultTransitionConfig,
    getTransitionConfig = function(arg1, arg2, arg3, arg4)
        local defaultTransitionConfig = getDefaultTransitionConfig(nil, nil, arg4)

        if arg1 then
            return Object.assign(table.clone(defaultTransitionConfig), arg1(arg2, arg3, arg4))
        end

        return defaultTransitionConfig
    end,
    SlideFromRight = SlideFromRight,
    ModalSlideFromBottom = ModalSlideFromBottom,
    FadeInPlace = FadeInPlace
}
