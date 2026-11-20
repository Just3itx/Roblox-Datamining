-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array

local Boolean = LuauPolyfill.Boolean
local Object = LuauPolyfill.Object

local console = require(scriptParentParent.Shared).console
local inspect = LuauPolyfill.util.inspect

local _Shared = require(scriptParentParent.Shared)

local isValidElementType = require(scriptParentParent.Shared).isValidElementType
local getComponentName = require(scriptParentParent.Shared).getComponentName
local ReactSymbols = require(scriptParentParent.Shared).ReactSymbols
local getIteratorFn = ReactSymbols.getIteratorFn
local _REACT_FORWARD_REF_TYPE = ReactSymbols.REACT_FORWARD_REF_TYPE
local _REACT_MEMO_TYPE = ReactSymbols.REACT_MEMO_TYPE
local REACT_FRAGMENT_TYPE = ReactSymbols.REACT_FRAGMENT_TYPE
local REACT_ELEMENT_TYPE = ReactSymbols.REACT_ELEMENT_TYPE

local warnAboutSpreadingKeyToJSX = require(scriptParentParent.Shared).ReactFeatureFlags.warnAboutSpreadingKeyToJSX
local checkPropTypes = require(scriptParentParent.Shared).checkPropTypes
local ReactCurrentOwner = require(scriptParentParent.Shared).ReactSharedInternals.ReactCurrentOwner

local ReactElement = require(script.Parent.ReactElement)
local isValidElement = ReactElement.isValidElement
local createElement = ReactElement.createElement
local cloneElement = ReactElement.cloneElement
local jsxDEV = ReactElement.jsxDEV

local setExtraStackFrame = require(scriptParentParent.Shared).ReactSharedInternals.ReactDebugCurrentFrame.setExtraStackFrame

local describeUnknownElementTypeFrameInDEV = require(scriptParentParent.Shared).ReactComponentStackFrame.describeUnknownElementTypeFrameInDEV

local module = {}

local function setCurrentlyValidatingElement(bool1: boolean) -- Luacid: Inlined by compiler; 6 call sites recovered
    if not ReactGlobals.__DEV__ then
        return
    end

    if not bool1 then
        setExtraStackFrame(nil)
        return
    end

    local _owner = bool1._owner
    local type = if _owner then _owner.type else nil
    local var1 = describeUnknownElementTypeFrameInDEV(bool1.type, bool1._source, type)

    setExtraStackFrame(var1)
end

local bool1 = not ReactGlobals.__DEV__ and nil

