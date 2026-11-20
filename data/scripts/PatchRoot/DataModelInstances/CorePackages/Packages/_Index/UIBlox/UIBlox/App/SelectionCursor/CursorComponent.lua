-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")

local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)

local EventConnection = require(scriptParentParentParentParent.ReactUtils).EventConnection

local useStyle = require(scriptParentParentParent.Core.Style.useStyle)

local var1 = React.forwardRef(function(tbl1, ref)
    local var1 = useStyle()
    local Selection = var1.Tokens.Color.Selection
    local reducedMotion = var1.Settings.ReducedMotion
    local colorSequence = ColorSequence.new(
        { ColorSequenceKeypoint.new(0, Selection.Start.Color3), ColorSequenceKeypoint.new(1, Selection.End.Color3) }
    )

    local numberSequence = NumberSequence.new({ NumberSequenceKeypoint.new(0, Selection.Start.Transparency), NumberSequenceKeypoint.new(1, Selection.End.Transparency) })

    local rotation, var3 = React.useBinding(0)
    local var4, var5 = React.useBinding(colorSequence)
    local var6, var7 = React.useBinding(numberSequence)

    return React.createElement("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(-tbl1.offset, -tbl1.offset),
        Size = UDim2.new(1, tbl1.offset * 2, 1, tbl1.offset * 2),
        ref = ref
    }, {
        UICorner = React.createElement("UICorner", { CornerRadius = tbl1.cornerRadius }),
        UIStroke = React.createElement(
            "UIStroke",
            {
                Color = Color3.new(1, 1, 1),
                Transparency = 0,
                Thickness = tbl1.borderWidth
            },
            {
                UIGradient = React.createElement("UIGradient", { Rotation = rotation, Color = var4, Transparency = var6 })
            }
        ),
        HeartbeatConnection = tbl1.isVisible and React.createElement(EventConnection, {
            event = RunService.Heartbeat,
            callback = function(_)
                local var8 = rotation:getValue() + 2
                local colorSequence2 = colorSequence
                local numberSequence2 = numberSequence

                if reducedMotion then
                    local alpha = (math.sin(math.rad(var8)) + 1) / 2

                    local value = colorSequence2.Keypoints[1].Value
                    local value2 = colorSequence2.Keypoints[#colorSequence2.Keypoints].Value
                    colorSequence2 = ColorSequence.new(value:Lerp(value2, alpha))

                    local value3 = numberSequence2.Keypoints[1].Value
                    local value4 = numberSequence2.Keypoints[#numberSequence2.Keypoints].Value
                    numberSequence2 = NumberSequence.new(value3 + (value4 - value3) * alpha)
                end

                var3(var8)
                var5(colorSequence2)
                var7(numberSequence2)
            end
        })
    })
end)

return React.memo(var1)
