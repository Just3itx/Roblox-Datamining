-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:40:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InputUiParent = script:FindFirstAncestor("InputUi").Parent
local React = require(InputUiParent.React)

local MemStorageService = game:GetService("MemStorageService")

local function useGamepadConnectedEvent<T>(callback: (...any) -> (...any), callback2: (...any) -> (...any))
    React.useEffect(function()
        local memStorageConnection = MemStorageService:BindAndFire("ActiveGamepadConnected", function(arg1)
            if arg1 == "false" then
                callback2()
                return
            end
            callback()
        end)

        return function()
            memStorageConnection:Disconnect()
        end
    end, { callback, callback2 })
end

return useGamepadConnectedEvent
