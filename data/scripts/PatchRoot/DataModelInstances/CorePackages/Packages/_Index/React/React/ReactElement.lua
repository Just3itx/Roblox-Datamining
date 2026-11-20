-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)
local Error = require(scriptParentParent.LuauPolyfill).Error

local __DEV__ = ReactGlobals.__DEV__

local console = require(scriptParentParent.Shared).console
local _Shared = require(scriptParentParent.Shared)

local _ReactLazy = require(script.Parent.ReactLazy)

local getComponentName = require(scriptParentParent.Shared).getComponentName

local REACT_ELEMENT_TYPE = require(scriptParentParent.Shared).ReactSymbols.REACT_ELEMENT_TYPE
local ReactCurrentOwner = require(scriptParentParent.Shared).ReactSharedInternals.ReactCurrentOwner

local tbl1 = { key = true, ref = true, __self = true, __source = true }

local var1 = nil
local var2 = nil
local var3 = nil

var3 = __DEV__ and {} or var3

local module = {}

local function hasValidRef(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not (__DEV__ and arg1.ref ~= nil and type(arg1.ref) == "table" and arg1.ref.isReactWarning) and arg1.ref ~= nil
end

local function hasValidKey(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not (__DEV__ and arg1.key ~= nil and type(arg1.key) == "table" and arg1.key.isReactWarning) and arg1.key ~= nil
end

local tbl2 = { isReactWarning = true }

local function defineKeyPropWarningGetter(arg1, str1: string)
    local function func1() -- Luacid: Inlined by compiler; 1 call site recovered
        if __DEV__ and not var1 then
            var1 = true
            console.error(
                "%s: `key` is not a prop. Trying to access it will result in `nil` being returned. If you need to access the same value within the child component, you should pass it as a different prop. (https://reactjs.org/link/special-props)",
                str1
            )
        end
    end

    arg1.key = nil
    setmetatable(arg1, {
        __index = function(_, arg2): {isReactWarning: boolean}?
            if arg2 ~= "key" then
                return nil
            end

            func1()
            return tbl2
        end
    })
end

local function defineRefPropWarningGetter(arg1, str1: string)
    local function func1() -- Luacid: Inlined by compiler; 1 call site recovered
        if __DEV__ and not var2 then
            var2 = true
            console.error(
                "%s: `ref` is not a prop. Trying to access it will result in `nil` being returned. If you need to access the same value within the child component, you should pass it as a different prop. (https://reactjs.org/link/special-props)",
                str1
            )
        end
    end

    arg1.ref = nil
    setmetatable(arg1, {
        __index = function(_, arg2): {isReactWarning: boolean}?
            if arg2 ~= "ref" then
                return nil
            end

            func1()
            return tbl2
        end
    })
end

local function warnIfStringRefCannotBeAutoConverted(arg1)
    if not __DEV__ or type(arg1.ref) ~= "string" or not ReactCurrentOwner.current then
        return
    end

    local componentName = getComponentName(ReactCurrentOwner.current.type)

    if not var3[componentName] then
        error(
            string.format(
                "Component \"%s\" contains the string ref \"%s\". Support for string refs has been removed. We recommend using useRef() or createRef() instead. Learn more about using refs safely here: https://reactjs.org/link/strict-mode-string-ref",
                componentName or "Unknown",
                arg1.ref
            )
        )
    end
end

local function ReactElement(type, key, ref, _self, _source, _owner, props)
    local tbl3 = { type = type, key = key, ref = ref, props = props, _owner = _owner }

    tbl3["$$typeof"] = REACT_ELEMENT_TYPE

    if __DEV__ then
        local tbl4 = { validated = false }

        tbl3._store = setmetatable({}, {
            __index = tbl4,
            __newindex = function(arg1, arg2, validated)
                if arg2 == "validated" then
                    tbl4.validated = validated
                    return
                end
                rawset(arg1, arg2, validated)
            end
        })

        setmetatable(tbl3, { __index = { _self = _self, _source = _source } })
    end

    return tbl3
end

function module.jsx(_, _, _)
    error("JSX is currently unsupported")
end

function module.jsxDEV(_, _, _, _, _)
    error("JSX is currently unsupported")

    return nil
end

function module.createElement(arg1, arg2, ...)
    local var4 = arg2 == nil and {} or table.clone(arg2)

    local key = nil
    local ref = nil
    local __source

    if arg2 == nil then
        __source = nil
    else
        if (not __DEV__ or arg2.ref == nil or type(arg2.ref) ~= "table" or not arg2.ref.isReactWarning) and arg2.ref ~= nil then
            ref = arg2.ref

            if __DEV__ then
                warnIfStringRefCannotBeAutoConverted(arg2)
            end
        end

        if (not __DEV__ or arg2.key == nil or type(arg2.key) ~= "table" or not arg2.key.isReactWarning) and arg2.key ~= nil then
            key = arg2.key

            if type(key) ~= "number" then
                key = tostring(key)
            end
        end

        if arg2.__source == nil then
            __source = nil
        else
            __source = arg2.__source
        end

        if var4.key ~= nil then
            var4.key = nil
        end
        if var4.ref ~= nil then
            var4.ref = nil
        end
        if var4.__self ~= nil then
            var4.__self = nil
        end
        if var4.__source ~= nil then
            var4.__source = nil
        end
    end

    local select2 = select
    local var5 = select2("#", ...)

    if var5 == 1 then
        local select = select
        var4.children = select(1, ...)
    elseif var5 > 1 then
        local children = table.create(var5)
        for i = 1, var5 do
            local select = select
            table.insert(children, (select(i, ...)))
        end

        if __DEV__ then
            table.freeze(children)
        end

        var4.children = children
    end

    if type(arg1) == "table" and arg1.defaultProps then
        local defaultProps = arg1.defaultProps

        for k, _ in defaultProps do
            if var4[k] == nil then
                var4[k] = defaultProps[k]
            end
        end
    end

    if __DEV__ then
        if key or ref then
            local var6 = if type(arg1) == "function" then debug.info(arg1, "n") or "<function>" elseif type(arg1) == "table" then arg1.displayName or arg1.name or "Unknown" else arg1

            if key then
                defineKeyPropWarningGetter(var4, var6)
            end

            if ref then
                defineRefPropWarningGetter(var4, var6)
            end
        end

        __source = __source == nil and {
            fileName = debug.info(3, "s"),
            lineNumber = debug.info(3, "l")
        } or __source
    end

    return (ReactElement(arg1, key, ref, nil, __source, ReactCurrentOwner.current, var4))
end

function module.cloneAndReplaceKey(arg1, key)
    return (ReactElement(arg1.type, key, arg1.ref, arg1._self, arg1._source, arg1._owner, arg1.props))
end

function module.cloneElement(arg1, arg2, ...)
    if arg1 == nil then
        error(Error.new("React.cloneElement(...): The argument must be a React element, but you passed " .. tostring(arg1)))
    end

    local props = arg1.props
    local var4 = props == nil and {} or table.clone(props)

    local key = arg1.key
    local ref = arg1.ref

    local _source = arg1._source

    local _owner = arg1._owner

    if arg2 ~= nil then
        local ref2 = arg2.ref
        if ref2 ~= nil then
            _owner = ReactCurrentOwner.current
            ref = ref2
        else
            hasValidRef(arg2)
        end

        local key2 = arg2.key

        if key2 == nil then
            hasValidKey(arg2)
        elseif type(key2) == "number" then
            key = key2
        else
            key = key2 or "nil"
        end
    end

    local type2 = arg1.type
    local defaultProps = if type(type2) == "table" then type2.defaultProps else nil

    if arg2 ~= nil then
        for value, _ in arg2 do
            if arg2[value] == nil or tbl1[value] then
                continue
            end

            if arg2[value] == nil and defaultProps ~= nil then
                var4[value] = defaultProps[value]
            else
                var4[value] = arg2[value]
            end
        end
    end

    local select2 = select
    local var5 = select2("#", ...)

    if var5 == 1 then
        local select = select
        var4.children = select(1, ...)
    elseif var5 > 1 then
        var4.children = { ... }
    end

    return (ReactElement(arg1.type, key, ref, nil, _source, _owner, var4))
end

function module.isValidElement(arg1): boolean
    return type(arg1) == "table" and arg1["$$typeof"] == REACT_ELEMENT_TYPE
end

return module
