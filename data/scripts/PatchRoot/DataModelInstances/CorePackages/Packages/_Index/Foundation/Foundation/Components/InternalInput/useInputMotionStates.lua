-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local _Types = require(Foundation.Components.Types)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local _React = require(FoundationParent.React)

local Motion = require(FoundationParent.Motion)
local TransitionPreset = Motion.TransitionPreset

local function useInputMotionStates(arg1, arg2)
    local strokeStyle = if arg2 and arg2.backgroundStyle then arg2.backgroundStyle else arg1.Color.Content.Default
    local var2 = if arg2 and arg2.checkedStyle then arg2.checkedStyle else arg1.Color.ActionSubEmphasis.Background
    local emphasis = arg1.Color.Content.Emphasis

    return {
        Default = Motion.createState({
            backgroundStyle = {
                Color3 = strokeStyle.Color3,
                Transparency = if arg2 and arg2.backgroundStyle then arg2.backgroundStyle.Transparency else 1
            },
            strokeStyle = strokeStyle,
            labelStyle = emphasis
        }, {
            default = Motion.transition(TransitionPreset.Default, { duration = 0.2 }),
            transparency = Motion.transition({ easingStyle = Enum.EasingStyle.Linear, duration = 0.2 })
        }),
        Checked = Motion.createState({
            backgroundStyle = var2,
            strokeStyle = var2,
            labelStyle = emphasis
        }, {
            default = Motion.transition(TransitionPreset.Default, { duration = 0.2 }),
            transparency = Motion.transition({ easingStyle = Enum.EasingStyle.Linear, duration = 0.2 })
        })
    }
end

return useInputMotionStates
