-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditorParent = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor").Parent
local Display = require(AvatarExperienceProfilePictureEditorParent.Display)

local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")

local React = require(AvatarExperienceProfilePictureEditorParent.React)

local function computeGuiInset()
    local shouldUseDeviceSafeInsets = Display.shouldUseDeviceSafeInsets
    local vector2, vector2_2 = GuiService:GetGuiInset()
    local bottomBarSizeY = UserInputService.BottomBarSize.Y
    local bottom = GuiService:GetSafeZoneOffsets().bottom

    local tbl1 = {
        top = if shouldUseDeviceSafeInsets then 0 else UserInputService.StatusBarSize.Y,
        left = vector2.X,
        right = vector2_2.X,
        bottom = 0
    }

    if bottomBarSizeY ~= 0 then
        bottom = bottomBarSizeY
    end

    tbl1.bottom = bottom
    return tbl1
end

return {
    useGuiInset = function()
        local var1, var2 = React.useState(computeGuiInset)

        React.useEffect(function()
            local function updateGuiInset()
                var2((computeGuiInset()))
            end

            local tbl1 = {
                GuiService.SafeZoneOffsetsChanged:Connect(updateGuiInset),
                UserInputService:GetPropertyChangedSignal("StatusBarSize"):Connect(updateGuiInset),
                UserInputService:GetPropertyChangedSignal("BottomBarSize"):Connect(updateGuiInset),
                UserInputService:GetPropertyChangedSignal("RightBarSize"):Connect(updateGuiInset)
            }

            return function()
                for _, value in tbl1 do
                    value:Disconnect()
                end
            end
        end, {})

        return var1
    end,
    computeGuiInset = computeGuiInset
}
