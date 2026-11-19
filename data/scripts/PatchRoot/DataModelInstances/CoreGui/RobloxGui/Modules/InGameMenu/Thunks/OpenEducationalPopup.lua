-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local OpenNativeClosePrompt = require(scriptParentParent.Actions.OpenNativeClosePrompt)

return function(guiService, arg1, arg2)
    local function getDisplayCount(): number -- Luacid: Inlined by compiler; 1 call site recovered
        return tonumber(arg1:GetItem("NativeCloseLuaPromptDisplayCount")) or 0
    end

    local function setDisplayCount(num1: number) -- Luacid: Inlined by compiler; 1 call site recovered
        arg1:SetItem("NativeCloseLuaPromptDisplayCount", tostring(num1))
        arg1:flush()
    end

    local notificationTypeList = guiService:GetNotificationTypeList()

    return function(arg3)
        local closingApp = arg3:getState().nativeClosePrompt.closingApp
        local displayCount = getDisplayCount()

        if closingApp or arg2 <= displayCount then
            guiService:BroadcastNotification("", notificationTypeList.NATIVE_EXIT)
            return
        end
        arg3:dispatch(OpenNativeClosePrompt())
        setDisplayCount(displayCount + 1)
    end
end
