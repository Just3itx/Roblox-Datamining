-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StarterGui = game:GetService("StarterGui")

local Lifecycle = require(script.Parent.Lifecycle)

local FeatureName = require(script.Parent.FeatureName)

local tbl1 = {}
tbl1.__index = tbl1

function tbl1.new(tbl2)
    local self = (setmetatable({}, tbl1))

    local var1 = nil
    local coreGuiType = nil

    if tbl2 then
        coreGuiType = tbl2.coreGuiType

        local defaultEnabled = tbl2.defaultEnabled or false
        if coreGuiType then
            defaultEnabled = StarterGui:GetCoreGuiEnabled(coreGuiType)
        end

        var1 = {
            defaultVisible = tbl2.defaultVisible or false,
            defaultEnabled = defaultEnabled
        }
    end

    local lifecycle = Lifecycle.new(var1)
    self.lifecycle = lifecycle

    if coreGuiType then
        self._coreGuiConnection = StarterGui.CoreGuiChangedSignal:Connect(function(coreGuiType2: Enum.CoreGuiType, enabled: boolean)
            if coreGuiType2 == coreGuiType or coreGuiType2 == Enum.CoreGuiType.All then
                lifecycle.setEnabled(enabled)
            end
        end)
    end

    return self
end

function tbl1:dispose()
    if self._coreGuiConnection then
        self._coreGuiConnection:Disconnect()
        self._coreGuiConnection = nil
    end
    self.lifecycle:dispose()
end

local tbl2 = ({})

local module = { FeatureName = FeatureName }

function module.registerLifecycle(arg1, tbl3)
    assert(not tbl2[arg1], `Feature "{arg1}" already has a registered lifecycle`)

    local var1 = tbl1.new(tbl3)
    tbl2[arg1] = var1
    return var1
end

function module.getFeature(arg1)
    return tbl2[arg1]
end

function module.getVisibility(arg1)
    local var1 = tbl2[arg1]
    if var1 then
        return var1.lifecycle.getVisible(false)
    end
    return false
end

function module.setVisibility(arg1, bool1: boolean)
    local var1 = tbl2[arg1]
    if var1 then
        var1.lifecycle.setVisible(bool1)
    end
end

function module.toggleVisibility(arg1)
    local var1 = tbl2[arg1]
    if var1 then
        var1.lifecycle.setVisible(not var1.lifecycle.getVisible(false))
    end
end

function module.setEnabled(arg1, bool1: boolean)
    local var1 = tbl2[arg1]
    if var1 then
        var1.lifecycle.setEnabled(bool1)
    end
end

function module.onVisibilityChanged(arg1, func1: (...any) -> (...any))
    local var1 = tbl2[arg1]
    if var1 then
        return var1.lifecycle:onVisibilityChanged(func1)
    end
    return function() end
end

function module.onEnabledChanged(arg1, func1: (...any) -> (...any))
    local var1 = tbl2[arg1]
    if var1 then
        return var1.lifecycle:onEnabledChanged(func1)
    end
    return function() end
end

return module
