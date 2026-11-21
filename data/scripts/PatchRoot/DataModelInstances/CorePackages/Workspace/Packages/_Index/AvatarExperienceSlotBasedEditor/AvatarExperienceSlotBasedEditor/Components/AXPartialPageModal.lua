-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSlotBasedEditorParent = script:FindFirstAncestor("AvatarExperienceSlotBasedEditor").Parent

local React = require(AvatarExperienceSlotBasedEditorParent.React)
local UIBlox = require(AvatarExperienceSlotBasedEditorParent.UIBlox)
local ModalWindow = UIBlox.App.Dialog.Modal.ModalWindow
local ButtonStack = UIBlox.App.Button.ButtonStack
local Foundation = require(AvatarExperienceSlotBasedEditorParent.Foundation)
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local function isFullWidth(vector2: Vector2): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return vector2.X <= 540
end

local function AXPartialPageModal(tbl1)
    local var1 = useTokens()
    local screenSize = tbl1.screenSize
    local medium = var1.Margin.Medium
    local large = var1.Margin.Large
    local var2 = tbl1.bottomPadding or UDim.new(0, medium)

    if not isFullWidth(screenSize) then
        var2 = UDim.new(0, medium)
    end

    local createElement = React.createElement
    local tbl2 = {
        Text = "",
        AutoButtonColor = false,
        Selectable = false,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1
    }

    tbl2[React.Event.Activated] = function() end
    tbl2.ZIndex = 3
    return createElement("TextButton", tbl2, {
        PartialPageModal = React.createElement(
            ModalWindow,
            {
                isFullHeight = false,
                screenSize = screenSize,
                position = tbl1.position,
                anchorPoint = tbl1.anchorPoint
            },
            {
                ContentContainer = React.createElement(View, {
                    tag = "auto-y size-full-0 align-x-left col padding-top-medium padding-x-xxlarge padding-top-xxlarge",
                    Position = UDim2.new(0, 0, 0, large),
                    backgroundStyle = var1.Color.Surface.Surface_100,
                    padding = { bottom = var2 }
                }, {
                    Content = React.createElement(View, { tag = "auto-y size-full-0" }, tbl1.children),
                    Buttons = tbl1.buttonStackProps and React.createElement(ButtonStack, tbl1.buttonStackProps)
                })
            }
        )
    })
end
return AXPartialPageModal
