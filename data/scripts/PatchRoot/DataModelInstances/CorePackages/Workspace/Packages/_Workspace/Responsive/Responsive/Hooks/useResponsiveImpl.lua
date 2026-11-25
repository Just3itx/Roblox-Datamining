-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:11:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ResponsiveParent = script:FindFirstAncestor("Responsive").Parent
local React = require(ResponsiveParent.React)
local Responsive = require(script.Parent.Parent.Responsive)
local ContainerRef = require(script.Parent.Parent.Context.ContainerRef)

local bool1 = game:DefineFastFlag("LuaAppResponsiveFixHookDeps", false)

function id<T>(arg1: T): T
    return arg1
end

function useResponsiveImpl(arg1, arg2, str1: string?)
    local var1 = if typeof(arg1) == "function" then arg1 else id
    local var2 = React.useContext(ContainerRef)
    local var3, var4 = React.useState(var1(Responsive.DefaultKey))
    local var5 = React.useRef("")
    local var6 = React.useRef({ Key = Responsive.DefaultKey })

    local var7 = nil
    if typeof(arg1) == "table" then
        var7 = {}
        for _, value in arg1 do
            var7[value] = true
        end
    end

    local useEffect = React.useEffect
    local function func1()
        if not (var2 and var2.current) then
            return function() end
        end

        local var8 = Responsive.bindContainer(var2.current, arg2)
        local connection = var8:connect(function()
            local current = var8:currentKey(str1)
            if var7 then
                if var7[current] or var5.current and var7[var5.current] then
                    var6.current = var8:currentRule(str1)
                    var4(current)
                end
            else
                var6.current = var8:currentRule(str1)
                var4(var1(current))
            end
            var5.current = current
        end)

        var6.current = var8:currentRule(str1)
        local current = var8:currentKey(str1)
        var4(var1(current))
        var5.current = current

        return function()
            connection:disconnect()
            var8:destroy()
        end
    end

    local current = if var2 then var2.current or false else false
    local var8 = if bool1 then arg2 else nil
    local var9 = if bool1 then str1 else nil
    useEffect(func1, { var2, current, var8, var9 })

    return var3, var6.current
end

return useResponsiveImpl
