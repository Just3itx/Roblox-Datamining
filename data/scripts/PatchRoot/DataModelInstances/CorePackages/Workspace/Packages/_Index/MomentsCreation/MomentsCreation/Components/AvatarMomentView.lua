-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:50:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationParent = script:FindFirstAncestor("MomentsCreation").Parent

local Foundation = require(MomentsCreationParent.Foundation)
local React = require(MomentsCreationParent.React)

local View = Foundation.View

local function AvatarMomentView(tbl1)
    return React.createElement(View, {
        tag = "size-full",
        onAbsoluteSizeChanged = tbl1.onAbsoluteSizeChanged
    }, {
        Media = React.createElement(
            "ViewportFrame",
            {
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1),
                ref = tbl1.viewportFrameRef
            },
            {
                WorldModel = React.createElement("WorldModel", { ref = tbl1.worldModelRef })
            }
        ),
        Overlay = React.createElement(View, { tag = "size-full", ZIndex = 2 }, tbl1.children)
    })
end

return AvatarMomentView
