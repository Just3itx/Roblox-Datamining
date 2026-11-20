-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)

local console = require(scriptParentParent.Shared).console

local tbl1 = ({})

local function warnNoop(arg1, str1: string) -- Luacid: unused: defined but never referenced
    if not ReactGlobals.__DEV__ then
        return
    end

    local __componentName = arg1.__componentName or "ReactClass"
    local var1 = __componentName .. "." .. str1
    if tbl1[var1] then
        return
    end

    console.error(
        "Can't call %s on a component that is not yet mounted. This is a no-op, but it might indicate a bug in your application. Instead, assign to `self.state` directly with the desired state in the %s component's `init` method.",
        str1,
        __componentName
    )

    tbl1[var1] = true
end

return {
    isMounted = function(_): boolean
        return false
    end,
    enqueueForceUpdate = function(arg1, _, _)
        if not ReactGlobals.__DEV__ then
            return
        end

        local __componentName = arg1.__componentName or "ReactClass"
        local var1 = __componentName .. ".forceUpdate"
        if tbl1[var1] then
            return
        end

        console.error(
            "Can't call %s on a component that is not yet mounted. This is a no-op, but it might indicate a bug in your application. Instead, assign to `self.state` directly with the desired state in the %s component's `init` method.",
            "forceUpdate",
            __componentName
        )

        tbl1[var1] = true
    end,
    enqueueReplaceState = function(arg1, _, _, _)
        if not ReactGlobals.__DEV__ then
            return
        end

        local __componentName = arg1.__componentName or "ReactClass"
        local var1 = __componentName .. ".replaceState"
        if tbl1[var1] then
            return
        end

        console.error(
            "Can't call %s on a component that is not yet mounted. This is a no-op, but it might indicate a bug in your application. Instead, assign to `self.state` directly with the desired state in the %s component's `init` method.",
            "replaceState",
            __componentName
        )

        tbl1[var1] = true
    end,
    enqueueSetState = function(arg1, _, _, _)
        if not ReactGlobals.__DEV__ then
            return
        end

        local __componentName = arg1.__componentName or "ReactClass"
        local var1 = __componentName .. ".setState"
        if tbl1[var1] then
            return
        end

        console.error(
            "Can't call %s on a component that is not yet mounted. This is a no-op, but it might indicate a bug in your application. Instead, assign to `self.state` directly with the desired state in the %s component's `init` method.",
            "setState",
            __componentName
        )

        tbl1[var1] = true
    end
}
