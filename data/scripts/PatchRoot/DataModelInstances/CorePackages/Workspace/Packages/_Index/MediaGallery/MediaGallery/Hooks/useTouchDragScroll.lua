-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:51:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local MediaGallery = script:FindFirstAncestor("MediaGallery")
local MediaGalleryParent = MediaGallery.Parent

local React = require(MediaGalleryParent.React)

local _MediaGalleryTypes = require(MediaGallery.MediaGalleryTypes)

local function useTouchDragScroll(tbl1, callback: (...any) -> (...any))
    React.useEffect(function()
        local bool1 = false

        local connection = UserInputService.TouchStarted:Connect(function(touch: InputObject)
            local current = tbl1.current
            if not current then
                return
            end

            local absolutePosition = current.AbsolutePosition
            local absoluteSize = current.AbsoluteSize

            if touch.Position.X >= absolutePosition.X
                and touch.Position.X <= absolutePosition.X + absoluteSize.X
                and touch.Position.Y >= absolutePosition.Y
                and touch.Position.Y <= absolutePosition.Y + absoluteSize.Y
            then
                bool1 = true
            end
        end)

        local connection2 = UserInputService.TouchEnded:Connect(function()
            bool1 = false
        end)

        local connection3 = UserInputService.TouchDrag:Connect(function(dragDirection: Enum.SwipeDirection)
            if not bool1 then
                return
            end

            if dragDirection == Enum.SwipeDirection.Right then
                callback("Left")
                return
            end

            if dragDirection == Enum.SwipeDirection.Left then
                callback("Right")
            end
        end)

        return function()
            connection:Disconnect()
            connection2:Disconnect()
            connection3:Disconnect()
        end
    end, { callback, tbl1 })
end

return useTouchDragScroll
