-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecyclerRoblox = script:FindFirstAncestor("ViewRecyclerRoblox")
local ViewRecycler = require(ViewRecyclerRoblox.Parent.ViewRecycler)

local module = {}

function module.connect(arg1, arg2, arg3)
    local bool1 = false

    local function synchronize()
        if bool1 then
            return
        end
        local scrollBarThickness = arg1.ScrollBarThickness
        arg2.Position = UDim2.fromOffset(
            if arg3 ~= ViewRecycler.Axis.Y or arg1.VerticalScrollBarPosition ~= Enum.VerticalScrollBarPosition.Left then 0 else scrollBarThickness,
            0
        )
        local var1 = arg2
        var1.Size = if arg3 == ViewRecycler.Axis.X then UDim2.new(1, 0, 1, -scrollBarThickness) else UDim2.new(1, -scrollBarThickness, 1, 0)
    end

    synchronize()
    local connection = arg1:GetPropertyChangedSignal("ScrollBarThickness"):Connect(synchronize)
    local connection2 = arg1:GetPropertyChangedSignal("VerticalScrollBarPosition"):Connect(synchronize)

    return function()
        if bool1 then
            return
        end
        bool1 = true
        connection:Disconnect()
        connection2:Disconnect()
    end
end

return module
