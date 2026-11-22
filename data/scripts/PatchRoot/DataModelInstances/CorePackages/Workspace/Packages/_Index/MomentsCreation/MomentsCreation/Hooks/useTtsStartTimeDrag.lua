-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local React = require(MomentsCreationParent.React)

local useCallback = React.useCallback
local useEffect = React.useEffect
local useRef = React.useRef
local useState = React.useState

local clampTtsStartTime = require(MomentsCreation.Utils.clampTtsStartTime)

local function useTtsStartTimeDrag(bool1: boolean, num1: number, current: number, callback: (...any) -> (...any), callback2: ((...any) -> (...any))?, callback3: ((...any) -> (...any))?)
    local dragDetectorRef = useRef(nil)
    local var2 = useRef(false)
    local isSelected, var4 = useState(false)

    local var5 = useRef(current)
    local var6 = useRef(0)

    useEffect(function()
        var5.current = current
    end, { current })

    local var7 = useCallback(function()
        if var2.current then
            return
        end
        var2.current = true
        var6.current = var5.current
        var4(true)
        if callback2 ~= nil then
            callback2()
        end
    end, { callback2 })

    local var8 = useCallback(function()
        if not var2.current then
            return
        end
        local current = dragDetectorRef.current
        if current == nil or num1 <= 0 then
            return
        end
        local var8 = current.DragUDim2.X.Scale * num1
        callback(clampTtsStartTime(var6.current + var8, num1))
    end, { num1, callback })

    local var9 = useCallback(function()
        if not var2.current then
            return
        end
        var2.current = false
        var4(false)
        if callback3 ~= nil then
            callback3(false)
        end
    end, { callback3 })

    useEffect(function()
        if not bool1 then
            return
        end
        local current = dragDetectorRef.current
        if current == nil then
            return
        end
        local tbl1 = { current.DragStart:Connect(var7), current.DragContinue:Connect(var8), current.DragEnd:Connect(var9) }

        return function()
            for _, value in tbl1 do
                value:Disconnect()
            end

            if not var2.current then
                return
            end

            var2.current = false
            var4(false)
            if callback3 ~= nil then
                callback3(true)
            end
        end
    end, {
        bool1,
        var7,
        var8,
        var9,
        callback3
    })
    return { dragDetectorRef = dragDetectorRef, isSelected = isSelected }
end

return useTtsStartTimeDrag
