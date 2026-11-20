-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local __DEV__ = require(scriptParentParent.ReactGlobals).__DEV__

local _ReactInternalTypes = require(script.Parent.ReactInternalTypes)

local ReactSharedInternals = require(scriptParentParent.Shared).ReactSharedInternals
local getStackByFiberInDevAndProd = require(script.Parent.ReactFiberComponentStack).getStackByFiberInDevAndProd
local getComponentName = require(scriptParentParent.Shared).getComponentName

local ReactDebugCurrentFrame = ReactSharedInternals.ReactDebugCurrentFrame

local module = { current = nil, isRendering = false }

function module.getCurrentFiberOwnerNameInDevOrNull()
    if __DEV__ then
        if module.current == nil then
            return nil
        end

        local _debugOwner = module.current._debugOwner
        if _debugOwner then
            return getComponentName(_debugOwner.type)
        end
    end
    return nil
end

local function getCurrentFiberStackInDev()
    if __DEV__ then
        if module.current == nil then
            return ""
        end

        return getStackByFiberInDevAndProd(module.current)
    end
    return ""
end

function module.resetCurrentFiber()
    if __DEV__ then
        ReactDebugCurrentFrame.getCurrentStack = nil
        module.current = nil
        module.isRendering = false
    end
end

function module.setCurrentFiber(current)
    if __DEV__ then
        ReactDebugCurrentFrame.getCurrentStack = getCurrentFiberStackInDev
        module.current = current
        module.isRendering = false
    end
end

function module.setIsRendering(isRendering: boolean)
    if __DEV__ then
        module.isRendering = isRendering
    end
end

function module.getIsRendering(): boolean
    return if __DEV__ then module.isRendering else false
end

return module
