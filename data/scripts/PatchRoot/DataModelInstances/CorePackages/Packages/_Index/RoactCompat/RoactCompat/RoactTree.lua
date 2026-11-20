-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)
local inspect = require(scriptParentParent.LuauPolyfill).util.inspect
local ReactRoblox = require(scriptParentParent.ReactRoblox)

local warnOnce = require(script.Parent.warnOnce)

return {
    mount = function(arg1, parent, key: string?)
        if ReactGlobals.__DEV__ and ReactGlobals.__COMPAT_WARNINGS__ then
            warnOnce("mount", "Please use the createRoot API in ReactRoblox")
        end

        if parent ~= nil and typeof(parent) ~= "Instance" then
            local error = error
            local format = string.format
            local str2 = "Cannot mount element (`%s`) into a parent that is not a Roblox Instance (got type `%s`) \n%s"
            local var1 = if arg1 then tostring(arg1.type) else "<unknown>"

            error(format(str2, var1, typeof(parent), (function()
                if parent ~= nil then
                    return inspect(parent)
                end
                return ""
            end)()))
        end

        local root = if _G.__ROACT_17_COMPAT_LEGACY_ROOT__ then ReactRoblox.createLegacyRoot(Instance.new("Folder")) else ReactRoblox.createRoot(Instance.new("Folder"))

        if parent == nil then
            local target = Instance.new("Folder")
            target.Name = "Target"
            parent = target
        end
        if key == nil then
            key = if _G.__ROACT_17_COMPAT_LEGACY_ROOT__ then "ReactLegacyRoot" else "ReactRoot"
        end

        if ReactGlobals.__ROACT_17_INLINE_ACT__ then
            ReactRoblox.act(function()
                root:render(ReactRoblox.createPortal({ [key] = arg1 }, parent))
            end)
        else
            local createPortal = ReactRoblox.createPortal
            local tbl1 = {
                [key] = arg1
            }
            root:render(createPortal(tbl1, parent))
        end

        return { root = root, parent = parent, key = key }
    end,
    update = function(tbl1, arg1)
        if ReactGlobals.__DEV__ and ReactGlobals.__COMPAT_WARNINGS__ then
            warnOnce("update", "Please use the createRoot API in ReactRoblox")
        end

        local key = tbl1.key
        local parent = tbl1.parent

        if ReactGlobals.__ROACT_17_INLINE_ACT__ then
            ReactRoblox.act(function()
                tbl1.root:render(ReactRoblox.createPortal({ [key] = arg1 }, parent))
            end)

            return tbl1
        end

        tbl1.root:render(ReactRoblox.createPortal({ [key] = arg1 }, parent))

        return tbl1
    end,
    unmount = function(tbl1)
        if ReactGlobals.__DEV__ and ReactGlobals.__COMPAT_WARNINGS__ then
            warnOnce("unmount", "Please use the createRoot API in ReactRoblox")
        end

        if ReactGlobals.__ROACT_17_INLINE_ACT__ then
            ReactRoblox.act(function()
                tbl1.root:unmount()
            end)

            return
        end

        tbl1.root:unmount()
    end
}
