-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CloudClientOffer = script:FindFirstAncestor("CloudClientOffer")
local CloudClientOfferParent = CloudClientOffer.Parent

local Foundation = require(CloudClientOfferParent.Foundation)
local React = require(CloudClientOfferParent.React)

local CloudClientOfferSheetText = require(CloudClientOffer.Components.CloudClientOfferSheetText)
local _createCloudClientOffer = require(CloudClientOffer.createCloudClientOffer)

local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local Sheet = Foundation.Sheet
local FoundationText = Foundation.Text
local View = Foundation.View

local function CloudClientOfferSheet(tbl1)
    local var1 = CloudClientOfferSheetText[tbl1.offerKind]

    local var2 = React.useRef(tbl1.onUnmount)
    var2.current = tbl1.onUnmount
    React.useEffect(function()
        return function()
            local current = var2.current
            if current ~= nil then
                current()
            end
        end
    end, {})

    local tbl2 = {
        Body = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = var1.body,
            tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-default"
        })
    }

    for value, value2 in var1.features do
        local str1 = `Feature{value}`
        tbl2[str1] = React.createElement(FoundationText, {
            LayoutOrder = 1 + value,
            Text = value2,
            tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-emphasis"
        })
    end

    return React.createElement(
        Sheet.Root,
        {
            preferCenterSheet = true,
            onClose = tbl1.onDismiss,
            testId = "cloud-client-offer-sheet"
        },
        {
            Header = React.createElement(Sheet.Header, { hasCloseAffordance = true }, {
                Title = React.createElement(
                    FoundationText,
                    {
                        Text = var1.title,
                        tag = "auto-xy text-heading-medium text-align-x-left content-emphasis"
                    }
                )
            }),
            Content = React.createElement(
                Sheet.Content,
                nil,
                {
                    Layout = React.createElement(View, { tag = "col gap-medium size-full-0 auto-y" }, tbl2)
                }
            ),
            Actions = React.createElement(Sheet.Actions, nil, {
                Layout = React.createElement(View, { tag = "col gap-small size-full-0 auto-y" }, {
                    Accept = React.createElement(Button, {
                        LayoutOrder = 1,
                        text = var1.accept,
                        variant = ButtonVariant.Emphasis,
                        width = UDim.new(1, 0),
                        onActivated = tbl1.onAccept,
                        testId = "cloud-client-offer-sheet-try-now"
                    }),
                    Decline = React.createElement(Button, {
                        LayoutOrder = 2,
                        text = var1.decline,
                        variant = ButtonVariant.Utility,
                        width = UDim.new(1, 0),
                        onActivated = tbl1.onDecline,
                        testId = "cloud-client-offer-sheet-join-without"
                    })
                })
            })
        }
    )
end

return CloudClientOfferSheet
