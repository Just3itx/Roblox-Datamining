-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)
local _LuauPolyfill = require(scriptParentParent.LuauPolyfill)

local _ReactInternalTypes = require(script.Parent.ReactInternalTypes)

local ReactWorkTags = require(script.Parent.ReactWorkTags)
local HostComponent = ReactWorkTags.HostComponent
local LazyComponent = ReactWorkTags.LazyComponent
local SuspenseComponent = ReactWorkTags.SuspenseComponent
local SuspenseListComponent = ReactWorkTags.SuspenseListComponent
local FunctionComponent = ReactWorkTags.FunctionComponent
local IndeterminateComponent = ReactWorkTags.IndeterminateComponent
local ForwardRef = ReactWorkTags.ForwardRef
local SimpleMemoComponent = ReactWorkTags.SimpleMemoComponent
local ClassComponent = ReactWorkTags.ClassComponent

local ReactComponentStackFrame = require(scriptParentParent.Shared).ReactComponentStackFrame

local describeBuiltInComponentFrame = ReactComponentStackFrame.describeBuiltInComponentFrame

local describeFunctionComponentFrame = ReactComponentStackFrame.describeFunctionComponentFrame
local describeClassComponentFrame = ReactComponentStackFrame.describeClassComponentFrame

local function describeFiber(arg1)
    local type = nil
    if ReactGlobals.__DEV__ then
        local _debugOwner = arg1._debugOwner
        if _debugOwner then
            type = _debugOwner.type
        end
    end

    local _debugSource = if ReactGlobals.__DEV__ then arg1._debugSource else nil

    if arg1.tag == HostComponent then
        return describeBuiltInComponentFrame(arg1.type, _debugSource, type)
    elseif arg1.tag == LazyComponent then
        return describeBuiltInComponentFrame("Lazy", _debugSource, type)
    elseif arg1.tag == SuspenseComponent then
        return describeBuiltInComponentFrame("Suspense", _debugSource, type)
    elseif arg1.tag == SuspenseListComponent then
        return describeBuiltInComponentFrame("SuspenseList", _debugSource, type)
    elseif arg1.tag == FunctionComponent or arg1.tag == IndeterminateComponent or arg1.tag == SimpleMemoComponent then
        return describeFunctionComponentFrame(arg1.type, _debugSource, type)
    elseif arg1.tag == ForwardRef then
        return describeFunctionComponentFrame(arg1.type.render, _debugSource, type)
    elseif arg1.tag == ClassComponent then
        return describeClassComponentFrame(arg1.type, _debugSource, type)
    end
    return ""
end

return {
    getStackByFiberInDevAndProd = function(arg1)
        local success, result = pcall(function()
            local var1 = arg1
            local str1 = ""

            repeat
                str1 ..= describeFiber(var1)
                var1 = var1.return_
            until var1 == nil
            return str1
        end)

        if success then
            return result
        end

        if typeof(result) ~= "table" or not (result.message and result.stack) then
            return "\nError generating stack: " .. tostring(result)
        end

        return "\nError generating stack: " .. result.message .. "\n" .. tostring(result.stack)
    end
}
