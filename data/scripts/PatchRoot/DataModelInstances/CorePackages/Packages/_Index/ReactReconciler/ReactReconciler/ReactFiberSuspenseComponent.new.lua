-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local _Shared = require(scriptParentParent.Shared)

local _ReactInternalTypes = require(script.Parent.ReactInternalTypes)

local ReactFiberHostConfig = require(script.Parent.ReactFiberHostConfig)

local _ReactFiberLane = require(script.Parent.ReactFiberLane)

local ReactWorkTags = require(script.Parent.ReactWorkTags)
local SuspenseComponent = ReactWorkTags.SuspenseComponent
local SuspenseListComponent = ReactWorkTags.SuspenseListComponent
local ReactFiberFlags = require(script.Parent.ReactFiberFlags)
local NoFlags = ReactFiberFlags.NoFlags
local DidCapture = ReactFiberFlags.DidCapture
local isSuspenseInstancePending = ReactFiberHostConfig.isSuspenseInstancePending
local isSuspenseInstanceFallback = ReactFiberHostConfig.isSuspenseInstanceFallback

local module = {}

function module.shouldCaptureSuspense(arg1, bool1: boolean): boolean
    local memoizedState = arg1.memoizedState
    if memoizedState then
        return memoizedState.dehydrated ~= nil
    end
    local memoizedProps = arg1.memoizedProps

    return not (memoizedProps.fallback == nil) and (not (memoizedProps.unstable_avoidThisFallback == true) or not bool1)
end

function module.findFirstSuspended(arg1)
    local var1 = arg1

    while true do
        if arg1 == nil then
            return nil
        end

        if arg1.tag == SuspenseComponent then
            local memoizedState = arg1.memoizedState
            if memoizedState then
                local dehydrated = memoizedState.dehydrated
                if dehydrated == nil or isSuspenseInstancePending(dehydrated) or isSuspenseInstanceFallback(dehydrated) then
                    return arg1
                end
            end
        elseif arg1.tag == SuspenseListComponent and arg1.memoizedProps.revealOrder ~= nil then
            if bit32.band(arg1.flags, DidCapture) ~= NoFlags then
                return arg1
            end
        elseif arg1.child ~= nil then
            arg1.child.return_ = arg1
            arg1 = arg1.child
            continue
        end

        if arg1 == var1 then
            return nil
        end
        while arg1.sibling == nil do
            if arg1.return_ == nil or arg1.return_ == var1 then
                return nil
            end

            arg1 = arg1.return_
        end

        arg1.sibling.return_ = arg1.return_
        arg1 = arg1.sibling
    end
end
return module
