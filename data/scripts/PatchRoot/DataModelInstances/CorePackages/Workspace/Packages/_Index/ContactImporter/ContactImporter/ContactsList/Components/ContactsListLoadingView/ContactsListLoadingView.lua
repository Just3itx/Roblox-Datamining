-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local dependencies = require(scriptParentParentParentParent.dependencies)

local t = dependencies.t
local Roact = dependencies.Roact
local UIBlox = dependencies.UIBlox
local withLocalization = dependencies.withLocalization

local FullPageModal = UIBlox.App.Dialog.Modal.FullPageModal
local withStyle = UIBlox.Style.withStyle

local TextKeys = require(scriptParentParentParentParent.Common.TextKeys)
local ContactsGlimmer = require(scriptParentParentParentParent.ContactsList.Components.ContactsGlimmer)

local var1 = Roact.PureComponent:extend("ContactsListLoadingView")

var1.validateProps = t.strictInterface({ screenSize = t.Vector2 })

function var1.render(arg1)
    local screenSize = arg1.props.screenSize
    return withLocalization({ titleText = TextKeys.CONTACTS_LIST_TITLE })(function(arg2)
        return withStyle(function(_)
            return Roact.createElement(FullPageModal, {
                title = arg2.titleText,
                screenSize = screenSize
            }, {
                LoadingViewContainer = Roact.createElement(
                    "Frame",
                    {
                        AutomaticSize = Enum.AutomaticSize.Y,
                        Size = UDim2.new(1, 0, 1, 0),
                        BackgroundTransparency = 1,
                        LayoutOrder = 1
                    },
                    {
                        UIListLayout = Roact.createElement("UIListLayout", {
                            FillDirection = Enum.FillDirection.Vertical,
                            SortOrder = Enum.SortOrder.LayoutOrder,
                            Padding = UDim.new(0, 12),
                            HorizontalAlignment = Enum.HorizontalAlignment.Left
                        }),
                        UIPadding = Roact.createElement("UIPadding", { PaddingTop = UDim.new(0, 24), PaddingBottom = UDim.new(0, 36) }),
                        Glimmer1 = Roact.createElement(ContactsGlimmer, { layoutOrder = 1 }),
                        Glimmer2 = Roact.createElement(ContactsGlimmer, { layoutOrder = 2 }),
                        Glimmer3 = Roact.createElement(ContactsGlimmer, { layoutOrder = 3 })
                    }
                )
            })
        end)
    end)
end

return var1
