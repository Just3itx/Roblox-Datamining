-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilitiesParent = script:FindFirstAncestor("SduiSharedUtilities").Parent

local React = require(SduiSharedUtilitiesParent.React)
local getSduiClientPageScope = require(SduiSharedUtilitiesParent.SduiCoreSystem).getSduiClientPageScope

local function usePublishContainerWidth(str1: string, callback: ((...any) -> (...any))?)
    local var1 = React.useRef(nil)
    return React.useCallback(function(arg1)
        if callback then
            callback(arg1)
        end

        if var1.current then
            var1.current:Disconnect()
            var1.current = nil
        end
        if not arg1 then
            return
        end

        local sduiClientPageScope = getSduiClientPageScope(str1)

        local var2 = nil
        local function publishWidth() -- Luacid: Inlined by compiler; 1 call site recovered
            local absoluteSizeX = arg1.AbsoluteSize.X
            if absoluteSizeX ~= var2 then
                var2 = absoluteSizeX
                sduiClientPageScope.set("containerWidth", absoluteSizeX)
            end
        end

        publishWidth()
        var1.current = arg1:GetPropertyChangedSignal("AbsoluteSize"):Connect(publishWidth)
    end, { str1, callback })
end

return usePublishContainerWidth
