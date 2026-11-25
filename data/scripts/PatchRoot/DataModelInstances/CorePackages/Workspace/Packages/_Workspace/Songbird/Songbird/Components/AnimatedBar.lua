-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Songbird = script:FindFirstAncestor("Songbird")

local Cryo = require(Songbird.Parent.Cryo)
local React = require(Songbird.Parent.React)
local ReactOtter = require(Songbird.Parent.ReactOtter)
local Foundation = require(Songbird.Parent.Foundation)

local useCallback = React.useCallback
local useEffect = React.useEffect
local useTokens = Foundation.Hooks.useTokens

local tbl1 = {
    heightRange = NumberRange.new(0.3, 1),
    width = UDim.new(1, 0),
    isMoving = true,
    staticHeight = 0.5
}

local random = Random.new()

local function AnimatedBar(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local var2 = useTokens()

    local var3 = useCallback(function(): number
        return random:NextNumber(var1.heightRange.Min, var1.heightRange.Max)
    end, { var1.heightRange })

    local var4, var5 = ReactOtter.useAnimatedBinding(var3())

    useEffect(function()
        local bool1 = true

        task.spawn(function()
            while bool1 do
                local var6 = if var1.isMoving then var3() else var1.staticHeight
                var5(ReactOtter.ease(var6, { easingStyle = Enum.EasingStyle.Linear, duration = 0.25 }))

                task.wait(0.25)
            end
        end)

        return function()
            bool1 = false
        end
    end, { var5, var1.isMoving, var1.staticHeight })

    return React.createElement(
        "Frame",
        {
            LayoutOrder = var1.layoutOrder,
            Size = var4:map(function(scale: number): UDim2
                return UDim2.new(var1.width, UDim.new(scale, 0))
            end),
            BorderSizePixel = 0,
            BackgroundColor3 = var2.Color.ActionSubEmphasis.Background.Color3
        },
        {
            Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0.5, 0) })
        }
    )
end

return AnimatedBar
