-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecyclerRoblox = script:FindFirstAncestor("ViewRecyclerRoblox")
local ViewRecycler = require(ViewRecyclerRoblox.Parent.ViewRecycler)

local transparentFrame = require(ViewRecyclerRoblox.RobloxAdapter.transparentFrame)

local Axis = ViewRecycler.Axis

local module = {}

function module.new()
    local instance = transparentFrame("ViewRecyclerEndLimit")
    local var2 = transparentFrame("Spacer")
    var2.Parent = instance

    return {
        instance = instance,
        place = function(arg1, arg2, arg3, arg4, zIndex)
            local num1 = math.max(0, arg4 - arg3)
            if arg2 == Axis.X then
                instance.AnchorPoint = Vector2.xAxis
                instance.Position = UDim2.fromOffset(arg4, 0)
                instance.Size = UDim2.fromScale(0, 1)
                instance.AutomaticSize = Enum.AutomaticSize.X
                var2.Size = UDim2.fromOffset(num1, 0)
            else
                instance.AnchorPoint = Vector2.yAxis
                instance.Position = UDim2.fromOffset(0, arg4)
                instance.Size = UDim2.fromScale(1, 0)
                instance.AutomaticSize = Enum.AutomaticSize.Y
                var2.Size = UDim2.fromOffset(0, num1)
            end
            instance.ZIndex = zIndex
            instance.Parent = arg1
        end,
        destroy = function()
            instance:Destroy()
        end
    }
end

return module
