-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function unimplemented(str1: string) -- Luacid: Inlined by compiler; 11 call sites recovered
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    print("UNIMPLEMENTED ERROR: " .. tostring(str1))
    error("FIXME (roblox): " .. str1 .. " is unimplemented", 2)
end

local CollectionService = game:GetService("CollectionService")
local scriptParentParentParent = script.Parent.Parent.Parent
local ReactGlobals = require(scriptParentParentParent.ReactGlobals)
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local inspect = LuauPolyfill.util.inspect
local console = require(scriptParentParentParent.Shared).console
local Object = LuauPolyfill.Object
local setTimeout = LuauPolyfill.setTimeout
local clearTimeout = LuauPolyfill.clearTimeout

local _ReactRobloxHostTypesRoblox = require(script.Parent["ReactRobloxHostTypes.roblox"])

local ReactRobloxComponentTree = require(script.Parent.ReactRobloxComponentTree)
local precacheFiberNode = ReactRobloxComponentTree.precacheFiberNode
local uncacheFiberNode = ReactRobloxComponentTree.uncacheFiberNode
local updateFiberProps = ReactRobloxComponentTree.updateFiberProps

local ReactRobloxComponent = require(script.Parent.ReactRobloxComponent)

local setInitialProperties = ReactRobloxComponent.setInitialProperties
local diffProperties = ReactRobloxComponent.diffProperties
local updateProperties = ReactRobloxComponent.updateProperties
local cleanupHostComponent = ReactRobloxComponent.cleanupHostComponent

local enableCreateEventHandleAPI = require(scriptParentParentParent.Shared).ReactFeatureFlags.enableCreateEventHandleAPI

local function recursivelyUncacheFiberNode(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if typeof(arg1) ~= "Instance" then
        return
    end

    uncacheFiberNode(arg1)

    for _, descendant in arg1:GetDescendants() do
        uncacheFiberNode(descendant)
    end
end

local module = {}
Object.assign(module, require(scriptParentParentParent.Shared).ReactFiberHostConfig.WithNoPersistence)

function module.getRootHostContext(arg1)
    return arg1.ClassName
end

function module.getChildHostContext<T>(arg1: T, _: string, _): T
    return arg1
end

function module.getPublicInstance<T>(arg1: T): T
    return arg1
end

function module.prepareForCommit(_)
    if enableCreateEventHandleAPI then
        unimplemented("enableCreateEventHandleAPI")
    end

    return nil
end

function module.beforeActiveInstanceBlur()
    if enableCreateEventHandleAPI then
        unimplemented("enableCreateEventHandleAPI")
    end
end

function module.afterActiveInstanceBlur()
    if enableCreateEventHandleAPI then
        unimplemented("enableCreateEventHandleAPI")
    end
end

function module.resetAfterCommit(_) end

function module.createInstance(className: string, arg1, _, _, tbl1): Instance
    local instance = Instance.new(className)

    if tbl1.key then
        instance.Name = tbl1.key
    else
        local _return = tbl1.return_
        while _return do
            if _return.key then
                instance.Name = _return.key
                break
            end

            _return = _return.return_
        end
    end

    precacheFiberNode(tbl1, instance)
    updateFiberProps(instance, arg1)

    return instance
end

function module.appendInitialChild(arg1, arg2)
    arg2.Parent = arg1
end

function module.finalizeInitialChildren(arg1, str1: string, arg2, arg3, _): boolean
    setInitialProperties(arg1, str1, arg2, arg3)
    return false
end

function module.prepareUpdate(arg1, str1: string, arg2, arg3, arg4, _)
    return diffProperties(arg1, str1, arg2, arg3, arg4)
end

function module.shouldSetTextContent(_: string, _): boolean
    return false
end

function module.createTextInstance(_: string, _, _, _)
    unimplemented("createTextInstance")
    return nil
end

module.isPrimaryRenderer = true
module.warnsIfNotActing = true

module.scheduleTimeout = setTimeout
module.cancelTimeout = clearTimeout
module.noTimeout = -1

module.supportsMutation = true

module.supportsChildOrdering = false

function module.commitMount(_, _: string, _, _)
    unimplemented("commitMount")
end

function module.commitUpdate(arg1, tbl1, _: string, arg2, arg3, _)
    updateFiberProps(arg1, arg3)

    updateProperties(arg1, tbl1, arg2)
end

local function checkTags(arg1)
    if typeof(arg1) ~= "Instance" then
        console.warn("Could not check tags on non-instance %s.", inspect(arg1))
        return
    end
    if not arg1:IsDescendantOf(game) and #CollectionService:GetTags(arg1) > 0 then
        console.warn(
            "Tags applied to orphaned %s \"%s\" cannot be accessed via CollectionService:GetTagged. If you're relying on tag behavior in a unit test, consider mounting your test root into the DataModel.",
            arg1.ClassName,
            arg1.Name
        )
    end
end

function module.appendChild(arg1, arg2)
    arg2.Parent = arg1

    if ReactGlobals.__DEV__ then
        checkTags(arg2)
    end
end

function module.appendChildToContainer(arg1, arg2)
    module.appendChild(arg1, arg2)
end

function module.insertBefore(arg1, arg2, _)
    arg2.Parent = arg1

    if ReactGlobals.__DEV__ then
        checkTags(arg2)
    end
end

function module.insertInContainerBefore(arg1, arg2, arg3)
    module.insertBefore(arg1, arg2, arg3)
end

function module.removeChild(_, arg1)
    recursivelyUncacheFiberNode(arg1)
    cleanupHostComponent(arg1)

    arg1.Parent = nil

    arg1:Destroy()
end

function module.removeChildFromContainer(arg1, arg2)
    module.removeChild(arg1, arg2)
end

function module.clearSuspenseBoundary(_, _)
    unimplemented("clearSuspenseBoundary")
end

function module.clearSuspenseBoundaryFromContainer(_, _)
    unimplemented("clearSuspenseBoundaryFromContainer")
end

function module.hideInstance(_)
    unimplemented("hideInstance")
end

function module.hideTextInstance(_)
    unimplemented("hideTextInstance")
end

function module.unhideInstance(_, _)
    unimplemented("unhideInstance")
end

function module.unhideTextInstance(_, _: string)
    unimplemented("unhideTextInstance")
end

function module.clearContainer(arg1)
    for _, child in arg1:GetChildren() do
        module.removeChild(arg1, child)
    end
end

function module.preparePortalMount(_) end

return module
