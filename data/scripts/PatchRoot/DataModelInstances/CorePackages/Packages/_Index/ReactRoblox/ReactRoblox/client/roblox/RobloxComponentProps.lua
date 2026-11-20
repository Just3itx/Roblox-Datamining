-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionService = game:GetService("CollectionService")
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local ReactGlobals = require(scriptParentParentParentParent.ReactGlobals)
local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Object = LuauPolyfill.Object
local inspect = LuauPolyfill.util.inspect

local __DEV__ = ReactGlobals.__DEV__

local console = require(scriptParentParentParentParent.Shared).console

local React = require(scriptParentParentParentParent.React)
local ReactSymbols = require(scriptParentParentParentParent.Shared).ReactSymbols
local SingleEventManager = require(script.Parent.SingleEventManager)

local Type = require(scriptParentParentParentParent.Shared).Type
local getDefaultInstanceProperty = require(script.Parent.getDefaultInstanceProperty)
local _ReactRobloxHostTypesRoblox = require(script.Parent.Parent["ReactRobloxHostTypes.roblox"])

local Tag = require(scriptParentParentParentParent.React).Tag

local _instanceToEventManager = ({})
local _instanceToBindings = ({})

local function identity(...)
    return ...
end

local function setRobloxInstanceProperty(arg1, arg2, arg3) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg3 == nil then
        local success, _result = pcall(arg1.ResetPropertyToDefault, arg1, arg2)
        if success then
            return
        end

        local className = arg1.ClassName
        local _
        _, arg3 = getDefaultInstanceProperty(className, arg2)
    end

    arg1[arg2] = arg3
end

