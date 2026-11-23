-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:40:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local useBinding = React.useBinding
local useContext = React.useContext
local useEffect = React.useEffect

local useLayerCollector = require(AppChatParent.UIBlox).Core.Layout.LayerCollector.useLayerCollector

local Responsive = require(AppChatParent.Responsive)
local useOrientation = Responsive.useOrientation

local ParentContainerContext = require(AppChat.Contexts.ParentContainer.ParentContainerContext)
local getFFlagAppChatInExperienceTabBarAdjustment = require(AppChat.Flags.getFFlagAppChatInExperienceTabBarAdjustment)

local function useParentContainerExtents()
    local var1 = useContext(ParentContainerContext).getParentContainer()
    local var2 = useLayerCollector()
    local var3 = if getFFlagAppChatInExperienceTabBarAdjustment() then nil else useOrientation()
    local var4, var5 = useBinding(if var1 then var1.AbsoluteSize else Vector2.zero)

    local var6, var7 = useBinding(if var1 then var1.AbsolutePosition else Vector2.zero)
    local bool1 = if getFFlagAppChatInExperienceTabBarAdjustment() then nil else var3 == Responsive.Keys.Landscape

    useEffect(function()
        if not var1 then
            return function() end
        end

        local connection = nil

        local function func1(arg1, zero: Vector2, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
            return Vector2.new(math.clamp(arg1.X, zero.X, arg2.X), math.clamp(arg1.Y, zero.Y, arg2.Y))
        end

        local function func2()
            local absoluteSize = var1.AbsoluteSize
            local absolutePosition = var1.AbsolutePosition
            local absoluteSize2 = var2.absoluteSize
            local zero = Vector2.zero

            if not getFFlagAppChatInExperienceTabBarAdjustment() and bool1 then
                zero = Vector2.new(0, GuiService:GetSafeZoneOffsets().bottom)
            end

            local var8 = absoluteSize2 - zero

            local var9 = func1(absolutePosition, Vector2.zero, var8)

            local var10 = func1(absoluteSize, Vector2.zero, var8 - var9)

            var5(var10)
            var7(var9)
        end

        local connection2 = var1:GetPropertyChangedSignal("AbsoluteSize"):Connect(func2)

        local connection3 = var1:GetPropertyChangedSignal("AbsolutePosition"):Connect(func2)
        if not getFFlagAppChatInExperienceTabBarAdjustment() then
            connection = GuiService.SafeZoneOffsetsChanged:Connect(func2)
        end

        func2()

        return function()
            if connection2 and connection2.Connected then
                connection2:Disconnect()
            end
            if connection3 and connection3.Connected then
                connection3:Disconnect()
            end
            if not getFFlagAppChatInExperienceTabBarAdjustment() and connection and connection.Connected then
                connection:Disconnect()
            end
        end
    end, {
        var1,
        var5,
        var7,
        var2.absoluteSize,
        bool1
    })

    return var4, var6
end

return useParentContainerExtents
