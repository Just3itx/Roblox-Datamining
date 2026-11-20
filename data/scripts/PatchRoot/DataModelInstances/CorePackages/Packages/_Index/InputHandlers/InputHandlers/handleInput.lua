-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:39:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _FocusNavigation = require(scriptParentParent.FocusNavigation)

local Heartbeat = require(script.Parent.Heartbeat)

local function cancellableDelay(durationSeconds, callback)
    local bool1 = false
    task.delay(durationSeconds, function()
        if not bool1 then
            callback()
        end
    end)
    return {
        cancel = function()
            bool1 = true
        end
    }
end

local function handleInput(tbl1)
    local hold = tbl1.hold
    local var1 = nil
    local connection = nil

    local bool1 = false

    local function clearHeldState() -- Luacid: Inlined by compiler; 4 call sites recovered
        if var1 then
            var1.cancel()
            var1 = nil
        end
        if connection then
            connection:Disconnect()
            connection = nil
        end
        bool1 = false
    end

    return function(arg1)
        local eventData = arg1.eventData
        local immediateDispatch = if eventData then eventData.immediateDispatch or false else false
        bool1 = immediateDispatch or bool1
        local userInputState = if eventData then eventData.UserInputState else nil

        if userInputState == Enum.UserInputState.Begin then
            if tbl1.onPress then
                tbl1.onPress(arg1)
            end

            clearHeldState()

            if hold then
                if immediateDispatch then
                    hold.onComplete()
                else
                    var1 = cancellableDelay(hold.durationSeconds, function()
                        if not hold.allowReleaseAfterHold then
                            bool1 = false
                        end
                        hold.onComplete()
                        if connection then
                            connection:Disconnect()
                            connection = nil
                        end
                    end)
                    connection = if hold.onStep then Heartbeat:Connect(hold.onStep) else nil
                end
            end

            if immediateDispatch then
                clearHeldState()
            else
                bool1 = true
            end
        end

        if userInputState == Enum.UserInputState.End then
            if tbl1.onRelease and bool1 then
                tbl1.onRelease(arg1)
            end

            clearHeldState()
        end

        if userInputState == Enum.UserInputState.Cancel then
            clearHeldState()
        end
    end
end

return handleInput
