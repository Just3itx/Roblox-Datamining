-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local _Types = require(Foundation.Components.Types)

local React = require(FoundationParent.React)
local Signal = require(FoundationParent.Signal)

local function createSignal()
    local var1, fire = Signal.createSignal()

    local signal = ({})

    function signal.Connect(_, func1: (...any) -> (...any))
        local var3 = var1:subscribe(func1)

        return {
            Disconnect = function()
                var3:unsubscribe()
            end
        }
    end

    return { signal = signal, fire = fire }
end

local tbl1 = ({})
tbl1.__index = tbl1

function tbl1.new(vector2: Vector2, vector2_2: Vector2)
    local self = setmetatable({ AbsolutePosition = vector2, AbsoluteSize = vector2_2, _signals = {} }, tbl1)

    self._signals.AbsolutePosition = createSignal()
    self._signals.AbsoluteSize = createSignal()

    return self
end

function tbl1:GetPropertyChangedSignal(str1: string)
    if self._signals[str1] then
        return self._signals[str1].signal
    end
    error(`{str1} is not a valid property name.`)
end

function tbl1:SetPosition(vector2: Vector2)
    if self.AbsolutePosition ~= vector2 then
        self.AbsolutePosition = vector2
        self._signals.AbsolutePosition.fire(vector2)
    end
end

function tbl1:SetSize(vector2: Vector2)
    if self.AbsoluteSize ~= vector2 then
        self.AbsoluteSize = vector2
        self._signals.AbsoluteSize.fire(vector2)
    end
end

function useMeasurableRef(vector2: Vector2, vector2_2: Vector2?)
    local var1 = React.useRef(nil)
    if var1.current == nil then
        var1.current = tbl1.new(vector2, vector2_2 or Vector2.one)
    end

    React.useEffect(function()
        var1.current:SetPosition(vector2)
    end, { vector2 })

    React.useEffect(function()
        var1.current:SetSize(vector2_2 or Vector2.one)
    end, { vector2_2 })

    return var1
end

return useMeasurableRef
