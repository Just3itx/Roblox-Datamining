-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local getComponentName = require(scriptParentParent.Shared).getComponentName
local ReactWorkTags = require(script.Parent.ReactWorkTags)

local _ReactInternalTypes = require(script.Parent.ReactInternalTypes)

local success, result = pcall(function(): number
    return game:DefineFastInt("ReactMicroprofilerLevel5", 0)
end)
local var1 = if success then result else 0

function noop(...) end

local bool1 = false
local var2 = nil

local num1 = 0

if var1 >= 5 then
    game:GetService("RunService").Heartbeat:Connect(function()
        num1 = 0
    end)
end

local var3 = var1 >= 5 and {
    profilebegin = function(...)
        debug.profilebegin(...)
        num1 += 1
    end,
    profileend = function()
        if num1 > 0 then
            debug.profileend()
            num1 -= 1
        end
    end
} or {
    profilebegin = noop,
    profileend = noop
}

function startTimerSampling(func1: (...any) -> (...any))
    if bool1 then
        warn("RobloxReactProfiling Timer Sampling already running.")
    end
    bool1 = true
    var2 = func1
end

function endTimerSampling()
    bool1 = false
    var2 = nil
end

function getFirstStringKey(memoizedProps)
    for k, _ in memoizedProps do
        if type(k) == "string" then
            return k
        end
    end
    return nil
end

function startTimer(tbl1)
    if bool1 then
        tbl1.startTime = os.clock()
    end
end

function endTimer(tbl1)
    if not bool1 then
        return
    end

    tbl1.endTime = os.clock()
    if var2 then
        var2(tbl1)
    end
end

function profileRootBeforeUnitOfWork(arg1): {endTime: number, id: any, startTime: number}?
    local current = arg1.current
    local var4 = nil

    if current then
        if current.memoizedProps then
            var4 = getFirstStringKey(current.memoizedProps)
        end

        if var4 == nil and current.stateNode and current.stateNode.containerInfo then
            var4 = current.stateNode.containerInfo.Name
        end
    end

    if var4 == "Folder" and current.child then
        local child = current.child
        local firstStringKey = if child.memoizedProps then getFirstStringKey(child.memoizedProps) else nil

        if firstStringKey == nil and child.stateNode and child.stateNode.containerInfo then
            firstStringKey = child.stateNode.containerInfo.Name
        end
        if firstStringKey ~= nil then
            var4 = firstStringKey
        end
    end

    if var4 == nil then
        return nil
    end

    local tbl1 = { id = var4, startTime = 0, endTime = 0 }

    startTimer(tbl1)
    var3.profilebegin(var4)
    return tbl1
end

function profileRootAfterYielding(tbl1)
    if tbl1 then
        endTimer(tbl1)
        var3.profileend()
    end
end

function profileUnitOfWorkBefore(arg1): boolean
    local componentName = getComponentName(arg1.type)

    if arg1.key then
        componentName = tostring(arg1.key) .. "=" .. (componentName or "?")
    end

    local var4 = nil
    if arg1.stateNode and (arg1.tag == ReactWorkTags.HostComponent or arg1.tag == ReactWorkTags.HostText) then
        local layerCollector = arg1.stateNode:FindFirstAncestorWhichIsA("LayerCollector")
        if layerCollector then
            var4 = "[" .. layerCollector:GetFullName() .. "] "
        end
    end

    if var4 then
        componentName = var4 .. " : " .. (componentName or "?")
    end

    if componentName == nil then
        return false
    end

    var3.profilebegin(componentName)
    return true
end

function profileUnitOfWorkAfter(bool2: boolean)
    if bool2 then
        var3.profileend()
    end
end

function profileCommitBefore()
    var3.profilebegin("Commit")
end

function profileCommitAfter()
    var3.profileend()
end

return {
    startTimerSampling = startTimerSampling,
    endTimerSampling = endTimerSampling,
    profileRootBeforeUnitOfWork = if var1 >= 1 then profileRootBeforeUnitOfWork else noop,
    profileRootAfterYielding = if var1 >= 1 then profileRootAfterYielding else noop,
    enableUnitOfWorkProfiling = var1 >= 10,
    profileUnitOfWorkBefore = if var1 >= 10 then profileUnitOfWorkBefore else noop,
    profileUnitOfWorkAfter = if var1 >= 10 then profileUnitOfWorkAfter else noop,
    profileCommitBefore = if var1 >= 5 then profileCommitBefore else noop,
    profileCommitAfter = if var1 >= 5 then profileCommitAfter else noop
}
