-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoactUtils = script:FindFirstAncestor("RoactUtils")
local RoactUtilsParent = RoactUtils.Parent
local React = require(RoactUtilsParent.React)

local _types = require(RoactUtils.types)

local bool1 = game:DefineFastFlag("LuaAppLazyComponentAsyncChunkLoad", false)

local function createLazyComponent(callback: (...any) -> (...any))
    local var1 = React.memo(function(arg1)
        if not bool1 then
            local var1 = React.useMemo(callback, {})
            return React.createElement(var1, arg1)
        end

        local var1, var2 = React.useState({ state = "idle" })

        if var1.state ~= "idle" then
            if var1.state == "failed" then
                error(var1.error, 0)
            elseif var1.state == "pending" then
                return nil
            end

            return React.createElement(var1.component, arg1)
        end

        task.spawn(function()
            var2({ state = "pending" })
            local success, result = pcall(callback)
            if success then
                var2({ state = "resolved", component = result })
                return
            end
            var2({ state = "failed", error = result })
        end)

        return nil
    end)

    return function(arg1)
        return React.createElement(var1, arg1)
    end
end

return createLazyComponent
