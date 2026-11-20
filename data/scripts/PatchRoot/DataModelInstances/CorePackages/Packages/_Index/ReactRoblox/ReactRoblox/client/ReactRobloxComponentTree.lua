-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _ReactRobloxHostTypesRoblox = require(script.Parent["ReactRobloxHostTypes.roblox"])

local _ReactReconciler = require(scriptParentParentParent.ReactReconciler)

local Shared = require(scriptParentParentParent.Shared)

local ReactWorkTags = nil
local HostComponent = nil
local var1 = nil
local var2 = nil
local var3 = nil

local getParentSuspenseInstance = nil
local invariant = Shared.invariant

local module = {}

local tbl1 = ({})

local tbl2 = ({})
local tbl3 = ({})

local str1 = string.sub(tostring(math.random()), 3)
local str2 = "__reactFiber$" .. str1
local str3 = "__reactContainer$" .. str1

function module.precacheFiberNode(arg1, arg2)
    tbl2[arg2] = arg1
end

function module.uncacheFiberNode(arg1)
    tbl2[arg1] = nil
    tbl3[arg1] = nil
end

function module.markContainerAsRoot(arg1, arg2)
    tbl1[arg2] = arg1
end

function module.unmarkContainerAsRoot(arg1)
    tbl1[arg1] = nil
end

function module.isContainerMarkedAsRoot(arg1): boolean
    return not not tbl1[arg1]
end

function module.getClosestInstanceFromNode(arg1)
    local var4 = tbl2[arg1]
    if var4 then
        return var4
    end

    local parent = arg1.Parent

    while parent do
        local var5 = tbl2[parent]
        if var5 then
            local alternate = var5.alternate

            if var5.child ~= nil or alternate ~= nil and alternate.child ~= nil then
                if getParentSuspenseInstance == nil then
                    getParentSuspenseInstance = require(script.Parent.ReactRobloxHostConfig).getParentSuspenseInstance
                end

                local parentSuspenseInstance = getParentSuspenseInstance(arg1)

                while parentSuspenseInstance ~= nil do
                    local var6 = tbl2[parentSuspenseInstance]
                    if var6 then
                        return var6
                    end

                    parentSuspenseInstance = getParentSuspenseInstance(parentSuspenseInstance)
                end
            end

            return var5
        end

        local parent2 = parent.Parent
        arg1 = parent
        parent = parent2
    end
    return nil
end

function module.getInstanceFromNode(arg1)
    if ReactWorkTags == nil then
        ReactWorkTags = require(script.Parent.Parent["ReactReconciler.roblox"]).ReactWorkTags

        HostComponent = ReactWorkTags.HostComponent
        if Shared.ReactFeatureFlags.fixGetInstanceFromNode then
            var1 = ReactWorkTags.HostText
            var2 = ReactWorkTags.HostRoot
            var3 = ReactWorkTags.SuspenseComponent
        else
            var1 = ReactWorkTags.HostComponent
            var2 = ReactWorkTags.HostComponent
            var3 = ReactWorkTags.HostComponent
        end
    end

    local var4 = if Shared.ReactFeatureFlags.fixGetInstanceFromNode then tbl2[arg1] or tbl1[arg1] else arg1[str2] or arg1[str3]

    if var4 then
        if var4.tag == HostComponent or var4.tag == var1 or var4.tag == var3 or var4.tag == var2 then
            return var4
        end

        return nil
    end

    return nil
end

function module.getNodeFromInstance(arg1)
    if arg1.tag == HostComponent or arg1.tag == var1 then
        return arg1.stateNode
    end

    invariant(false, "getNodeFromInstance: Invalid argument.")

    error("getNodeFromInstance: Invalid argument.")
end

function module.getFiberCurrentPropsFromNode(arg1)
    return tbl3[arg1]
end

function module.updateFiberProps(arg1, arg2)
    tbl3[arg1] = arg2
end

return module
