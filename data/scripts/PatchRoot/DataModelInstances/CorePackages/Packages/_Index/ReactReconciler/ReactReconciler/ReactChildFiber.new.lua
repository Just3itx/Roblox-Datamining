-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Error = LuauPolyfill.Error

local console = require(scriptParentParent.Shared).console
local describeError = require(scriptParentParent.Shared).describeError

local __DEV__ = ReactGlobals.__DEV__

local var1 = require(scriptParentParent.SafeFlags).createGetFFlag("ReactPreventAssigningKeyToChildren")()

local _Shared = require(scriptParentParent.Shared)

local _React = require(scriptParentParent.React)

local _ReactInternalTypes = require(script.Parent.ReactInternalTypes)

local _ReactFiberLane = require(script.Parent.ReactFiberLane)

local getComponentName = require(scriptParentParent.Shared).getComponentName
local ReactFiberFlags = require(script.Parent.ReactFiberFlags)
local Placement = ReactFiberFlags.Placement
local Deletion = ReactFiberFlags.Deletion
local ReactSymbols = require(scriptParentParent.Shared).ReactSymbols
local getIteratorFn = ReactSymbols.getIteratorFn
local REACT_ELEMENT_TYPE = ReactSymbols.REACT_ELEMENT_TYPE
local REACT_FRAGMENT_TYPE = ReactSymbols.REACT_FRAGMENT_TYPE
local REACT_PORTAL_TYPE = ReactSymbols.REACT_PORTAL_TYPE
local REACT_LAZY_TYPE = ReactSymbols.REACT_LAZY_TYPE
local REACT_BLOCK_TYPE = ReactSymbols.REACT_BLOCK_TYPE
local ReactWorkTags = require(script.Parent.ReactWorkTags)
local _FunctionComponent = ReactWorkTags.FunctionComponent
local _ClassComponent = ReactWorkTags.ClassComponent
local HostText = ReactWorkTags.HostText
local HostPortal = ReactWorkTags.HostPortal
local _ForwardRef = ReactWorkTags.ForwardRef
local Fragment = ReactWorkTags.Fragment
local _SimpleMemoComponent = ReactWorkTags.SimpleMemoComponent
local Block = ReactWorkTags.Block
local invariant = require(scriptParentParent.Shared).invariant
local ReactFeatureFlags = require(scriptParentParent.Shared).ReactFeatureFlags

local enableLazyElements = ReactFeatureFlags.enableLazyElements
local enableBlocksAPI = ReactFeatureFlags.enableBlocksAPI

local ReactFiberNew = require(script.Parent["ReactFiber.new"])
local createWorkInProgress = ReactFiberNew.createWorkInProgress
local resetWorkInProgress = ReactFiberNew.resetWorkInProgress
local createFiberFromElement = ReactFiberNew.createFiberFromElement
local createFiberFromFragment = ReactFiberNew.createFiberFromFragment
local createFiberFromText = ReactFiberNew.createFiberFromText
local createFiberFromPortal = ReactFiberNew.createFiberFromPortal

local isCompatibleFamilyForHotReloading = require(script.Parent["ReactFiberHotReloading.new"]).isCompatibleFamilyForHotReloading

local module = {}

local bool1 = nil

local var2 = nil
local var3 = nil
local function func1(_, _) end

if __DEV__ then
    bool1 = false

    var2 = {}
    var3 = {}

    func1 = function(arg1, arg2)
        if arg1 == nil or type(arg1) ~= "table" or not arg1._store or arg1._store.validated or arg1.key ~= nil then
            return
        end

        local var4 = invariant
        local bool2 = not (arg1._store == nil) and type(arg1._store) == "table"
        var4(
            bool2,
            "React Component in warnForMissingKey should have a _store. This error is likely caused by a bug in React. Please file an issue."
        )

        arg1._store.validated = true

        local componentName = getComponentName(arg2.type) or "Component"

        if var2[componentName] then
            return
        end
        var2[componentName] = true

        console.error(
            "Each child in a list should have a unique \"key\" prop. See https://reactjs.org/link/warning-keys for more information."
        )
    end
