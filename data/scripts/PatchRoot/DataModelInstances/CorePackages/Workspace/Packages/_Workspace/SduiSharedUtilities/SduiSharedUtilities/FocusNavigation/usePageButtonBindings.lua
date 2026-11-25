-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilitiesParent = script:FindFirstAncestor("SduiSharedUtilities").Parent

local CollectionService = game:GetService("CollectionService")

local React = require(SduiSharedUtilitiesParent.React)
local ReactFocusNavigation = require(SduiSharedUtilitiesParent.ReactFocusNavigation)
local SduiFocusTags = require(script.Parent.SduiFocusTags)

local function usePageButtonBindings(tbl1, arg1, arg2)
    local var1, var2 = React.useState(true)

    React.useEffect(function()
        local function updateSuppression()
            local bool1 = false
            for _, value in CollectionService:GetTagged(SduiFocusTags.SuppressBindings) do
                if tbl1.current and value:IsDescendantOf(tbl1.current) then
                    bool1 = true
                    break
                end
            end

            var2(not bool1)
        end

        updateSuppression()

        local connection = CollectionService:GetInstanceAddedSignal(SduiFocusTags.SuppressBindings):Connect(updateSuppression)
        local connection2 = CollectionService:GetInstanceRemovedSignal(SduiFocusTags.SuppressBindings):Connect(updateSuppression)

        return function()
            connection:Disconnect()
            connection2:Disconnect()
        end
    end, { tbl1 })

    local var3 = React.useRef(nil)
    local var4 = ReactFocusNavigation.useEventMap(not var1 and {} or arg1, var3)
    return (ReactFocusNavigation.useEventHandlerMap(not var1 and {} or arg2, var4))
end

return usePageButtonBindings
