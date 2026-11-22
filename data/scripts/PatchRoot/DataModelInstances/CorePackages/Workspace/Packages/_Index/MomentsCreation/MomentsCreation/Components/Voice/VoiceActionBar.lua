-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Foundation = require(MomentsCreationParent.Foundation)
local React = require(MomentsCreationParent.React)

local Button = Foundation.Button
local IconButton = Foundation.IconButton
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local IconName = Foundation.Enums.IconName
local InputSize = Foundation.Enums.InputSize
local size = if require(MomentsCreation.Flags.FFlagMomentsTTSCompactActionBar) then InputSize.Medium else InputSize.Large

local function VoiceActionBar(tbl1)
    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.layoutOrder,
            tag = "row align-y-center gap-small size-full-0 auto-y"
        },
        {
            Primary = React.createElement(View, { LayoutOrder = 1, tag = "fill auto-y" }, {
                ButtonBounds = React.createElement("Frame", {
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 0),
                    ref = tbl1.primaryRef
                }, {
                    Button = React.createElement(Button, {
                        fillBehavior = FillBehavior.Fill,
                        isDisabled = tbl1.primaryIsDisabled,
                        isLoading = tbl1.primaryIsLoading,
                        onActivated = tbl1.primaryOnActivated,
                        size = size,
                        text = tbl1.primaryText,
                        variant = tbl1.primaryVariant,
                        width = UDim.new(1, 0)
                    })
                })
            }),
            Delete = React.createElement(
                "Frame",
                {
                    AutomaticSize = Enum.AutomaticSize.XY,
                    BackgroundTransparency = 1,
                    LayoutOrder = 2,
                    ref = tbl1.deleteRef
                },
                {
                    IconButton = React.createElement(
                        IconButton,
                        {
                            icon = IconName.TrashCan,
                            onActivated = tbl1.onDelete,
                            size = size,
                            variant = ButtonVariant.Standard
                        }
                    )
                }
            )
        }
    )
end

return VoiceActionBar