end

local isArray = Array.isArray

function coerceRef(_return, _, arg1)
    local ref = arg1.ref
    if ref ~= nil and type(ref) == "string" then
        if not arg1._owner or not arg1._self or arg1._owner.stateNode == arg1._self then
            local var4 = if __DEV__ then getComponentName(_return.type) or "Component" else "<enable __DEV__ mode for component names>"

            error(
                Error.new(
                    string.format(
                        "Component \"%s\" contains the string ref \"%s\". Support for string refs has been removed. We recommend using useRef() or createRef() instead. Learn more about using refs safely here: https://reactjs.org/link/strict-mode-string-ref",
                        var4,
                        tostring(ref)
                    )
                )
            )
        end

        if not arg1._owner then
            error("Expected ref to be a function or an object returned by React.createRef(), or nil.")
        end
    end

    return ref
end

local function warnOnFunctionType(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
    if not __DEV__ then
        return
    end

    local componentName = getComponentName(arg1.type) or "Component"

    if var3[componentName] then
        return
    end
    var3[componentName] = true

    console.error(
        "Functions are not valid as a React child. This may happen if you return a Component instead of <Component /> from render. Or maybe you meant to call this function rather than return it."
    )
end

function resolveLazyType(arg1)
    local _payload = arg1._payload
    local success, result = xpcall(arg1._init, describeError, _payload)
    return if success then result else arg1
end

local function ChildReconciler(bool2: boolean)
    local function deleteChild(arg1, arg2) -- Luacid: Inlined by compiler; 17 call sites recovered
        if not bool2 then
            return
        end
        local deletions = arg1.deletions
        if deletions ~= nil then
            table.insert(deletions, arg2)

            return
        end

        arg1.deletions = { arg2 }
        arg1.flags = bit32.bor(arg1.flags, Deletion)
    end
    local function deleteRemainingChildren(arg1, arg2) -- Luacid: unused: defined but never referenced
        if not bool2 then
            return nil
        end

        while arg2 ~= nil do
            deleteChild(arg1, arg2)
            arg2 = arg2.sibling
        end
        return nil
    end

    local function mapRemainingChildren(_, arg1)
        local result = {}

        while arg1 ~= nil do
            if arg1.key ~= nil then
                result[arg1.key] = arg1
            else
                result[arg1.index] = arg1
            end
            arg1 = arg1.sibling
        end
        return result
    end

    local function useFiber(arg1, arg2) -- Luacid: Inlined by compiler; 5 call sites recovered
        local workInProgress = createWorkInProgress(arg1, arg2)

        workInProgress.index = 1
        if ReactFeatureFlags.enableWorkLoopTrims then
            if workInProgress.sibling ~= nil then
                workInProgress.sibling = nil
                return workInProgress
            end
        else
            workInProgress.sibling = nil
        end
        return workInProgress
    end

    local function placeChild(arg1, num1: number, index: number) -- Luacid: Inlined by compiler; 6 call sites recovered
        arg1.index = index
        if not bool2 then
            return num1
        end
        local alternate = arg1.alternate
        if alternate == nil then
            arg1.flags = bit32.bor(arg1.flags, Placement)
            return num1
        end

        local index2 = alternate.index
        if not (index2 < num1) then
            return index2
        end

        arg1.flags = bit32.bor(arg1.flags, Placement)
        return num1
    end

    local function placeSingleChild(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
        if bool2 and arg1.alternate == nil then
            arg1.flags = bit32.bor(arg1.flags, Placement)
        end
        return arg1
    end

    local function updateTextNode(_return, arg1, str1: string, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
        if arg1 == nil or arg1.tag ~= HostText then
            local fiberFromText = createFiberFromText(str1, _return.mode, arg2)
            fiberFromText.return_ = _return
            return fiberFromText
        end

        local var4 = useFiber(arg1, str1)
        var4.return_ = _return
        return var4
    end

    local function updateElement(_return, arg1, arg2, arg3)
        if arg1 ~= nil then
            if arg1.elementType == arg2.type or __DEV__ and isCompatibleFamilyForHotReloading(arg1, arg2) then
                local props = arg2.props
                local workInProgress = createWorkInProgress(arg1, props)

                workInProgress.index = 1
                if not ReactFeatureFlags.enableWorkLoopTrims or workInProgress.sibling ~= nil then
                    workInProgress.sibling = nil
                end

                if ReactFeatureFlags.enableWorkLoopTrims then
                    local ref = coerceRef(_return, arg1, arg2)
                    if ref ~= nil or workInProgress.ref ~= nil then
                        workInProgress.ref = ref
                    end
                else
                    workInProgress.ref = coerceRef(_return, arg1, arg2)
                end
                workInProgress.return_ = _return
                if __DEV__ then
                    workInProgress._debugSource = arg2._source
                    workInProgress._debugOwner = arg2._owner
                end
                return workInProgress
            end

            if enableBlocksAPI and arg1.tag == Block then
                local type2 = arg2.type
                if type(type2) == "table" and type2["$$typeof"] == REACT_LAZY_TYPE then
                    type2 = resolveLazyType(type2)
                end

                if type2["$$typeof"] == REACT_BLOCK_TYPE and type2._render == arg1.type._render then
                    local props = arg2.props
                    local workInProgress = createWorkInProgress(arg1, props)

                    workInProgress.index = 1
                    if not ReactFeatureFlags.enableWorkLoopTrims or workInProgress.sibling ~= nil then
                        workInProgress.sibling = nil
                    end

                    workInProgress.return_ = _return
                    workInProgress.type = type2
                    if __DEV__ then
                        workInProgress._debugSource = arg2._source
                        workInProgress._debugOwner = arg2._owner
                    end
                    return workInProgress
                end
            end
        end

        local fiberFromElement = createFiberFromElement(arg2, _return.mode, arg3)
        fiberFromElement.ref = coerceRef(_return, arg1, arg2)
        fiberFromElement.return_ = _return
        return fiberFromElement
    end

    local function updatePortal(_return, arg1, arg2, arg3)
        if arg1 == nil
            or arg1.tag ~= HostPortal
            or arg1.stateNode.containerInfo ~= arg2.containerInfo
            or arg1.stateNode.implementation ~= arg2.implementation
        then
            local fiberFromPortal = createFiberFromPortal(arg2, _return.mode, arg3)
            fiberFromPortal.return_ = _return
            return fiberFromPortal
        end

        local var4 = useFiber(arg1, arg2.children or {})
        var4.return_ = _return
        return var4
    end

    local function updateFragment(_return, arg1, arg2, arg3, str1: string?) -- Luacid: Inlined by compiler; 4 call sites recovered
        if arg1 == nil or arg1.tag ~= Fragment then
            local fiberFromFragment = createFiberFromFragment(arg2, _return.mode, arg3, str1)
            fiberFromFragment.return_ = _return
            return fiberFromFragment
        end

        local var4 = useFiber(arg1, arg2)
        var4.return_ = _return
        return var4
    end

    local function assignStableKey(key, tbl1) -- Luacid: Inlined by compiler; 3 call sites recovered
        if tbl1.key ~= nil then
            return
        end
        local str1 = type(key)
        if str1 == "string" or str1 == "number" then
            tbl1.key = key
        elseif str1 == "table" then
            tbl1.key = tostring(key)
        end
    end

    local function createChild(_return, arg1, arg2, arg3) -- Luacid: Inlined by compiler; 2 call sites recovered
        if arg1 == nil then
            return nil
        end

        local str1 = type(arg1)

        if str1 ~= "table" then
            if str1 == "string" or str1 == "number" then
                local fiberFromText = createFiberFromText(tostring(arg1), _return.mode, arg2)
                fiberFromText.return_ = _return
                return fiberFromText
            else
                if not __DEV__ or str1 ~= "function" then
                    return nil
                end

                warnOnFunctionType(_return)
                return nil
            end
        end

        assignStableKey(arg3, arg1)
        local typeof = arg1["$$typeof"]
        if typeof == REACT_ELEMENT_TYPE then
            local fiberFromElement = createFiberFromElement(arg1, _return.mode, arg2)
            fiberFromElement.ref = coerceRef(_return, nil, arg1)
            fiberFromElement.return_ = _return
            return fiberFromElement
        elseif typeof == REACT_PORTAL_TYPE then
            local fiberFromPortal = createFiberFromPortal(arg1, _return.mode, arg2)
            fiberFromPortal.return_ = _return
            return fiberFromPortal
        elseif typeof == REACT_LAZY_TYPE and enableLazyElements then
            local _payload = arg1._payload
            return createChild(_return, arg1._init(_payload), arg2)
        else
            local fiberFromFragment = createFiberFromFragment(arg1, _return.mode, arg2, nil)
            fiberFromFragment.return_ = _return
            return fiberFromFragment
        end
    end
    local function updateSlot(_return, arg1, arg2, arg3, arg4)
        if arg2 == nil then
            return nil
        end

        local key = if arg1 == nil then nil else arg1.key
        local str1 = type(arg2)

        if str1 ~= "table" then
            if str1 ~= "string" and str1 ~= "number" then
                if not __DEV__ or str1 ~= "function" then
                    return nil
                end

                warnOnFunctionType(_return)
                return nil
            end

            if key ~= nil then
                return nil
            end
            local str2 = tostring(arg2)

            if arg1 == nil or arg1.tag ~= HostText then
                return updateTextNode(_return, nil, str2, arg3)
            end

            local workInProgress = createWorkInProgress(arg1, str2)

            workInProgress.index = 1
            if not ReactFeatureFlags.enableWorkLoopTrims or workInProgress.sibling ~= nil then
                workInProgress.sibling = nil
            end

            workInProgress.return_ = _return
            return workInProgress
        end

        assignStableKey(arg4, arg2)
        local typeof = arg2["$$typeof"]
        if typeof == REACT_ELEMENT_TYPE then
            if arg2.key ~= key then
                return nil
            end

            if arg2.type ~= REACT_FRAGMENT_TYPE then
                return (updateElement(_return, arg1, arg2, arg3))
            end

            local children = arg2.props.children

            if arg1 == nil or arg1.tag ~= Fragment then
                return updateFragment(_return, nil, children, arg3, key)
            end

            local workInProgress = createWorkInProgress(arg1, children)

            workInProgress.index = 1
            if not ReactFeatureFlags.enableWorkLoopTrims or workInProgress.sibling ~= nil then
                workInProgress.sibling = nil
            end

            workInProgress.return_ = _return
            return workInProgress
        elseif typeof == REACT_PORTAL_TYPE then
            if arg2.key == key then
                return (updatePortal(_return, arg1, arg2, arg3))
            end
            return nil
        else
            if typeof == REACT_LAZY_TYPE and enableLazyElements then
                local _payload = arg2._payload
                return updateSlot(_return, arg1, arg2._init(_payload), arg3)
            end

            if key ~= nil then
                return nil
            end

            if arg1 == nil or arg1.tag ~= Fragment then
                return updateFragment(_return, nil, arg2, arg3, nil)
            end

            local workInProgress = createWorkInProgress(arg1, arg2)

            workInProgress.index = 1
            if not ReactFeatureFlags.enableWorkLoopTrims or workInProgress.sibling ~= nil then
                workInProgress.sibling = nil
            end

            workInProgress.return_ = _return
            return workInProgress
        end
    end
    local function updateFromMap(tbl1, _return, num1: number, arg1, arg2, arg3)
        if arg1 == nil then
            return nil
        end

        local str1 = type(arg1)

        if str1 ~= "table" then
            if str1 ~= "string" and str1 ~= "number" then
                if not __DEV__ or str1 ~= "function" then
                    return nil
                end

                warnOnFunctionType(_return)
                return nil
            end

            local var4 = tbl1[num1] or nil
            local str2 = tostring(arg1)

            if var4 == nil or var4.tag ~= HostText then
                return updateTextNode(_return, nil, str2, arg2)
            end

            local workInProgress = createWorkInProgress(var4, str2)

            workInProgress.index = 1
            if not ReactFeatureFlags.enableWorkLoopTrims or workInProgress.sibling ~= nil then
                workInProgress.sibling = nil
            end

            workInProgress.return_ = _return
            return workInProgress
        end

        assignStableKey(arg3, arg1)
        local typeof = arg1["$$typeof"]
        if typeof == REACT_ELEMENT_TYPE then
            if arg1.key ~= nil then
                num1 = arg1.key
            end
            local var4 = tbl1[num1]
            if arg1.type ~= REACT_FRAGMENT_TYPE then
                return (updateElement(_return, var4, arg1, arg2))
            end

            local children = arg1.props.children

            local key = arg1.key

            if var4 == nil or var4.tag ~= Fragment then
                return updateFragment(_return, nil, children, arg2, key)
            end

            local workInProgress = createWorkInProgress(var4, children)

            workInProgress.index = 1
            if not ReactFeatureFlags.enableWorkLoopTrims or workInProgress.sibling ~= nil then
                workInProgress.sibling = nil
            end

            workInProgress.return_ = _return
            return workInProgress
        end

        if typeof == REACT_PORTAL_TYPE then
            if arg1.key ~= nil then
                num1 = arg1.key
            end
            local var4 = tbl1[num1]
            return (updatePortal(_return, var4, arg1, arg2))
        end

        if typeof == REACT_LAZY_TYPE and enableLazyElements then
            local _payload = arg1._payload
            return updateFromMap(tbl1, _return, num1, arg1._init(_payload), arg2)
        end

        local var4 = tbl1[num1]

        if var4 == nil or var4.tag ~= Fragment then
            return updateFragment(_return, nil, arg1, arg2, nil)
        end

        local workInProgress = createWorkInProgress(var4, arg1)

        workInProgress.index = 1
        if not ReactFeatureFlags.enableWorkLoopTrims or workInProgress.sibling ~= nil then
            workInProgress.sibling = nil
        end

        workInProgress.return_ = _return
        return workInProgress
    end

    local function warnOnInvalidKey(arg1, tbl1, arg2)
        if __DEV__ then
            if arg1 == nil or type(arg1) ~= "table" then
                return tbl1
            end

            local typeof = arg1["$$typeof"]
            if typeof == REACT_ELEMENT_TYPE or typeof == REACT_PORTAL_TYPE then
                func1(arg1, arg2)
                local key = arg1.key
                if type(key) ~= "string" then
                    return tbl1
                elseif tbl1 == nil then
                    tbl1 = {}
                    tbl1[key] = true
                    return tbl1
                elseif not tbl1[key] then
                    tbl1[key] = true
                    return tbl1
                else
                    console.error(
                        "Encountered two children with the same key, `%s`. Keys should be unique so that components maintain their identity across updates. Non-unique keys may cause children to be duplicated and/or omitted — the behavior is unsupported and could change in a future version.",
                        key
                    )
                    return tbl1
                end
            end

            if typeof == REACT_LAZY_TYPE and enableLazyElements then
                local _payload = arg1._payload
                warnOnInvalidKey(arg1._init(_payload), tbl1, arg2)
            end
        end

        return tbl1
    end

    local function reconcileChildrenArray(arg1, arg2, tbl1, arg3)
        if __DEV__ then
            local var4 = nil
            for _, value in tbl1 do
                var4 = warnOnInvalidKey(value, var4, arg1)
            end
        end

        local num1 = #tbl1
        local num2 = 1
        local var4 = nil
        local num3 = 1
        local var5 = nil
        local sibling

        while true do
            if arg2 == nil or not (num2 <= num1) then
                sibling = arg2
                break
            end

            if num2 < arg2.index then
                sibling = arg2
                arg2 = nil
            else
                sibling = arg2.sibling
            end

            local var6 = tbl1[num2]
            local var7 = if var6 ~= nil and type(var6) == "table" and var6["$$typeof"] ~= nil then updateSlot(arg1, arg2, var6, arg3, num2) else updateSlot(arg1, arg2, var6, arg3)

            if var7 == nil then
                if arg2 ~= nil then
                    sibling = arg2
                end

                break
            end

            if bool2 and arg2 and var7.alternate == nil then
                deleteChild(arg1, arg2)
            end

            num3 = placeChild(var7, num3, num2)

            if var5 == nil then
                var4 = var7
            else
                var5.sibling = var7
            end

            num2 += 1
            var5 = var7
            arg2 = sibling
        end

        if num1 < num2 then
            if not bool2 then
                return var4
            end

            while sibling ~= nil do
                deleteChild(arg1, sibling)
                sibling = sibling.sibling
            end

            return var4
        end

        if sibling == nil then
            while num2 <= num1 do
                local var6 = tbl1[num2]
                local child = if var6 ~= nil and type(var6) == "table" and var6["$$typeof"] ~= nil then createChild(arg1, var6, arg3, num2) else createChild(arg1, var6, arg3)

                if child == nil then
                    num2 += 1
                    child = var5
                else
                    num3 = placeChild(child, num3, num2)

                    if var5 == nil then
                        var4 = child
                    else
                        var5.sibling = child
                    end

                    num2 += 1
                end

                var5 = child
            end
            return var4
        end

        local tbl2 = mapRemainingChildren(arg1, sibling)

        while num2 <= num1 do
            local var6 = tbl1[num2]
            local var7 = if not var1 or var6 ~= nil and type(var6) == "table" and var6["$$typeof"] ~= nil then updateFromMap(tbl2, arg1, num2, var6, arg3, num2) else updateFromMap(tbl2, arg1, num2, var6, arg3)

            if var7 == nil then
                var7 = var5
            else
                if bool2 and var7.alternate ~= nil then
                    local var8 = if var7.key == nil then num2 else var7.key
                    tbl2[var8] = nil
                end

                num3 = placeChild(var7, num3, num2)

                if var5 == nil then
                    var4 = var7
                else
                    var5.sibling = var7
                end
            end

            num2 += 1
            var5 = var7
        end

        if bool2 then
            for _, value in tbl2 do
                deleteChild(arg1, value)
            end
        end

        return var4
    end

    local function reconcileChildrenIterator(arg1, arg2, arg3, arg4, entries: (...any) -> (...any))
        if __DEV__ then
            if arg3.entries == entries then
                if not bool1 then
                    console.error("Using Maps as children is not supported. Use an array of keyed ReactElements instead.")
                end

                bool1 = true
            end

            local var4 = entries(arg3)
            if var4 then
                local var5 = var4.next()
                local var6 = nil

                while not var5.done do
                    var5 = var4.next()
                    local value = var5.value
                    var6 = warnOnInvalidKey(value, var6, arg1)
                end
            end
        end

        local var4 = entries(arg3)

        local var5 = var4.next()
        local num1 = 1
        local var6 = nil
        local num2 = 1
        local var7 = nil
        local sibling

        while true do
            if arg2 == nil or var5.done then
                sibling = arg2
                break
            end

            if num1 < arg2.index then
                sibling = arg2
                arg2 = nil
            else
                sibling = arg2.sibling
            end

            local var8 = updateSlot(arg1, arg2, var5.value, arg4, var5.key)
            if var8 == nil then
                if arg2 ~= nil then
                    sibling = arg2
                end

                break
            end

            if bool2 and arg2 and var8.alternate == nil then
                deleteChild(arg1, arg2)
            end

            num2 = placeChild(var8, num2, num1)

            if var7 == nil then
                var6 = var8
            else
                var7.sibling = var8
            end

            num1 += 1
            var5 = var4.next()
            var7 = var8
            arg2 = sibling
        end

        if var5.done then
            if not bool2 then
                return var6
            end

            while sibling ~= nil do
                deleteChild(arg1, sibling)
                sibling = sibling.sibling
            end

            return var6
        end

        if sibling == nil then
            while not var5.done do
                local child = createChild(arg1, var5.value, arg4, var5.key)
                if child == nil then
                    num1 += 1
                    var5 = var4.next()
                    child = var7
                else
                    num2 = placeChild(child, num2, num1)

                    if var7 == nil then
                        var6 = child
                    else
                        var7.sibling = child
                    end

                    num1 += 1
                    var5 = var4.next()
                end

                var7 = child
            end
            return var6
        end

        local var8 = nil

        while not var5.done do
            var8 = var8 or mapRemainingChildren(arg1, sibling)

            local var9 = updateFromMap(var8, arg1, num1, var5.value, arg4, var5.key)

            if var9 == nil then
                var9 = var7
            else
                if bool2 and var9.alternate ~= nil then
                    if var9.key == nil then
                        var8[num1] = nil
                    else
                        var8[var9.key] = nil
                    end
                end

                num2 = placeChild(var9, num2, num1)

                if var7 == nil then
                    var6 = var9
                else
                    var7.sibling = var9
                end
            end

            num1 += 1
            var5 = var4.next()
            var7 = var9
        end

        if bool2 then
            for _, value in var8 do
                deleteChild(arg1, value)
            end
        end

        return var6
    end

    local function reconcileSingleTextNode(_return, arg1, str1: string, arg2)
        if arg1 == nil or arg1.tag ~= HostText then
            if bool2 then
                while arg1 ~= nil do
                    deleteChild(_return, arg1)
                    arg1 = arg1.sibling
                end
            end

            local fiberFromText = createFiberFromText(str1, _return.mode, arg2)
            fiberFromText.return_ = _return
            return fiberFromText
        end

        local sibling = arg1.sibling

        if bool2 then
            while sibling ~= nil do
                deleteChild(_return, sibling)
                sibling = sibling.sibling
            end
        end

        local var4 = useFiber(arg1, str1)
        var4.return_ = _return
        return var4
    end

    local function reconcileSingleElement(_return, arg1, arg2, arg3)
        local key = arg2.key
        local var4 = arg1

        while arg1 ~= nil do
            if arg1.key == key then
                if arg1.tag == Fragment then
                    if arg2.type == REACT_FRAGMENT_TYPE then
                        local sibling = arg1.sibling

                        if bool2 then
                            while sibling ~= nil do
                                deleteChild(_return, sibling)
                                sibling = sibling.sibling
                            end
                        end

                        local children = arg2.props.children
                        local workInProgress = createWorkInProgress(arg1, children)

                        workInProgress.index = 1
                        if not ReactFeatureFlags.enableWorkLoopTrims or workInProgress.sibling ~= nil then
                            workInProgress.sibling = nil
                        end

                        workInProgress.return_ = _return
                        if __DEV__ then
                            workInProgress._debugSource = arg2._source
                            workInProgress._debugOwner = arg2._owner
                        end
                        return workInProgress
                    end
                elseif arg1.elementType == arg2.type or __DEV__ and isCompatibleFamilyForHotReloading(arg1, arg2) then
                    local sibling = arg1.sibling

                    if bool2 then
                        while sibling ~= nil do
                            deleteChild(_return, sibling)
                            sibling = sibling.sibling
                        end
                    end

                    local props = arg2.props
                    local workInProgress = createWorkInProgress(arg1, props)

                    workInProgress.index = 1
                    if not ReactFeatureFlags.enableWorkLoopTrims or workInProgress.sibling ~= nil then
                        workInProgress.sibling = nil
                    end

                    if ReactFeatureFlags.enableWorkLoopTrims then
                        local ref = coerceRef(_return, arg1, arg2)
                        if ref ~= nil or workInProgress.ref ~= nil then
                            workInProgress.ref = ref
                        end
                    else
                        workInProgress.ref = coerceRef(_return, arg1, arg2)
                    end
                    workInProgress.return_ = _return
                    if __DEV__ then
                        workInProgress._debugSource = arg2._source
                        workInProgress._debugOwner = arg2._owner
                    end
                    return workInProgress
                end

                if bool2 then
                    while arg1 ~= nil do
                        deleteChild(_return, arg1)
                        arg1 = arg1.sibling
                    end
                end

                break
            end

            deleteChild(_return, arg1)
            arg1 = arg1.sibling
        end

        if arg2.type == REACT_FRAGMENT_TYPE then
            local fiberFromFragment = createFiberFromFragment(arg2.props.children, _return.mode, arg3, arg2.key)

            fiberFromFragment.return_ = _return
            return fiberFromFragment
        end
        local fiberFromElement = createFiberFromElement(arg2, _return.mode, arg3)
        fiberFromElement.ref = coerceRef(_return, var4, arg2)
        fiberFromElement.return_ = _return
        return fiberFromElement
    end

    local function reconcileSinglePortal(_return, arg1, arg2, arg3)
        local key = arg2.key

        while arg1 ~= nil do
            if arg1.key == key then
                if arg1.tag == HostPortal
                    and arg1.stateNode.containerInfo == arg2.containerInfo
                    and arg1.stateNode.implementation == arg2.implementation
                then
                    local sibling = arg1.sibling

                    if bool2 then
                        while sibling ~= nil do
                            deleteChild(_return, sibling)
                            sibling = sibling.sibling
                        end
                    end

                    local var4 = useFiber(arg1, arg2.children or {})
                    var4.return_ = _return
                    return var4
                end

                if bool2 then
                    while arg1 ~= nil do
                        deleteChild(_return, arg1)
                        arg1 = arg1.sibling
                    end
                end

                break
            end

            deleteChild(_return, arg1)
            arg1 = arg1.sibling
        end

        local fiberFromPortal = createFiberFromPortal(arg2, _return.mode, arg3)
        fiberFromPortal.return_ = _return
        return fiberFromPortal
    end

    local function reconcileChildFibers(arg1, arg2, arg3, arg4)
        local str1 = type(arg3)

        if arg3 ~= nil and str1 == "table" and arg3.type == REACT_FRAGMENT_TYPE and arg3.key == nil then
            arg3 = arg3.props.children
            str1 = type(arg3)
        end
        local var4 = isArray(arg3)

        if arg3 ~= nil and str1 == "table" and not var4 then
            local typeof = arg3["$$typeof"]
            if typeof == REACT_ELEMENT_TYPE then
                return placeSingleChild((reconcileSingleElement(arg1, arg2, arg3, arg4)))
            end

            if typeof == REACT_PORTAL_TYPE then
                return placeSingleChild((reconcileSinglePortal(arg1, arg2, arg3, arg4)))
            end
            if typeof == REACT_LAZY_TYPE and enableLazyElements then
                local _payload = arg3._payload
                return reconcileChildFibers(arg1, arg2, arg3._init(_payload), arg4)
            end
        else
            if var4 then
                return (reconcileChildrenArray(arg1, arg2, arg3, arg4))
            end

            if str1 == "string" or str1 == "number" then
                return placeSingleChild((reconcileSingleTextNode(arg1, arg2, tostring(arg3), arg4)))
            end
        end

        local iteratorFn = getIteratorFn(arg3)
        if iteratorFn then
            return (reconcileChildrenIterator(arg1, arg2, arg3, arg4, iteratorFn))
        end

        if __DEV__ and str1 == "function" then
            warnOnFunctionType(arg1)
        end

        if not bool2 then
            return createChild(nil, nil, nil, nil)
        end

        while arg2 ~= nil do
            deleteChild(arg1, arg2)
            arg2 = arg2.sibling
        end

        return createChild(nil, nil, nil, nil)
    end

    return reconcileChildFibers
end

module.reconcileChildFibers = ChildReconciler(true)
module.mountChildFibers = ChildReconciler(false)

function module.cloneChildFibers(_, _return)
    if _return.child == nil then
        return
    end

    local child = _return.child
    local workInProgress = createWorkInProgress(child, child.pendingProps)
    _return.child = workInProgress

    workInProgress.return_ = _return
    while child.sibling ~= nil do
        child = child.sibling
        workInProgress.sibling = createWorkInProgress(child, child.pendingProps)

        workInProgress = workInProgress.sibling
        workInProgress.return_ = _return
    end
    workInProgress.sibling = nil
end

function module.resetChildFibers(arg1, arg2)
    local child = arg1.child
    while child ~= nil do
        resetWorkInProgress(child, arg2)
        child = child.sibling
    end
end

return module
