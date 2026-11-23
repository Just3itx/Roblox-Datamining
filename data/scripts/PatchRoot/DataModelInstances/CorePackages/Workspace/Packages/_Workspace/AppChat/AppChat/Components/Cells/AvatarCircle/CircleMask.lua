-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:10:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent
local Foundation = require(AppChatParent.Foundation)
local React = require(AppChatParent.React)

local useCursor = Foundation.Hooks.useCursor

local tbl1 = {
    Size36x36 = "rbxasset://textures/ui/LuaChat/graphic/gr-profile-border-36x36.png",
    Size48x48 = "rbxasset://textures/ui/LuaChat/graphic/gr-profile-border-48x48.png"
}

local function CircleMask(tbl2)
    local overlaySize = tbl2.overlaySize or "Size36x36"
    local image = tbl1[overlaySize]
    local selectionImageObject = useCursor()

    return React.createElement("ImageButton", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = tbl2.circleInteriorBackgroundColor3,
        BackgroundTransparency = tbl2.circleInteriorBackgroundTransparency,
        BorderSizePixel = 0,
        Image = "",
        SelectionImageObject = selectionImageObject,
        AutoButtonColor = false,
        ClipsDescendants = true,
        [React.Event.Activated] = tbl2.onActivated,
        Selectable = tbl2.selectable,
        LayoutOrder = tbl2.LayoutOrder
    }, {
        imageMask = React.createElement("ImageLabel", {
            Image = image,
            ImageColor3 = tbl2.circleColor3,
            ImageTransparency = tbl2.circleTransparency,
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ZIndex = 2
        }, tbl2.renderAboveMask)
    }, tbl2.children)
end

return CircleMask
