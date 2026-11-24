-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInvite = script:FindFirstAncestor("GameInvite")
local Context = GameInvite.Context
local GameInviteParent = GameInvite.Parent

local React = require(GameInviteParent.React)
local UIBlox = require(GameInviteParent.UIBlox)
local FFlagGameInviteModalUnlockMouse = require(GameInviteParent.SharedFlags).FFlagGameInviteModalUnlockMouse

local GameInviteModalLayoutContext = require(Context.GameInviteModalLayoutContext)
local GameInviteModalManager = require(GameInvite.GameInviteModalManager)

local useStyle = UIBlox.Core.Style.useStyle
local ImageSet = UIBlox.Core.ImageSet
local Images = UIBlox.App.ImageSet.Images

local rect = Rect.new(8, 8, 9, 9)

return function(arg1)
    local var1 = useStyle()
    local theme = var1.Theme

    local var2 = React.useContext(GameInviteModalLayoutContext)
    local isFullWidth = var2.isFullWidth
    local isFullHeight = var2.isFullHeight
    local modalSize = var2.modalSize
    local var3, var4, str1

    if isFullWidth or isFullHeight then
        var3 = Vector2.new(0.5, 1)

        var4 = UDim2.new(0.5, 0, 1, 0)
        str1 = "component_assets/bullet_17"
    else
        var3 = Vector2.new(0.5, 0.5)

        var4 = UDim2.new(0.5, 0, 0.5, 0)
        str1 = "component_assets/circle_17"
    end

    local createElement = React.createElement
    local imageSetButton = ImageSet.ImageSetButton
    local tbl1 = {
        Selectable = false,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = var1.Theme.Overlay.Color,
        Transparency = var1.Theme.Overlay.Transparency,
        AutoButtonColor = false,
        Modal = if FFlagGameInviteModalUnlockMouse then true else nil,
        ZIndex = 0
    }

    tbl1[React.Event.Activated] = function()
        GameInviteModalManager:closeModal()
    end

    return createElement(imageSetButton, tbl1, {
        GameInviteModalContainer = React.createElement(ImageSet.ImageSetButton, {
            Position = var4,
            Size = modalSize,
            AnchorPoint = var3,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Image = Images[str1],
            ImageColor3 = theme.BackgroundDefault.Color,
            ImageTransparency = theme.BackgroundDefault.Transparency,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = rect,
            AutoButtonColor = false,
            ClipsDescendants = true,
            Selectable = false
        }, arg1.children)
    })
end