local function removeBinding(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = _instanceToBindings[arg1]
    if var1 ~= nil then
        var1[arg2]()
        var1[arg2] = nil
    end
end

local function attachBinding(arg1, arg2, arg3)
    local function updateBoundProperty(arg4)
        local success, result = xpcall(setRobloxInstanceProperty, identity, arg1, arg2, arg4)

        if not success then
            local _source = arg3._source or "<enable DEV mode for stack>"
            local str1 = string.format(
                "Error updating binding or ref assigned to key %s of '%s' (%s).\n\nUpdated value:\n  %s\n\nError:\n  %s\n\n%s\n",
                arg2,
                arg1.Name,
                arg1.ClassName,
                tostring(arg4),
                result,
                _source
            )

            console.error(str1)

            error(str1, 0)
        end
    end

    if _instanceToBindings[arg1] == nil then
        _instanceToBindings[arg1] = {}
    end

    _instanceToBindings[arg1][arg2] = React.__subscribeToBinding(arg3, updateBoundProperty)

    updateBoundProperty(arg3:getValue())
end

local function applyTags(instance: Instance, str1: string?, str2: string?)
    if __DEV__ and str2 ~= nil and typeof(str2) ~= "string" then
        console.error(
            "Type provided for ReactRoblox.Tag is invalid - tags should be specified as a single string, with individual tags delimited by spaces. Instead received:\n%s",
            inspect(str2)
        )
        return
    end

    local tbl3 = ({})
    for value in string.gmatch(str1 or "", "%S+") do
        tbl3[value] = true
    end
    local tbl4 = ({})
    for value in string.gmatch(str2 or "", "%S+") do
        tbl4[value] = true
    end

    for value, _ in tbl3 do
        if not tbl4[value] then
            CollectionService:RemoveTag(instance, value)
        end
    end
    for value, _ in tbl4 do
        if not tbl3[value] then
            CollectionService:AddTag(instance, value)
        end
    end
end

local function removeAllTags(instance: Instance) -- Luacid: Inlined by compiler; 2 call sites recovered
    for _, tag in CollectionService:GetTags(instance) do
        CollectionService:RemoveTag(instance, tag)
    end
end

local function applyProp(arg1, arg2, arg3, arg4)
    local var1 = Type.of(arg2)

    if var1 == Type.HostEvent or var1 == Type.HostChangeEvent then
        local var2 = _instanceToEventManager[arg1]
        if var2 == nil then
            var2 = SingleEventManager.new(arg1)
            _instanceToEventManager[arg1] = var2
        end

        local name = arg2.name

        if var1 == Type.HostChangeEvent then
            var2:connectPropertyChange(name, arg3)
            return
        end
        var2:connectEvent(name, arg3)

        return
    end

    local bool1 = typeof(arg3) == "table" and arg3["$$typeof"] == ReactSymbols.REACT_BINDING_TYPE

    if arg4 ~= nil and typeof(arg4) == "table" and arg4["$$typeof"] == ReactSymbols.REACT_BINDING_TYPE then
        removeBinding(arg1, arg2)
    end

    if bool1 then
        attachBinding(arg1, arg2, arg3)
    elseif arg2 == Tag then
        applyTags(arg1, arg4, arg3)
    else
        setRobloxInstanceProperty(arg1, arg2, arg3)
    end
end

local function applyProps(arg1, tbl3)
    for value, value2 in tbl3 do
        if value ~= "ref" and value ~= "children" then
            applyProp(arg1, value, value2)
        end
    end
end

local function safelyApplyProperties(arg1, tbl3, tbl4)
    for i = 1, #tbl3, 2 do
        local var1 = tbl3[i]
        local var2 = tbl3[i + 1]
        if var2 == Object.None then
            var2 = nil
        end

        if var1 ~= "ref" and var1 ~= "children" then
            applyProp(arg1, var1, var2, tbl4[var1])
        end
    end
end

local _success, result = xpcall(function(): boolean
    return game:DefineFastFlag("ReactFixBindingMemoryLeak", false)
end, function(): boolean
    return true
end)

local function cleanupBindings(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = _instanceToBindings[arg1]
    if var1 == nil then
        return
    end

    for _, value in var1 do
        value()
    end

    _instanceToBindings[arg1] = nil
end

return {
    setInitialProperties = function(arg1, _: string, tbl3, _)
        local success, result2 = xpcall(applyProps, identity, arg1, tbl3)

        if not success then
            local str1 = string.format(
                "Error applying initial props to Roblox Instance '%s' (%s):\n  %s\n",
                arg1.Name,
                arg1.ClassName,
                tostring(result2)
            )
            console.error(str1)

            error(str1, 0)
        end

        if _instanceToEventManager[arg1] ~= nil then
            _instanceToEventManager[arg1]:resume()
        end
    end,
    updateProperties = function(arg1, tbl3, tbl4)
        if _instanceToEventManager[arg1] ~= nil then
            _instanceToEventManager[arg1]:suspend()
        end

        local success, result2 = xpcall(safelyApplyProperties, identity, arg1, tbl3, tbl4)

        if not success then
            local str1 = string.format("Error updating props on Roblox Instance '%s' (%s):\n  %s\n", arg1.Name, arg1.ClassName, result2)

            console.error(str1)

            error(str1, 0)
        end

        if _instanceToEventManager[arg1] ~= nil then
            _instanceToEventManager[arg1]:resume()
        end
    end,
    cleanupHostComponent = function(arg1)
        if _instanceToEventManager[arg1] ~= nil then
            _instanceToEventManager[arg1] = nil
        end

        if result then
            cleanupBindings(arg1)
        elseif _instanceToBindings[arg1] ~= nil then
            _instanceToBindings[arg1] = nil
        end

        if typeof(arg1) ~= "Instance" then
            return
        end

        removeAllTags(arg1)

        for _, descendant in arg1:GetDescendants() do
            if _instanceToEventManager[descendant] ~= nil then
                _instanceToEventManager[descendant] = nil
            end

            if result then
                cleanupBindings(descendant)
            elseif _instanceToBindings[descendant] ~= nil then
                _instanceToBindings[descendant] = nil
            end

            removeAllTags(arg1)
        end
    end,
    _instanceToEventManager = _instanceToEventManager,
    _instanceToBindings = _instanceToBindings
}
