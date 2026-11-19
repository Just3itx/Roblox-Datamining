-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
module.__index = module

function module.new()
    local bindableEvent = Instance.new("BindableEvent")

    local tbl1 = {
        FullscreenChanged = {
            Connect = function(_, arg1): RBXScriptConnection
                return bindableEvent.Event:Connect(arg1)
            end,
            GoFullscreen = function()
                bindableEvent:Fire(true)
            end
        }
    }

    setmetatable(tbl1, { __index = module })

    return tbl1
end

function module.InFullScreen(_): boolean
    return false
end

return module
