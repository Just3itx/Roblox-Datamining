-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function noOpt() end

return function()
    return function(read)
        assert(read, "expected externalPolicy")

        return {
            read = function()
                return read
            end,
            onPolicyChanged = function(arg2): RBXScriptConnection
                arg2 = arg2 or noOpt
                return Instance.new("BindableEvent").Event:Connect(arg2)
            end
        }
    end
end
