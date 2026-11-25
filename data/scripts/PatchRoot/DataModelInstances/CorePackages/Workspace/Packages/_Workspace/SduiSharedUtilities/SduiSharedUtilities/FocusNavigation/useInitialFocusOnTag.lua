-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:50:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilitiesParent = script:FindFirstAncestor("SduiSharedUtilities").Parent

local CollectionService = game:GetService("CollectionService")

local React = require(SduiSharedUtilitiesParent.React)
local ReactFocusNavigation = require(SduiSharedUtilitiesParent.ReactFocusNavigation)
local Responsive = require(SduiSharedUtilitiesParent.Responsive)
local FFlagLuaAppMediaGalleryGamepadSupport = require(SduiSharedUtilitiesParent.SharedFlags).FFlagLuaAppMediaGalleryGamepadSupport

local function useInitialFocusOnTag(tag: string, tbl1)
    local bool1 = if FFlagLuaAppMediaGalleryGamepadSupport then Responsive.useLastInput() == Responsive.Input.Directional else Responsive.usePreferredInput() == Responsive.Input.Directional
    local var1 = ReactFocusNavigation.useFocusGuiObject()
    local var2 = React.useRef(false)

    React.useEffect(function()
        if not bool1 then
            return
        end

        local current = tbl1.current
        if not current then
            return
        end

        for _, value in CollectionService:GetTagged(tag) do
            if not var2.current and value:IsDescendantOf(current) then
                var2.current = true
                var1(value)
                return
            end
        end

        local connection = CollectionService:GetInstanceAddedSignal(tag):Connect(function(arg1)
            if not var2.current and current and arg1:IsDescendantOf(current) then
                var2.current = true
                var1(arg1)
            end
        end)

        return function()
            connection:Disconnect()
        end
    end, { bool1, tag, var1 })
end

return useInitialFocusOnTag