local function hasOwnProperty(arg1, str1: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1[str1] ~= nil
end

local function getDeclarationErrorAddendum() -- Luacid: Inlined by compiler; 3 call sites recovered
    if ReactCurrentOwner.current then
        local componentName = getComponentName(ReactCurrentOwner.current.type)
        if componentName then
            return "\n\nCheck the render method of `" .. componentName .. "`."
        end
    end
    return ""
end

local function getSourceInfoErrorAddendum(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    if arg1 == nil then
        return ""
    end

    return "\n\nCheck your code at " .. string.gsub(arg1.fileName, "^.*[\\/]", "") .. ":" .. arg1.lineNumber .. "."
end

local function getSourceInfoErrorAddendumForProps(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 ~= nil then
        return getSourceInfoErrorAddendum(arg1.__source)
    end
    return ""
end

local tbl1 = ({})

local function getCurrentComponentErrorInfo(arg1)
    local declarationErrorAddendum = getDeclarationErrorAddendum()

    if not Boolean.toJSBoolean(declarationErrorAddendum) then
        local var1 = if typeof(arg1) == "string" then arg1 elseif typeof(arg1) == "table" then arg1.displayName or arg1.name else nil

        if not var1 and typeof(arg1) == "function" then
            var1 = debug.info(arg1, "n")

            if var1 == "" then
                var1 = nil
            end
        end
        if var1 then
            declarationErrorAddendum = string.format("\n\nCheck the top-level render call using <%s>.", var1)
        end
    end

    return declarationErrorAddendum
end

local function validateExplicitKey(arg1, arg2, arg3)
    if arg1._store == nil or arg1._store.validated then
        return
    end

    arg1._store.validated = true

    if arg1.key ~= nil ~= (arg3 ~= nil) then
        return
    end

    local currentComponentErrorInfo = getCurrentComponentErrorInfo(arg2)
    if tbl1[currentComponentErrorInfo] then
        return
    end
    tbl1[currentComponentErrorInfo] = true
    local var1 = if arg1 and arg1._owner and arg1._owner ~= ReactCurrentOwner.current then string.format(" It was passed a child from %s.", tostring(getComponentName(arg1._owner.type))) else ""

    if not ReactGlobals.__DEV__ then
        return
    end

    setCurrentlyValidatingElement(arg1)

    if arg1.key ~= nil and arg3 ~= nil then
        console.error(
            "Child element received a \"key\" prop (\"%s\") in addition to a key in the \"children\" table of its parent (\"%s\"). Please provide only one key definition. When both are present, the \"key\" prop will take precedence.%s%s See https://reactjs.org/link/warning-keys for more information.",
            tostring(arg1.key),
            tostring(arg3),
            currentComponentErrorInfo,
            var1
        )
    else
        console.error(
            "Each child in a list should have a unique \"key\" prop.%s%s See https://reactjs.org/link/warning-keys for more information.",
            currentComponentErrorInfo,
            var1
        )
    end

    setCurrentlyValidatingElement(false)
end

local function validateChildKeys(arg1, arg2)
    if typeof(arg1) ~= "table" then
        return
    end

    if Array.isArray(arg1) then
        for i = 1, #arg1 do
            local var1 = arg1[i]
            if isValidElement(var1) then
                validateExplicitKey(var1, arg2)
            end
        end

        return
    end

    if isValidElement(arg1) then
        if arg1._store then
            arg1._store.validated = true
        end

        return
    end
    if not arg1 then
        return
    end

    local iteratorFn = getIteratorFn(arg1)
    if typeof(iteratorFn) ~= "function" or iteratorFn == arg1.entries then
        return
    end

    local var1 = iteratorFn(arg1)
    local var2 = var1.next()
    while not var2.done do
        if isValidElement(var2.value) then
            validateExplicitKey(var2.value, arg2, var2.key)
        end

        var2 = var1.next()
    end
end

local function validatePropTypes(arg1)
    if not ReactGlobals.__DEV__ and not ReactGlobals.__DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ then
        return
    end
    local type = arg1.type
    if type == nil or typeof(type) == "string" then
        return
    end

    if typeof(type) == "function" then
        return
    end

    if typeof(type) ~= "table" then
        return
    end

    local propTypes = type.propTypes
    local validateProps = type.validateProps

    if propTypes or validateProps then
        local componentName = getComponentName(type)

        checkPropTypes(propTypes, validateProps, arg1.props, "prop", componentName, arg1)
    elseif type.PropTypes ~= nil and not bool1 then
        bool1 = true

        local componentName = getComponentName(type)
        console.error(
            "Component %s declared `PropTypes` instead of `propTypes`. Did you misspell the property assignment?",
            componentName or "Unknown"
        )
    end

    if type.getDefaultProps ~= nil then
        console.error(
            "getDefaultProps is only used on classic React.createClass definitions. Use a static property named `defaultProps` instead."
        )
    end
end

local function validateFragmentProps(arg1)
    if not ReactGlobals.__DEV__ then
        return
    end

    local var1 = Object.keys(arg1.props)
    for i = 1, #var1 do
        local var2 = var1[i]
        if var2 ~= "children" and var2 ~= "key" then
            setCurrentlyValidatingElement(arg1)
            console.error(
                "Invalid prop `%s` supplied to `React.Fragment`. React.Fragment can only have `key` and `children` props.",
                var2
            )
            setCurrentlyValidatingElement(false)
            break
        end
    end

    if arg1.ref ~= nil then
        setCurrentlyValidatingElement(arg1)
        console.error("Invalid attribute `ref` supplied to `React.Fragment`.")
        setCurrentlyValidatingElement(false)
    end
end

local function jsxWithValidation(arg1, arg2, arg3, arg4, arg5, arg6)
    local var1 = isValidElementType(arg1)

    if not var1 then
        local str1 = ""
        if arg1 == nil or typeof(arg1) == "table" and #Object.keys(arg1) == 0 then
            str1 ..= " You likely forgot to export your component from the file it's defined in, or you might have mixed up default and named imports."
        end

        local sourceInfoErrorAddendum = getSourceInfoErrorAddendum(arg5)
        local var2 = if sourceInfoErrorAddendum then str1 .. sourceInfoErrorAddendum else str1 .. getDeclarationErrorAddendum()
        local got

        if arg1 == nil then
            got = "nil"
        elseif Array.isArray(arg1) then
            got = "array"
        elseif typeof(arg1) == "table" and arg1["$$typeof"] == REACT_ELEMENT_TYPE then
            got = string.format("<%s />", getComponentName(arg1.type) or "Unknown")
            var2 ..= " Did you accidentally export a JSX literal or Element instead of a component?"
        else
            got = typeof(arg1)
            var2 ..= "\n" .. inspect(arg1)
        end

        if ReactGlobals.__DEV__ then
            console.error(
                "React.jsx: type is invalid -- expected a string (for built-in components) or a class/function (for composite components) but got: %s.%s",
                got,
                var2
            )
        end
    end

    local var2 = jsxDEV(arg1, arg2, arg3, arg5, arg6)

    if var2 == nil then
        return var2
    end

    if var1 then
        local children = arg2.children
        if children ~= nil then
            if arg4 then
                if Array.isArray(children) then
                    for i = 1, #children do
                        validateChildKeys(children[i], arg1)
                    end

                    Object.freeze(children)
                elseif ReactGlobals.__DEV__ then
                    console.error(
                        "React.jsx: Static children should always be an array. You are likely explicitly calling React.jsxs or React.jsxDEV. Use the Babel transform instead."
                    )
                end
            else
                validateChildKeys(children, arg1)
            end
        end
    end

    if ReactGlobals.__DEV__ and warnAboutSpreadingKeyToJSX and hasOwnProperty(arg2, "key") then
        console.error(
            "React.jsx: Spreading a key to JSX is a deprecated pattern. Explicitly pass a key after spreading props in your JSX call. E.g. <%s {...props} key={key} />",
            getComponentName(arg1) or "ComponentName"
        )
    end

    if arg1 == REACT_FRAGMENT_TYPE then
        validateFragmentProps(var2)
    else
        validatePropTypes(var2)
    end

    return var2
end
module.jsxWithValidation = jsxWithValidation

function module.jsxWithValidationStatic(arg1, arg2, arg3)
    return (jsxWithValidation(arg1, arg2, arg3, true))
end

function module.jsxWithValidationDynamic(arg1, arg2, arg3)
    return (jsxWithValidation(arg1, arg2, arg3, false))
end

function module.createElementWithValidation(arg1, arg2, ...)
    local var1 = isValidElementType(arg1)

    if not var1 then
        local str1 = ""
        if arg1 == nil or typeof(arg1) == "table" and #Object.keys(arg1) == 0 then
            str1 ..= " You likely forgot to export your component from the file it's defined in, or you might have mixed up default and named imports."
        end

        local sourceInfoErrorAddendumForProps = getSourceInfoErrorAddendumForProps(arg2)
        local var2 = if sourceInfoErrorAddendumForProps then str1 .. sourceInfoErrorAddendumForProps else str1 .. getDeclarationErrorAddendum()
        local got

        if arg1 == nil then
            got = "nil"
        elseif Array.isArray(arg1) then
            got = "array"
        elseif arg1 ~= nil and typeof(arg1) == "table" and arg1["$$typeof"] == REACT_ELEMENT_TYPE then
            got = string.format("<%s />", getComponentName(arg1.type) or "Unknown")

            var2 ..= " Did you accidentally export a JSX literal or Element instead of a component?"
        else
            got = typeof(arg1)
            if arg1 ~= nil then
                var2 ..= "\n" .. inspect(arg1)
            end
        end

        if ReactGlobals.__DEV__ then
            console.error(
                "React.createElement: type is invalid -- expected a string (for built-in components) or a class/function (for composite components) but got: %s.%s",
                got,
                var2
            )
        end
    end

    local element = createElement(arg1, arg2, ...)

    if element == nil then
        return element
    end

    if var1 then
        local select2 = select

        for i = 1, select2("#", ...) do
            local func1 = validateChildKeys
            local select = select
            func1(select(i, ...), arg1)
        end
    end

    if arg1 == REACT_FRAGMENT_TYPE then
        validateFragmentProps(element)
    else
        validatePropTypes(element)
    end

    return element
end

function module.cloneElementWithValidation(arg1, arg2, ...)
    local tbl2 = { arg1, arg2, ... }
    local var1 = cloneElement(arg1, arg2, ...)
    for i = 3, #tbl2 do
        validateChildKeys(tbl2[i], var1.type)
    end
    validatePropTypes(var1)
    return var1
end

return module
