-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)

local console = require(scriptParentParent.Shared).console

local module = {}

local _Shared = require(scriptParentParent.Shared)

local _ReactInternalTypes = require(script.Parent.ReactInternalTypes)

local isPrimaryRenderer = require(script.Parent.ReactFiberHostConfig).isPrimaryRenderer

local tbl1 = {}

local var1 = nil
var1 = ReactGlobals.__DEV__ and {} or var1

function module.markSourceAsDirty(arg1)
    table.insert(tbl1, arg1)
end

function module.resetWorkInProgressVersions()
    for _, value in tbl1 do
        if isPrimaryRenderer then
            value._workInProgressVersionPrimary = nil
        else
            value._workInProgressVersionSecondary = nil
        end
    end
    table.clear(tbl1)
end

function module.getWorkInProgressVersion(arg1)
    return if isPrimaryRenderer then arg1._workInProgressVersionPrimary else arg1._workInProgressVersionSecondary
end

function module.setWorkInProgressVersion(arg1, arg2)
    if isPrimaryRenderer then
        arg1._workInProgressVersionPrimary = arg2
    else
        arg1._workInProgressVersionSecondary = arg2
    end
    table.insert(tbl1, arg1)
end

function module.warnAboutMultipleRenderersDEV(arg1)
    if not ReactGlobals.__DEV__ then
        return
    end

    if isPrimaryRenderer then
        if arg1._currentPrimaryRenderer == nil then
            arg1._currentPrimaryRenderer = var1
            return
        end

        if arg1._currentPrimaryRenderer ~= var1 then
            console.error(
                "Detected multiple renderers concurrently rendering the same mutable source. This is currently unsupported."
            )
        end
    else
        if arg1._currentSecondaryRenderer == nil then
            arg1._currentSecondaryRenderer = var1
            return
        end

        if arg1._currentSecondaryRenderer ~= var1 then
            console.error(
                "Detected multiple renderers concurrently rendering the same mutable source. This is currently unsupported."
            )
        end
    end
end

function module.registerMutableSourceForHydration(arg1, arg2)
    local var2 = arg2._getVersion(arg2._source)

    if arg1.mutableSourceEagerHydrationData ~= nil then
        return
    end

    arg1.mutableSourceEagerHydrationData = { arg2, var2 }
end
return module
