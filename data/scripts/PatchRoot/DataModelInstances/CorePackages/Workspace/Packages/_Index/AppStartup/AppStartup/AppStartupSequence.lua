-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ScriptContext = game:GetService("ScriptContext")
local engineFeature = game:GetEngineFeature("LuaAppCompression")
local AppStartupParent = script:FindFirstAncestor("AppStartup").Parent
local Signal = require(AppStartupParent.AppCommonLib).Signal

local module = ({})

module.__index = module

function module.new()
    local tbl1 = {
        changed = Signal.new(),
        isInteractive = false
    }

    setmetatable(tbl1, module)
    return tbl1
end

function module:setInteractive()
    if self.isInteractive then
        return
    end
    self.isInteractive = true

    if engineFeature then
        ScriptContext:CompressLuaApp()
    end

    self.changed:fire()
end

module.default = module.new()

return module
