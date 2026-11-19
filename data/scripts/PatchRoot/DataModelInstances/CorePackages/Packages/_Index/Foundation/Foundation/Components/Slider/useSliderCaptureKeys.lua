-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:51:19Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local UserInputService = require(Foundation.Utility.Wrappers.Services).UserInputService

local constants = require(script.Parent.constants)

local function isCaptureKey(keyCode): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return table.find(constants.enter, keyCode) ~= nil or table.find(constants.thumbSwitch, keyCode) ~= nil
end

local function useSliderCaptureKeys(bool1: boolean, current: (...any) -> (...any))
    local var1 = React.useRef(current)
    var1.current = current

    React.useEffect(function()
        if not bool1 then
            return
        end

        local connection = UserInputService.InputBegan:Connect(function(input: InputObject)
            if isCaptureKey(input.KeyCode) then
                var1.current()
            end
        end)
        return function()
            connection:Disconnect()
        end
    end, { bool1 })
end

return useSliderCaptureKeys
