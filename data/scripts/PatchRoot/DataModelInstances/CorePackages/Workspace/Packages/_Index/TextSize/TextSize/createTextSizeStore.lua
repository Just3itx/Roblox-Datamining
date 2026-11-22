-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserGameSettings = UserSettings():GetService("UserGameSettings")

local TextSizeParent = script:FindFirstAncestor("TextSize").Parent
local Foundation = require(TextSizeParent.Foundation)
local Signals = require(TextSizeParent.Signals)

local function createTextSizeStore()
    local getTextSizeOffset, var2 = Signals.createSignal(Foundation.Utility.getTextSizeOffset() or 0)
    local connection = UserGameSettings:GetPropertyChangedSignal("PreferredTextSize"):Connect(function()
        var2(Foundation.Utility.getTextSizeOffset() or 0)
    end)

    return {
        getTextSizeOffset = getTextSizeOffset,
        cleanup = function()
            if connection then
                connection:Disconnect()
                connection = nil
            end
        end
    }
end
return createTextSizeStore
