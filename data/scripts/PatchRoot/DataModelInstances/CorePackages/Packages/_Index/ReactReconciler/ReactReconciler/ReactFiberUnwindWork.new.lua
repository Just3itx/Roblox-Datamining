-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local _ReactInternalTypes = require(script.Parent.ReactInternalTypes)

local _ReactFiberLane = require(script.Parent.ReactFiberLane)

local _ReactFiberSuspenseComponentNew = require(script.Parent["ReactFiberSuspenseComponent.new"])

local resetWorkInProgressVersions = require(script.Parent["ReactMutableSource.new"]).resetWorkInProgressVersions
local ReactWorkTags = require(script.Parent.ReactWorkTags)

local ReactFiberFlags = require(script.Parent.ReactFiberFlags)
local ReactTypeOfMode = require(script.Parent.ReactTypeOfMode)

local ReactFeatureFlags = require(scriptParentParent.Shared).ReactFeatureFlags
local enableSuspenseServerRenderer = ReactFeatureFlags.enableSuspenseServerRenderer
local enableProfilerTimer = ReactFeatureFlags.enableProfilerTimer

local ReactFiberHostContextNew = require(script.Parent["ReactFiberHostContext.new"])
local popHostContainer = ReactFiberHostContextNew.popHostContainer
local popHostContext = ReactFiberHostContextNew.popHostContext

local popSuspenseContext = require(script.Parent["ReactFiberSuspenseContext.new"]).popSuspenseContext

local resetHydrationState = require(script.Parent["ReactFiberHydrationContext.new"]).resetHydrationState
local ReactFiberContextNew = require(script.Parent["ReactFiberContext.new"])
local isContextProvider = ReactFiberContextNew.isContextProvider
local popContext = ReactFiberContextNew.popContext
local popTopLevelContextObject = ReactFiberContextNew.popTopLevelContextObject
local popProvider = require(script.Parent["ReactFiberNewContext.new"]).popProvider

local var1 = nil
local function func1(...)
    var1 = var1 or require(script.Parent["ReactFiberWorkLoop.new"]).popRenderLanes

    return var1(...)
end

local transferActualDuration = require(script.Parent["ReactProfilerTimer.new"]).transferActualDuration

local invariant = require(scriptParentParent.Shared).invariant

function unwindInterruptedWork(arg1)
    if arg1.tag == ReactWorkTags.ClassComponent then
        if (if typeof(arg1.type) == "table" then arg1.type.childContextTypes else nil) ~= nil then
            popContext(arg1)
        end

        return
    end
    if arg1.tag == ReactWorkTags.HostRoot then
        popHostContainer(arg1)
        popTopLevelContextObject(arg1)
        resetWorkInProgressVersions()
    elseif arg1.tag == ReactWorkTags.HostComponent then
        popHostContext(arg1)
    elseif arg1.tag == ReactWorkTags.HostPortal then
        popHostContainer(arg1)
    elseif arg1.tag == ReactWorkTags.SuspenseComponent or arg1.tag == ReactWorkTags.SuspenseListComponent then
        popSuspenseContext(arg1)
    elseif arg1.tag == ReactWorkTags.ContextProvider then
        popProvider(arg1)
    elseif arg1.tag == ReactWorkTags.OffscreenComponent or arg1.tag == ReactWorkTags.LegacyHiddenComponent then
        func1(arg1)
    end
end

return {
    unwindWork = function(nil1: nil, _)
        if nil1.tag == ReactWorkTags.ClassComponent then
            local type = nil1.type
            if isContextProvider(type) then
                popContext(nil1)
            end
            local flags = nil1.flags
            if bit32.band(flags, ReactFiberFlags.ShouldCapture) == 0 then
                return nil
            end

            nil1.flags = bit32.bor(bit32.band(flags, bit32.bnot(ReactFiberFlags.ShouldCapture)), ReactFiberFlags.DidCapture)

            if enableProfilerTimer and bit32.band(nil1.mode, ReactTypeOfMode.ProfileMode) ~= ReactTypeOfMode.NoMode then
                transferActualDuration(nil1)
            end
            return nil1
        end

        if nil1.tag == ReactWorkTags.HostRoot then
            popHostContainer(nil1)
            popTopLevelContextObject(nil1)
            resetWorkInProgressVersions()
            local flags = nil1.flags
            invariant(
                bit32.band(flags, ReactFiberFlags.DidCapture) == ReactFiberFlags.NoFlags,
                "The root failed to unmount after an error. This is likely a bug in React. Please file an issue."
            )

            nil1.flags = bit32.bor(bit32.band(flags, bit32.bnot(ReactFiberFlags.ShouldCapture)), ReactFiberFlags.DidCapture)

            return nil1
        end

        if nil1.tag == ReactWorkTags.HostComponent then
            popHostContext(nil1)
            return nil
        end

        if nil1.tag ~= ReactWorkTags.SuspenseComponent then
            if nil1.tag == ReactWorkTags.SuspenseListComponent then
                popSuspenseContext(nil1)

                return nil
            end

            if nil1.tag == ReactWorkTags.HostPortal then
                popHostContainer(nil1)
                return nil
            end

            if nil1.tag == ReactWorkTags.ContextProvider then
                popProvider(nil1)
                return nil
            end
            if nil1.tag ~= ReactWorkTags.OffscreenComponent and nil1.tag ~= ReactWorkTags.LegacyHiddenComponent then
                return nil
            end

            func1(nil1)
            return nil
        end

        popSuspenseContext(nil1)
        if enableSuspenseServerRenderer then
            local memoizedState = nil1.memoizedState
            if memoizedState ~= nil and memoizedState.dehydrated ~= nil then
                invariant(
                    nil1.alternate ~= nil,
                    "Threw in newly mounted dehydrated component. This is likely a bug in React. Please file an issue."
                )

                resetHydrationState()
            end
        end
        local flags = nil1.flags
        if bit32.band(flags, ReactFiberFlags.ShouldCapture) == 0 then
            return nil
        end

        nil1.flags = bit32.bor(bit32.band(flags, bit32.bnot(ReactFiberFlags.ShouldCapture)), ReactFiberFlags.DidCapture)

        if enableProfilerTimer and bit32.band(nil1.mode, ReactTypeOfMode.ProfileMode) ~= ReactTypeOfMode.NoMode then
            transferActualDuration(nil1)
        end
        return nil1
    end,
    unwindInterruptedWork = unwindInterruptedWork
}
