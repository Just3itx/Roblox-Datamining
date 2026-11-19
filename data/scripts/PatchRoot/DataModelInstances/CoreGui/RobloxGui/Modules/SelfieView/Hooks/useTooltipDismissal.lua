-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local UserInputService = game:GetService("UserInputService")
local Packages = CorePackages.Packages
local React = require(Packages.React)
local LuauPolyfill = require(Packages.LuauPolyfill)
local setTimeout = LuauPolyfill.setTimeout
local clearTimeout = LuauPolyfill.clearTimeout

local function isClickOrTap(input: InputObject): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch
end

return function(num1: number)
    local var1, var2 = React.useState("")
    local var3, var4 = React.useState("")
    local var5, var6 = React.useState(false)
    local var7 = React.useRef(nil)
    local var8 = React.useRef(nil)
    local var9 = React.useCallback(function()
        if var8.current then
            clearTimeout(var8.current)
        end
        if var7.current then
            var7.current:Disconnect()
            var7.current = nil
        end
    end, { var8, var7 })
    local var10 = React.useCallback(function()
        var9()
        var6(true)

        var8.current = setTimeout(function()
            var9()
            var6(false)
        end, num1)

        var7.current = UserInputService.InputBegan:Connect(function(input: InputObject, _: boolean)
            if not isClickOrTap(input) then
                return
            end
            var9()
            var6(false)
        end)
    end, { var8, var7 })

    React.useEffect(function()
        return var9
    end, {})

    return var1, var3, var5, (React.useCallback(function(str1: string, str2: string)
        var2(str1)
        var4(str2)
        var10()
    end, {}))
end
