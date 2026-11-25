-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local React = require(ServerDrivenUiParent.React)
local _FocusNavigationUtils = require(ServerDrivenUiParent.FocusNavigationUtils)

local function useTileHoldAction(tbl1, callback: ((...any) -> (...any))?, callback2: ((...any) -> (...any))?)
    local guiObject, var2 = React.useState(nil)
    local var3 = React.useRef(false)

    local bool1 = tbl1 ~= nil
    local tileRef = React.useCallback(function(arg1)
        if callback then
            callback(arg1)
        end

        if bool1 then
            var2(arg1)
        end
    end, { callback, bool1 })

    local onActivated = React.useCallback(function()
        if var3.current then
            return
        end
        if callback2 then
            callback2()
        end
    end, { callback2 })

    local onHoldCompleted = if tbl1 then tbl1.onHoldCompleted else nil

    local onHoldDetected = React.useCallback(function(arg1)
        if onHoldCompleted then
            onHoldCompleted(nil, arg1)
        end
    end, { onHoldCompleted })

    local setDisabledForHold = React.useCallback(function(current: boolean)
        var3.current = current
    end, {})

    return {
        tileRef = tileRef,
        onActivated = onActivated,
        holdDetectorProps = if tbl1 then guiObject
            and {
                guiObject = guiObject,
                onHoldDetected = onHoldDetected,
                setDisabledForHold = setDisabledForHold,
                keyCode = tbl1.keyCode,
                focusNavigationEventName = tbl1.focusNavigationEventName,
                disableRegularActionOnHoldIntent = nil
            }
            or nil else nil
    }
end

return useTileHoldAction
