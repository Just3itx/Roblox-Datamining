-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:31:26Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local Dash = require(FoundationParent.Dash)
local _React = require(FoundationParent.React)

local ColorInputMode = require(Foundation.Enums.ColorInputMode)

return {
    createInputConfigs = function(arg1, arg2, value, arg3, handler: (...any) -> (...any), handler2: (...any) -> (...any), handler3: (...any) -> (...any), handler4: (...any) -> (...any), _)
        local var1 = Dash.map({ "R", "G", "B" }, function(key: string)
            return {
                key = key,
                component = key:lower(),
                value = arg1:map(function(arg5)
                    return arg5[key:lower()]
                end),
                handler = handler,
                minimum = 0,
                maximum = 255,
                step = 1
            }
        end)

        local var2 = table.clone(var1)
        table.insert(
            var2,
            {
                key = "A",
                value = arg3,
                handler = handler4,
                minimum = 0,
                maximum = 1,
                step = 0.01,
                precision = 3
            }
        )

        local var3 = Dash.map({ "H", "S", "V" }, function(key: string)
            return {
                key = key,
                component = key:lower(),
                value = arg2:map(function(arg5)
                    return arg5[key:lower()]
                end),
                handler = handler2,
                minimum = 0,
                maximum = if key == "H" then 360 else nil
            }
        end)
        local tbl1 = {{
            key = tostring(ColorInputMode.Hex),
            value = value,
            handler = handler3,
            placeholder = "#000000",
            width = UDim.new(1, 0)
        }}

        return {
            [ColorInputMode.RGB] = var1,
            [ColorInputMode.RGBA] = var2,
            [ColorInputMode.HSV] = var3,
            [ColorInputMode.Hex] = tbl1
        }
    end
}
