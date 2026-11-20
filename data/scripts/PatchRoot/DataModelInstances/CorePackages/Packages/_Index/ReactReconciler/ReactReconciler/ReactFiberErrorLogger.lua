-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:30:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)

local inspect = LuauPolyfill.util.inspect
local setTimeout = LuauPolyfill.setTimeout

local Shared = require(scriptParentParent.Shared)
local console = Shared.console
local errorToString = Shared.errorToString

local _ReactInternalTypes = require(script.Parent.ReactInternalTypes)

local _ReactCapturedValue = require(script.Parent.ReactCapturedValue)

local showErrorDialog = require(script.Parent.ReactFiberErrorDialog).showErrorDialog
local ClassComponent = require(script.Parent.ReactWorkTags).ClassComponent
local getComponentName = require(scriptParentParent.Shared).getComponentName

local module = {}

function module.logCapturedError(arg1, arg2)
    local success, result = pcall(function()
        if showErrorDialog(arg1, arg2) == false then
            return nil
        end

        local value = arg2.value
        if ReactGlobals.__DEV__ then
            local source = arg2.source
            local stack = arg2.stack or ""

            if value ~= nil and value._suppressLogging then
                if arg1.tag == ClassComponent then
                    return
                end

                console.error(value)
            end

            local componentName = if source == nil then nil else getComponentName(source.type)
            local str1 = if componentName then "The above error occurred in the <" .. tostring(componentName) .. "> component:" else "The above error occurred in one of your React components:"

            local componentName2 = getComponentName(arg1.type)
            local var1 = str1
                .. "\n"
                    .. stack
                        .. "\n\n"
                            .. (if componentName2 then "React will try to recreate this component tree from scratch " .. "using the error boundary you provided, " .. componentName2 .. "." else "Consider adding an error boundary to your tree to customize error handling behavior.\nVisit https://reactjs.org/link/error-boundaries to learn more about error boundaries.")

            console.error(var1)
        else
            console.error(inspect(value))
        end

        return nil
    end)

    if not success then
        warn("failed to error with error: " .. inspect(result))

        setTimeout(function()
            error(errorToString(result))
        end)
    end
end

return module
