-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T12:00:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsCallingParent = script:FindFirstAncestor("FriendsCalling").Parent

local RunService = game:GetService("RunService")

local Foundation = require(FriendsCallingParent.Foundation)
local React = require(FriendsCallingParent.React)
local ReactUtils = require(FriendsCallingParent.ReactUtils)

local View = Foundation.View
local useEventConnection = ReactUtils.useEventConnection
local useTokens = Foundation.Hooks.useTokens

local function RingingIndicator(tbl1)
    local var1 = useTokens()
    local var2, var3 = React.useBinding(0)

    useEventConnection(RunService.Heartbeat, function(num1: number)
        var3((var2:getValue() + num1) % 1.2)
    end)

    local default = var1.Color.Content.Default
    local var4 = React.useMemo(function()
        return var2:map(function(num1: number): number
            return math.floor(num1 / 1.2 * 3) + 1
        end)
    end, { var2 })
    local var5 = React.useMemo(function()
        local result = ({})
        for layoutOrder = 1, 3 do
            local str1 = `Dot{layoutOrder}`

            result[str1] = React.createElement(View, {
                LayoutOrder = layoutOrder,
                Size = UDim2.fromOffset(3, 3),
                backgroundStyle = var4:map(function(num1: number)
                    return {
                        Color3 = default.Color3,
                        Transparency = if num1 ~= layoutOrder then 0.7 else default.Transparency
                    }
                end),
                tag = "radius-circle"
            })
        end

        return result
    end, { var4, default })

    return React.createElement(View, {
        LayoutOrder = tbl1.LayoutOrder,
        tag = "row align-x-center align-y-center gap-xxsmall size-400-400",
        testId = tbl1.testId
    }, var5)
end

return RingingIndicator
